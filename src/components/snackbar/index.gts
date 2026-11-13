/**
 * Snackbar component - port from baseweb snackbar.
 *
 * Two components:
 * - SnackbarElement: the visual toast element (dark pill with message + optional action)
 * - SnackbarContainer: manages queue, placement, animation, auto-dismiss
 *
 * Usage:
 * ```hbs
 * {{! Standalone element }}
 * <Bst::SnackbarElement @message="Item saved" @actionMessage="Undo" @actionOnClick={{this.undo}} />
 *
 * {{! With container (manages queue + animation) }}
 * <Bst::SnackbarContainer @placement="bottom" as |snackbar|>
 *   <button {{on "click" (fn snackbar.enqueue (hash message="Saved!" actionMessage="Undo"))}}>
 *     Show snackbar
 *   </button>
 * </Bst::SnackbarContainer>
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import Spinner from '../spinner/index.gts';
import { styles } from './styles.stylex';
import {
  DURATION,
  PLACEMENT,
  type Duration,
  type Placement,
  type SnackbarContainerSignature,
  type SnackbarElementSignature,
  type SnackbarItem,
  type SnackbarOverrides,
} from './types';

// Re-export types and constants
export {
  DURATION,
  PLACEMENT,
  type Duration,
  type Placement, type SnackbarContainerSignature, type SnackbarElementSignature,
  type SnackbarItem, type SnackbarOverrides
};

// ─── SnackbarElement ────────────────────────────────────────────────────────────

export class SnackbarElement extends Component<SnackbarElementSignature> {
  @tracked wrapActionButton = false;

  private rootElement: HTMLElement | null = null;
  private rootObserver: ResizeObserver | null = null;
  private actionMeasureObserver: ResizeObserver | null = null;
  private rootWidth = 0;
  private actionWidth = 0;

  // ─── Computed ───────────────────────────────────────────────────────────────

  get hasAction(): boolean { return !!this.args.actionMessage; }
  get hasStartEnhancer(): boolean { return this.args.progress ?? false; }
  get showInlineAction(): boolean { return this.hasAction && !this.wrapActionButton; }
  get showWrappedAction(): boolean { return this.hasAction && this.wrapActionButton; }
  get shouldFocus(): boolean { return this.args.focus ?? true; }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get contentClassName(): string | undefined {
    const resolved = resolveOverride(styles.content, this.args.overrides, 'content');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get startEnhancerContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.startEnhancerContainer, this.args.overrides, 'startEnhancerContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get messageClassName(): string | undefined {
    const resolved = resolveOverride(styles.message, this.args.overrides, 'message');
    const { className } = stylex.props(
      ...resolved,
      this.hasAction && styles.messageWithSuffix,
    );
    return className || undefined;
  }

  get wrapActionButtonContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.wrapActionButtonContainer, this.args.overrides, 'wrapActionButtonContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionButtonContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionButtonContainer, this.args.overrides, 'actionButtonContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionButtonClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionButton, this.args.overrides, 'actionButton');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // ─── Resize observation (wrap action button when too wide) ────────────────

  setupRoot = (event: Event) => {
    const el = (event.target as HTMLElement).closest('[data-snackbar-root]') as HTMLElement;
    if (!el || this.rootElement === el) return;
    this.rootElement = el;

    if (typeof ResizeObserver !== 'undefined') {
      this.rootObserver?.disconnect();
      this.rootObserver = new ResizeObserver(([entry]) => {
        if (entry) {
          this.rootWidth = entry.contentRect.width;
          this.checkWrap();
        }
      });
      this.rootObserver.observe(el);
    }
  };

  setupActionMeasure = (element: HTMLElement) => {
    if (typeof ResizeObserver !== 'undefined') {
      this.actionMeasureObserver?.disconnect();
      this.actionMeasureObserver = new ResizeObserver(([entry]) => {
        if (entry) {
          this.actionWidth = entry.contentRect.width;
          this.checkWrap();
        }
      });
      this.actionMeasureObserver.observe(element);
    }
  };

  private checkWrap(): void {
    const shouldWrap = this.actionWidth > this.rootWidth / 2;
    if (shouldWrap !== this.wrapActionButton) {
      this.wrapActionButton = shouldWrap;
    }
  }

  willDestroy(): void {
    super.willDestroy();
    this.rootObserver?.disconnect();
    this.actionMeasureObserver?.disconnect();
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleActionClick = (event: MouseEvent) => {
    this.args.actionOnClick?.(event);
  };

  // Focus management: auto-focus action button when snackbar appears
  setupActionFocus = (event: Event) => {
    if (this.shouldFocus) {
      const button = event.target as HTMLButtonElement;
      // Use requestAnimationFrame to ensure DOM is ready
      requestAnimationFrame(() => button.focus());
    }
  };

  <template>
    {{! template-lint-disable no-autofocus-attribute }}
    <div
      class={{this.rootClassName}}
      data-snackbar-root
      data-basestrom="snackbar"
      {{on "focus" this.setupRoot}}
      {{on "mouseenter" this.setupRoot}}
      ...attributes
    >
      <div class={{this.contentClassName}}>
        {{! Start enhancer (icon or spinner) }}
        {{#if (has-block "startEnhancer")}}
          <span class={{this.startEnhancerContainerClassName}}>
            {{yield to="startEnhancer"}}
          </span>
        {{else if this.hasStartEnhancer}}
          <span class={{this.startEnhancerContainerClassName}}>
            <Spinner @boxSize="24px" @borderWidth="4px" />
          </span>
        {{/if}}

        {{! Message }}
        <p class={{this.messageClassName}}>
          {{@message}}
        </p>

        {{! Inline action button (when fits) }}
        {{#if this.showInlineAction}}
          <div class={{this.actionButtonContainerClassName}}>
            <button
              class={{this.actionButtonClassName}}
              type="button"
              autofocus={{this.shouldFocus}}
              {{on "click" this.handleActionClick}}
            >
              {{@actionMessage}}
            </button>
          </div>
        {{/if}}
      </div>

      {{! Wrapped action button (when too wide) }}
      {{#if this.showWrappedAction}}
        <div class={{this.wrapActionButtonContainerClassName}}>
          <div class={{this.actionButtonContainerClassName}}>
            <button
              class={{this.actionButtonClassName}}
              type="button"
              {{on "click" this.handleActionClick}}
            >
              {{@actionMessage}}
            </button>
          </div>
        </div>
      {{/if}}
    </div>
  </template>
}

// ─── SnackbarContainer ──────────────────────────────────────────────────────────

export class SnackbarContainer extends Component<SnackbarContainerSignature> {
  @tracked private queue: SnackbarItem[] = [];
  @tracked private animating = false;
  @tracked private visible = false;

  private timeoutId: ReturnType<typeof setTimeout> | null = null;
  private animationTimeoutId: ReturnType<typeof setTimeout> | null = null;

  // ─── Computed ───────────────────────────────────────────────────────────────

  get placement(): Placement { return this.args.placement ?? 'top'; }
  get defaultDuration(): Duration { return this.args.defaultDuration ?? DURATION.short; }

  get currentItem(): SnackbarItem | null {
    return this.queue[0] ?? null;
  }

  get currentMessage(): string {
    return this.currentItem?.message ?? '';
  }

  get currentActionMessage(): string | undefined {
    return this.currentItem?.actionMessage;
  }

  get currentProgress(): boolean {
    return this.currentItem?.progress ?? false;
  }

  get showSnackbar(): boolean {
    return this.visible && this.currentItem !== null;
  }

  get isTopPlacement(): boolean {
    return this.placement === 'top' || this.placement === 'topLeft' || this.placement === 'topRight';
  }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get placementContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.placementContainer, this.args.overrides, 'placementContainer');
    let placementStyle;
    switch (this.placement) {
      case 'topLeft': placementStyle = styles.placementTopLeft; break;
      case 'topRight': placementStyle = styles.placementTopRight; break;
      case 'bottom': placementStyle = styles.placementBottom; break;
      case 'bottomLeft': placementStyle = styles.placementBottomLeft; break;
      case 'bottomRight': placementStyle = styles.placementBottomRight; break;
      case 'top':
      default: placementStyle = styles.placementTop; break;
    }
    const { className } = stylex.props(...resolved, placementStyle);
    return className || undefined;
  }

  get placementContainerStyle(): string {
    if (this.animating) {
      // baseweb: containerHeight * 2 + 24. We approximate with a large value
      // since we can't easily measure off-screen in Ember without a modifier.
      // 200px covers most snackbar heights (single line ~56px, multi-line ~100px).
      const direction = this.isTopPlacement ? -1 : 1;
      const translateY = direction * 200;
      return htmlSafe(`transform: translateY(${translateY}px)`).toString();
    }
    return htmlSafe('').toString();
  }

  get alertWrapperClassName(): string | undefined {
    const { className } = stylex.props(styles.alertWrapper);
    return className || undefined;
  }

  // ─── Queue management ─────────────────────────────────────────────────────

  enqueue = (item: SnackbarItem) => {
    const newItem = { ...item, duration: item.duration ?? this.defaultDuration };
    this.queue = [...this.queue, newItem];

    if (this.queue.length === 1) {
      this.enter(newItem.duration!);
    }
  };

  dequeue = () => {
    this.animating = true;

    this.animationTimeoutId = setTimeout(() => {
      this.animating = false;
      this.visible = false;
      this.queue = this.queue.slice(1);

      if (this.queue.length > 0) {
        this.enter(this.queue[0]!.duration ?? this.defaultDuration);
      }
    }, 1000);
  };

  private enter(duration: Duration): void {
    this.animating = true;
    this.visible = true;

    // Next tick to trigger CSS transition (baseweb uses setTimeout(fn, 0))
    setTimeout(() => {
      this.animating = false;
      this.startTimer(duration);
    }, 0);
  }

  private startTimer(duration: Duration): void {
    if (duration === DURATION.infinite) return;

    this.timeoutId = setTimeout(() => {
      this.dequeue();
    }, duration);
  }

  // ─── Mouse interaction (pause/resume timer) ───────────────────────────────

  handleMouseEnter = () => {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
      this.timeoutId = null;
    }
  };

  handleMouseLeave = () => {
    const item = this.currentItem;
    if (item) {
      this.startTimer(item.duration ?? this.defaultDuration);
    }
  };

  handleActionClick = (event: MouseEvent) => {
    if (this.timeoutId) {
      clearTimeout(this.timeoutId);
      this.timeoutId = null;
    }
    this.currentItem?.actionOnClick?.(event);
    this.dequeue();
  };

  willDestroy(): void {
    super.willDestroy();
    if (this.timeoutId) clearTimeout(this.timeoutId);
    if (this.animationTimeoutId) clearTimeout(this.animationTimeoutId);
  }

  <template>
    {{yield (hash enqueue=this.enqueue dequeue=this.dequeue)}}

    {{#if this.showSnackbar}}
      <div
        class={{this.placementContainerClassName}}
        style={{this.placementContainerStyle}}
      >
        <div
          class={{this.alertWrapperClassName}}
          role="alert"
          {{on "mouseenter" this.handleMouseEnter}}
          {{on "mouseleave" this.handleMouseLeave}}
        >
          <SnackbarElement
            @message={{this.currentMessage}}
            @actionMessage={{this.currentActionMessage}}
            @actionOnClick={{this.handleActionClick}}
            @progress={{this.currentProgress}}
            @overrides={{@overrides}}
          />
        </div>
      </div>
    {{/if}}
  </template>
}

export default SnackbarElement;
