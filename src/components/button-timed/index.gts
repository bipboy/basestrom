/**
 * ButtonTimed component - complete port from baseweb button-timed.
 *
 * A button that displays a countdown timer and automatically triggers its
 * action when the timer expires. The user can also click the button to
 * immediately trigger the action. Useful for auto-redirect, undo windows,
 * or timed confirmations.
 *
 * Features:
 * - Countdown timer displayed inline as `(M:SS)`
 * - Animated progress overlay sweeping left-to-right
 * - Auto-triggers `onClick` when timer reaches zero
 * - Supports `paused` state to freeze the countdown
 * - Composes with Button (inherits kind, disabled, loading, enhancers)
 * - Always renders at SIZE.large with SHAPE.default (per baseweb spec)
 * - Override support for `root`, `timerContainer`, `startEnhancer`,
 *   `endEnhancer`, and `spinner` subcomponents
 *
 * @example Basic usage - auto-redirect after 10 seconds
 * ```gts
 * import ButtonTimed from 'basestrom/components/button-timed';
 *
 * <template>
 *   <ButtonTimed
 *     @initialTime={{10}}
 *     @onClick={{this.handleRedirect}}
 *   >
 *     Redirecting
 *   </ButtonTimed>
 * </template>
 * ```
 *
 * @example Paused state
 * ```gts
 * <ButtonTimed
 *   @initialTime={{30}}
 *   @paused={{this.isPaused}}
 *   @onClick={{this.handleAction}}
 *   @kind="secondary"
 * >
 *   Processing
 * </ButtonTimed>
 * ```
 *
 * @example With overrides
 * ```gts
 * import * as stylex from '@stylexjs/stylex';
 *
 * const overrides = stylex.create({
 *   root: { borderRadius: '999px' },
 *   timerContainer: { fontWeight: 'bold' },
 * });
 *
 * <ButtonTimed
 *   @initialTime={{15}}
 *   @onClick={{this.handleClick}}
 *   @overrides={{overrides}}
 * >
 *   Confirm
 * </ButtonTimed>
 * ```
 *
 * @example With enhancers
 * ```gts
 * <ButtonTimed
 *   @initialTime={{5}}
 *   @onClick={{this.handleUndo}}
 * >
 *   <:startEnhancer>
 *     <IconUndo />
 *   </:startEnhancer>
 *   <:default>
 *     Undo
 *   </:default>
 * </ButtonTimed>
 * ```
 */
import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import Button, {
  KIND,
  SHAPE,
  SIZE,
  type ButtonKind,
  type ButtonOverrides,
} from '../button/index.gts';
import { styles } from './styles.stylex';
import {
  type ButtonTimedOverrides,
  type ButtonTimedSignature,
} from './types';

// Re-export types and constants
export { KIND, SHAPE, SIZE, type ButtonTimedOverrides, type ButtonTimedSignature };

// ─── Utilities ───────────────────────────────────────────────────────────────

/**
 * Pad a number to 2 digits with leading zero.
 * @param num - Number to pad
 * @returns Zero-padded string
 */
function padTo2Digits(num: number): string {
  return num.toString().padStart(2, '0');
}

/**
 * Format milliseconds as `M:SS` countdown string.
 * If there are remaining milliseconds beyond whole seconds, rounds up
 * so the display never shows "0:00" while time is still ticking.
 *
 * @param totalMilliseconds - Time remaining in milliseconds
 * @returns Formatted string like "1:05" or "0:03"
 */
function formatTime(totalMilliseconds: number): string {
  let totalSeconds = Math.floor(totalMilliseconds / 1000);

  // If there are remaining milliseconds, consider it as an extra second.
  if (totalMilliseconds % 1000 > 0) {
    totalSeconds += 1;
  }

  const minutes = Math.floor(totalSeconds / 60);
  const seconds = Math.floor(totalSeconds % 60);
  return `${minutes}:${padTo2Digits(seconds)}`;
}

// ─── Component ───────────────────────────────────────────────────────────────

export default class ButtonTimed extends Component<ButtonTimedSignature> {
  /**
   * Time remaining in milliseconds. Decrements every 100ms while running.
   */
  @tracked timeRemaining: number;

  /**
   * Timestamp (Date.now()) when the timer was last started/resumed.
   * Used to calculate elapsed time accurately without drift.
   */
  @tracked private startTime: number;

  /**
   * Elapsed seconds at mount time. Used for the static animation-delay.
   * This is set once in the constructor and never changes, ensuring the
   * inline style remains static and doesn't restart the CSS animation.
   */
  private initialElapsedSeconds: number = 0;

  /** Interval handle for the 100ms tick. */
  private intervalId: ReturnType<typeof setInterval> | null = null;

  /** Tracks the previous paused state to detect transitions. */
  private previousPaused: boolean;

  constructor(owner: any, args: ButtonTimedSignature['Args']) {
    super(owner, args);

    const initialTimeMs = this.args.initialTime * 1000;
    this.timeRemaining = initialTimeMs;
    this.startTime = Date.now();
    this.previousPaused = this.args.paused ?? false;

    // Don't start the interval if initially paused
    if (!this.previousPaused) {
      this.startInterval();
    }

    registerDestructor(this, () => {
      this.stopInterval();
    });
  }

  // ─── Computed Properties ─────────────────────────────────────────────────

  /** Initial time converted to milliseconds. */
  get initialTimeMs(): number {
    return this.args.initialTime * 1000;
  }

  /** Whether the timer is currently paused. */
  get isPaused(): boolean {
    return this.args.paused ?? false;
  }

  /** Whether the timer has reached zero. */
  get isExpired(): boolean {
    return this.timeRemaining === 0;
  }

  /** Button is disabled when explicitly disabled OR when timer has expired. */
  get isDisabled(): boolean {
    return (this.args.disabled ?? false) || this.isExpired;
  }

  /** Resolved button kind, defaults to primary. */
  get kind(): ButtonKind {
    return this.args.kind ?? 'primary';
  }

  /**
   * Inline style string for the button root element.
   * Sets CSS custom properties that the ::after pseudo-element references.
   *
   * CRITICAL: This style is STATIC after initial render. It does NOT depend
   * on timeRemaining, so it won't change on every 100ms tick. This prevents
   * the browser from restarting the CSS animation on each re-render.
   *
   * - animationDuration = full initialTime (the total countdown duration)
   * - animationDelay = negative elapsed time at mount (starts animation partway through)
   *
   * The keyframes are a simple linear sweep from full bar to empty bar.
   * The negative delay makes the animation "jump ahead" to the correct position.
   */
  get rootInlineStyle(): string | undefined {
    if (this.args.initialTime <= 0) return undefined;
    // Use initialTime for duration (static) and initialElapsedSeconds for delay (static).
    // Both values are set once at construction and don't change on tick.
    return `--bst-timer-duration:${this.args.initialTime}s;--bst-timer-delay:-${this.initialElapsedSeconds}s`;
  }

  /**
   * Formatted countdown string displayed in the button, e.g. "(0:15)".
   */
  get formattedTime(): string {
    return `(${formatTime(this.timeRemaining)})`;
  }

  // ─── Styles ──────────────────────────────────────────────────────────────

  /**
   * Root class name combining the timer overlay styles with any consumer overrides.
   * This is applied directly to the wrapping element around Button.
   */
  get rootClassName(): string | undefined {
    const baseResolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const timerStyle = this.args.initialTime > 0 ? styles.timerOverlay : null;
    const playState = this.isPaused ? styles.timerPaused : styles.timerRunning;

    const { className } = stylex.props(
      ...baseResolved,
      timerStyle,
      playState,
    );
    return className || undefined;
  }

  /**
   * Timer container class name for the countdown text span.
   */
  get timerContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.timerContainer, this.args.overrides, 'timerContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  /**
   * Build the overrides object to pass to the inner Button component.
   * Forwards startEnhancer, endEnhancer, and spinner overrides from consumer.
   */
  get buttonOverrides(): ButtonOverrides | undefined {
    const overrides = this.args.overrides;
    if (!overrides) return undefined;

    const result: Record<string, unknown> = {};
    if (overrides.startEnhancer) result.startEnhancer = overrides.startEnhancer;
    if (overrides.endEnhancer) result.endEnhancer = overrides.endEnhancer;
    if (overrides.spinner) result.spinner = overrides.spinner;

    return Object.keys(result).length > 0 ? result as ButtonOverrides : undefined;
  }

  // ─── Timer Logic ─────────────────────────────────────────────────────────

  /** Start the 100ms interval that updates timeRemaining. */
  private startInterval(): void {
    this.intervalId = setInterval(() => {
      this.tick();
    }, 100);
  }

  /** Clear the interval timer. */
  private stopInterval(): void {
    if (this.intervalId !== null) {
      clearInterval(this.intervalId);
      this.intervalId = null;
    }
  }

  /**
   * Called every 100ms. Calculates remaining time based on wall clock
   * to avoid drift from setInterval inaccuracy.
   */
  private tick(): void {
    if (this.isPaused || this.timeRemaining <= 0) return;

    const elapsed = Date.now() - this.startTime;
    const remaining = Math.max(this.initialTimeMs - elapsed, 0);
    this.timeRemaining = remaining;

    if (remaining === 0) {
      this.stopInterval();
      this.args.onClick();
    }
  }

  /**
   * Detect pause/unpause transitions and adjust timing accordingly.
   * Called during render to keep the timer in sync with the paused arg.
   */
  handlePauseTransition = (): undefined => {
    const currentPaused = this.isPaused;

    if (this.previousPaused !== currentPaused) {
      if (currentPaused) {
        // Transitioning to paused - stop the interval
        this.stopInterval();
      } else {
        // Transitioning to running - adjust startTime and restart
        this.startTime = Date.now() - (this.initialTimeMs - this.timeRemaining);
        this.startInterval();
      }
      this.previousPaused = currentPaused;
    }

    return undefined;
  };

  // ─── Actions ─────────────────────────────────────────────────────────────

  /**
   * Handle manual click - immediately expires the timer and fires onClick.
   */
  handleClick = (event: Event): void => {
    event.preventDefault();
    this.timeRemaining = 0;
    this.stopInterval();
    this.args.onClick();
  };

  // ─── Template ────────────────────────────────────────────────────────────

  <template>
    {{! Detect pause transitions on each render }}
    {{(this.handlePauseTransition)}}
    <Button
      @kind={{this.kind}}
      @size="large"
      @shape="default"
      @disabled={{this.isDisabled}}
      @isLoading={{@isLoading}}
      @overrides={{this.buttonOverrides}}
      class={{this.rootClassName}}
      style={{this.rootInlineStyle}}
      data-basestrom="button-timed"
      {{on "click" this.handleClick}}
      ...attributes
    >
      <:startEnhancer>
        {{yield to="startEnhancer"}}
      </:startEnhancer>
      <:default>
        {{yield}}
        <span class={{this.timerContainerClassName}}>{{this.formattedTime}}</span>
      </:default>
      <:endEnhancer>
        {{yield to="endEnhancer"}}
      </:endEnhancer>
    </Button>
  </template>
}

