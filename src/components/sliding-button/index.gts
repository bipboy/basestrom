/**
 * SlidingButton component - complete port from baseweb sliding-button.
 *
 * A slide-to-confirm interaction where the user drags a thumb (grabber)
 * across a track to confirm an action. Supports configurable threshold,
 * loading state, disabled state, auto-reset, and full override system.
 *
 * @example Basic usage
 * ```gts
 * <SlidingButton @label="Slide to confirm" @onComplete={{this.handleConfirm}} />
 * ```
 *
 * @example With loading state after confirm
 * ```gts
 * <SlidingButton
 *   @label="Slide to pay"
 *   @isLoading={{this.isProcessing}}
 *   @onComplete={{this.handlePayment}}
 * />
 * ```
 *
 * @example Low threshold (20% drag required)
 * ```gts
 * <SlidingButton
 *   @label="Slide to unlock"
 *   @threshold="low"
 *   @onComplete={{this.handleUnlock}}
 * />
 * ```
 *
 * @example Auto-reset after 3 seconds
 * ```gts
 * <SlidingButton
 *   @label="Slide to send"
 *   @slideBackAfterMs={{3000}}
 *   @onComplete={{this.handleSend}}
 * />
 * ```
 *
 * @example Disabled state
 * ```gts
 * <SlidingButton
 *   @label="Slide to confirm"
 *   @isDisabled={{true}}
 * />
 * ```
 *
 * @example With overrides
 * ```gts
 * import * as stylex from '@stylexjs/stylex';
 *
 * const overrides = stylex.create({
 *   track: { backgroundColor: 'navy' },
 *   grabber: { color: 'gold' },
 * });
 *
 * <SlidingButton
 *   @label="Custom styled"
 *   @overrides={{overrides}}
 *   @onComplete={{this.handleConfirm}}
 * />
 * ```
 */
import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    THRESHOLD,
    type SlidingButtonOverrides,
    type SlidingButtonSignature,
    type ThresholdKey,
} from './types';

// Re-export types and constants
export {
    THRESHOLD, type SlidingButtonOverrides,
    type SlidingButtonSignature, type ThresholdKey
};

/** Numeric threshold values (fraction of track width). */
const THRESHOLD_VALUES: Record<ThresholdKey, number> = {
  low: 0.2,
  high: 0.8,
};

/** Grabber icon size (24px) + padding (16px × 2) = 56px total button size. */
const GRABBER_ICON_SIZE_PX = 24;
const GRABBER_PADDING_PX = 16;
const BUTTON_SIZE = GRABBER_ICON_SIZE_PX + GRABBER_PADDING_PX * 2; // 56
const TAP_OFFSET = GRABBER_PADDING_PX; // 16

// ---------------------------------------------------------------------------
// Component
// ---------------------------------------------------------------------------

export default class SlidingButton extends Component<SlidingButtonSignature> {
  // -- Tracked state ----------------------------------------------------------

  @tracked isDragging = false;
  @tracked dragOffset = 0;
  @tracked isCompleted = false;

  // -- Refs -------------------------------------------------------------------

  private containerElement: HTMLElement | null = null;
  private dragStartPos = 0;
  private isDraggingRef = false;
  private slideBackTimer: ReturnType<typeof setTimeout> | null = null;

  // -- Bound event handlers (for add/removeEventListener) ---------------------

  private boundPointerMove: ((e: PointerEvent) => void) | null = null;
  private boundPointerUp: (() => void) | null = null;

  constructor(owner: any, args: SlidingButtonSignature['Args']) {
    super(owner, args);
    registerDestructor(this, () => {
      this.cleanupGlobalListeners();
      if (this.slideBackTimer !== null) {
        clearTimeout(this.slideBackTimer);
      }
    });
  }

  // -- Derived getters --------------------------------------------------------

  get label(): string {
    return this.args.label;
  }

  get threshold(): ThresholdKey {
    return this.args.threshold ?? 'high';
  }

  get isLoading(): boolean {
    return this.args.isLoading ?? false;
  }

  get isDisabled(): boolean {
    return this.args.isDisabled ?? false;
  }

  get isInteractive(): boolean {
    return !this.isDisabled && !this.isLoading && !this.isCompleted;
  }

  get thresholdValue(): number {
    return THRESHOLD_VALUES[this.threshold];
  }

  get sliderWidth(): string {
    return this.isCompleted ? '100%' : `${BUTTON_SIZE + this.dragOffset}px`;
  }

  get isActuallySliding(): boolean {
    return this.isDragging && this.dragOffset > TAP_OFFSET;
  }

  // -- Style classNames -------------------------------------------------------

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trackClassName(): string | undefined {
    const resolved = resolveOverride(styles.track, this.args.overrides, 'track');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.trackDisabled,
    );
    return className || undefined;
  }

  get sliderClassName(): string | undefined {
    const resolved = resolveOverride(styles.slider, this.args.overrides, 'slider');
    const suppressTransition = this.isDragging && this.dragOffset !== TAP_OFFSET;
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.sliderDisabled,
      this.isCompleted && styles.sliderCompleted,
      suppressTransition && styles.sliderNoTransition,
    );
    return className || undefined;
  }

  get sliderStyle(): string {
    return `width:${this.sliderWidth}`;
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(styles.label, this.args.overrides, 'label');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.labelDisabled,
      this.isActuallySliding && styles.labelSliding,
      this.isCompleted && styles.labelCompleted,
    );
    return className || undefined;
  }

  get completedLabelClassName(): string | undefined {
    const resolved = resolveOverride(styles.completedLabel, this.args.overrides, 'completedLabel');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.completedLabelDisabled,
    );
    return className || undefined;
  }

  get grabberClassName(): string | undefined {
    const resolved = resolveOverride(styles.grabber, this.args.overrides, 'grabber');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.grabberDisabled,
      !this.isInteractive && !this.isDisabled && styles.grabberNotInteractive,
    );
    return className || undefined;
  }

  get loadingOverlayClassName(): string | undefined {
    const resolved = resolveOverride(styles.loadingOverlay, this.args.overrides, 'loadingOverlay');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get loadingSpinnerClassName(): string | undefined {
    const resolved = resolveOverride(styles.loadingSpinner, this.args.overrides, 'loadingSpinner');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // -- Aria -------------------------------------------------------------------

  get ariaLabel(): string {
    return this.args['aria-label'] ?? this.label;
  }

  get ariaBusy(): string | undefined {
    return this.isLoading ? 'true' : undefined;
  }

  get ariaDisabled(): string | undefined {
    return this.isDisabled ? 'true' : undefined;
  }

  // -- SVG paths for icons ----------------------------------------------------

  /** Arrow-right icon path (24×24 viewBox). */
  private static readonly ARROW_RIGHT_PATH = 'M12.293 5.293a1 1 0 0 1 1.414 0l6 6a1 1 0 0 1 0 1.414l-6 6a1 1 0 0 1-1.414-1.414L16.586 13H5a1 1 0 1 1 0-2h11.586l-4.293-4.293a1 1 0 0 1 0-1.414z';

  /** Check icon path (24×24 viewBox). */
  private static readonly CHECK_PATH = 'M9.86 18a1 1 0 0 1-.73-.32l-4.86-5.17a1 1 0 1 1 1.46-1.37l4.12 4.39 8.41-9.2a1 1 0 1 1 1.48 1.34l-9.14 10a1 1 0 0 1-.73.33z';

  get iconPath(): string {
    return this.isCompleted
      ? SlidingButton.CHECK_PATH
      : SlidingButton.ARROW_RIGHT_PATH;
  }

  // -- Event handlers ---------------------------------------------------------

  /**
   * Handles pointer down on the grabber - starts the drag interaction.
   * Also captures the track element reference from the DOM hierarchy.
   */
  handlePointerDown = (event: PointerEvent) => {
    if (!this.isInteractive) return;

    // Capture track element ref: grabber → slider → track
    if (!this.containerElement) {
      const grabber = event.currentTarget as HTMLElement;
      const slider = grabber.parentElement;
      const track = slider?.parentElement;
      if (track) {
        this.containerElement = track;
      }
    }

    this.isDragging = true;
    this.isDraggingRef = true;
    this.dragOffset = TAP_OFFSET;
    this.dragStartPos = event.clientX - TAP_OFFSET;

    // Capture pointer for reliable tracking
    (event.currentTarget as HTMLElement).setPointerCapture(event.pointerId);

    // Attach global listeners for move/up
    this.boundPointerMove = this.handleGlobalPointerMove.bind(this);
    this.boundPointerUp = this.handleGlobalPointerUp.bind(this);
    document.addEventListener('pointermove', this.boundPointerMove);
    document.addEventListener('pointerup', this.boundPointerUp);
  };

  /**
   * Handles pointer up/cancel on the grabber - resets if not completed.
   */
  handlePointerUp = () => {
    this.resetDrag();
  };

  /**
   * Keyboard handler - Enter/Space triggers immediate completion.
   */
  handleKeyDown = (event: KeyboardEvent) => {
    if (!this.isInteractive) return;
    if (event.key === 'Enter' || event.key === ' ') {
      event.preventDefault();
      this.complete();
    }
  };

  // -- Private methods --------------------------------------------------------

  private handleGlobalPointerMove(e: PointerEvent): void {
    if (!this.isDraggingRef || !this.containerElement || this.isCompleted) return;

    const delta = e.clientX - this.dragStartPos;
    if (delta <= 0) return;

    const containerWidth = this.containerElement.offsetWidth;
    const maxOffset = containerWidth - BUTTON_SIZE;
    const thresholdPixels = containerWidth * this.thresholdValue;

    if (delta > thresholdPixels) {
      this.dragOffset = maxOffset;
      this.complete();
    } else {
      this.dragOffset = Math.min(delta, maxOffset);
    }
  }

  private handleGlobalPointerUp(): void {
    this.resetDrag();
  }

  private resetDrag(): void {
    this.isDragging = false;
    this.isDraggingRef = false;
    if (!this.isCompleted) {
      this.dragOffset = 0;
    }
    this.cleanupGlobalListeners();
  }

  private complete(): void {
    this.isCompleted = true;
    this.isDragging = false;
    this.isDraggingRef = false;
    this.cleanupGlobalListeners();
    this.args.onComplete?.();
    this.scheduleSlideBack();
  }

  private scheduleSlideBack(): void {
    const ms = this.args.slideBackAfterMs;
    if (ms == null || ms <= 0) return;

    this.slideBackTimer = setTimeout(() => {
      this.isCompleted = false;
      this.dragOffset = 0;
      this.slideBackTimer = null;
    }, ms);
  }

  private cleanupGlobalListeners(): void {
    if (this.boundPointerMove) {
      document.removeEventListener('pointermove', this.boundPointerMove);
      this.boundPointerMove = null;
    }
    if (this.boundPointerUp) {
      document.removeEventListener('pointerup', this.boundPointerUp);
      this.boundPointerUp = null;
    }
  }

  // -- Template ---------------------------------------------------------------

  <template>
    {{! template-lint-disable no-pointer-down-event-binding require-presentational-children }}
    {{#if this.label}}
      <div
        class={{this.rootClassName}}
        tabindex="0"
        role="button"
        aria-label={{this.ariaLabel}}
        aria-busy={{this.ariaBusy}}
        aria-disabled={{this.ariaDisabled}}
        data-basestrom="sliding-button"
        ...attributes
        {{on "keydown" this.handleKeyDown}}
      >
        <div
          class={{this.trackClassName}}
        >
          {{#if this.isLoading}}
            <div class={{this.loadingOverlayClassName}}>
              <div class={{this.loadingSpinnerClassName}}></div>
            </div>
          {{else}}
            <div class={{this.labelClassName}}>
              {{this.label}}
            </div>

            <div
              class={{this.sliderClassName}}
              style={{this.sliderStyle}}
            >
              {{#if this.isCompleted}}
                <div class={{this.completedLabelClassName}}>
                  {{this.label}}
                </div>
              {{/if}}

              <div
                class={{this.grabberClassName}}
                data-basestrom="sliding-button-grabber"
                {{on "pointerdown" this.handlePointerDown}}
                {{on "pointerup" this.handlePointerUp}}
                {{on "pointercancel" this.handlePointerUp}}
              >
                <svg
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path d={{this.iconPath}} />
                </svg>
              </div>
            </div>
          {{/if}}
        </div>
      </div>
    {{/if}}
  </template>

}
