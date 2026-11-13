/**
 * Drawer component - port from baseweb drawer.
 *
 * A sliding panel (left/right/top/bottom) that overlays the viewport.
 * Uses CSS transitions (not keyframe animations) for open/close.
 *
 * Two-phase open: mount → rAF → set isVisible=true (starts CSS transition)
 * Two-phase close: set isVisible=false (transition runs) → after 500ms → unmount
 *
 * Usage:
 * ```hbs
 * <BstDrawer
 *   @isOpen={{this.showDrawer}}
 *   @onClose={{this.closeDrawer}}
 *   @anchor="right"
 * >
 *   Drawer content here
 * </BstDrawer>
 * ```
 */
import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { trapFocus } from '../../a11y';
import { resolveOverride } from '../../helpers/overrides';
import { bstOnArgsChange, bstRef } from '../../modifiers';
import { styles } from './styles.stylex';
import {
  ANCHOR,
  CLOSE_SOURCE,
  SIZE,
  SIZE_DIMENSION,
  type Anchor,
  type CloseSource,
  type DrawerOverrides,
  type DrawerSignature,
} from './types';

// Re-export types and constants
export {
  ANCHOR,
  CLOSE_SOURCE, SIZE,
  SIZE_DIMENSION, type Anchor,
  type CloseSource,
  type DrawerOverrides,
  type DrawerSignature
};

// Make modifiers available in strict-mode template with original names
const onArgsChange = bstOnArgsChange;
const ref = bstRef;

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Drawer extends Component<DrawerSignature> {
  @tracked private isVisible = false;
  @tracked private shouldRender = false;
  @tracked private isFocusVisible = false;

  private _cleanupFocusTrap: (() => void) | null = null;
  private _cleanupKeydown: (() => void) | null = null;
  private _savedOverflow: string | null = null;
  private _animateOutTimer: ReturnType<typeof setTimeout> | null = null;
  private _animateStartTimer: ReturnType<typeof requestAnimationFrame> | null = null;

  constructor(owner: any, args: DrawerSignature['Args']) {
    super(owner, args);
    registerDestructor(this, () => {
      this._teardown();
      this._clearTimers();
    });
  }

  // ─── Resolved props ─────────────────────────────────────────────────────────

  get anchor(): Anchor { return this.args.anchor ?? 'right'; }
  get size(): string { return this.args.size ?? 'default'; }
  get animate(): boolean { return this.args.animate ?? true; }
  get closeable(): boolean { return this.args.closeable ?? true; }
  get showBackdrop(): boolean { return this.args.showBackdrop ?? true; }
  get autoFocus(): boolean { return this.args.autoFocus ?? true; }

  // ─── Two-phase open/close logic ─────────────────────────────────────────────

  /**
   * Watched via onArgsChange modifier. Runs on mount and whenever @isOpen
   * changes. Implements the two-phase open/close pattern from baseweb.
   */
  onIsOpenChange = (_el: Element, _isOpen: unknown): void => {
    const isOpen = this.args.isOpen;
    if (isOpen) {
      this._didOpen();
    } else {
      this._didClose();
    }
  };

  private _didOpen(): void {
    this._clearTimers();
    this.shouldRender = true;

    // Phase 2: after one frame, set isVisible to trigger CSS transition
    this._animateStartTimer = requestAnimationFrame(() => {
      this.isVisible = true;
    });
  }

  private _didClose(): void {
    // Phase 1: set isVisible=false → CSS transition out starts
    this.isVisible = false;

    // Phase 2: after transition duration, unmount content
    this._animateOutTimer = setTimeout(() => {
      this.shouldRender = false;
    }, 500);
  }

  private _clearTimers(): void {
    if (this._animateOutTimer !== null) {
      clearTimeout(this._animateOutTimer);
      this._animateOutTimer = null;
    }
    if (this._animateStartTimer !== null) {
      cancelAnimationFrame(this._animateStartTimer);
      this._animateStartTimer = null;
    }
  }

  // ─── Event handlers ─────────────────────────────────────────────────────────

  handleBackdropClick = (event: Event): void => {
    this.args.onBackdropClick?.(event);
    if (!this.closeable) return;
    this.args.onClose?.({ closeSource: CLOSE_SOURCE.backdrop });
  };

  handleCloseClick = (): void => {
    this.args.onClose?.({ closeSource: CLOSE_SOURCE.closeButton });
  };

  handleFocus = (event: FocusEvent): void => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleBlur = (): void => {
    requestAnimationFrame(() => {
      this.isFocusVisible = false;
    });
  };

  // ─── Setup / teardown (ref callback) ────────────────────────────────────────

  captureRoot = (el: Element | null): void => {
    if (el) {
      this._setup(el as HTMLElement);
    } else {
      this._teardown();
    }
  };

  private _setup(element: HTMLElement): void {
    // Reset scroll
    element.scrollTop = 0;

    // Auto-focus
    if (this.autoFocus) {
      requestAnimationFrame(() => {
        element.focus({ preventScroll: true });
      });
    }

    // Focus trap
    this._cleanupFocusTrap = trapFocus(element);

    // Scroll lock
    if (this.showBackdrop && typeof document !== 'undefined') {
      this._savedOverflow = document.body.style.overflow;
      document.body.style.overflow = 'hidden';
    }

    // Escape key
    const handleKeydown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        if (!this.closeable) return;
        event.preventDefault();
        this.args.onClose?.({ closeSource: CLOSE_SOURCE.escape });
      }
    };
    document.addEventListener('keydown', handleKeydown);
    this._cleanupKeydown = () => document.removeEventListener('keydown', handleKeydown);
  }

  private _teardown(): void {
    if (this._cleanupFocusTrap) {
      this._cleanupFocusTrap();
      this._cleanupFocusTrap = null;
    }
    if (this._savedOverflow !== null && typeof document !== 'undefined') {
      document.body.style.overflow = this._savedOverflow;
      this._savedOverflow = null;
    }
    if (this._cleanupKeydown) {
      this._cleanupKeydown();
      this._cleanupKeydown = null;
    }
  }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get backdropClassName(): string | undefined {
    const resolved = resolveOverride(styles.backdrop, this.args.overrides, 'backdrop');
    const isVis = this.isVisible && this.args.isOpen && this.showBackdrop;
    const { className } = stylex.props(
      ...resolved,
      isVis ? styles.backdropVisible : styles.backdropHidden,
      this.animate && styles.backdropAnimate,
    );
    return className || undefined;
  }

  get containerClassName(): string | undefined {
    const resolved = resolveOverride(styles.container, this.args.overrides, 'container');
    const isVis = this.isVisible && this.args.isOpen;
    const { className } = stylex.props(
      ...resolved,
      isVis ? styles.containerVisible : styles.containerHidden,
      this.animate && styles.containerAnimate,
    );
    return className || undefined;
  }

  get containerStyle(): string {
    const anchor = this.anchor;
    const isVis = this.isVisible && this.args.isOpen;
    const sizeValue = SIZE_DIMENSION[this.size] ?? this.size;

    const parts: string[] = [];

    // Size
    if (anchor === 'left' || anchor === 'right') {
      parts.push(`width:${sizeValue}`);
      parts.push('height:100%');
    } else {
      parts.push('width:100%');
      parts.push(`height:${sizeValue}`);
    }

    // Transform + positioning
    switch (anchor) {
      case 'right':
        parts.push(`transform:${isVis ? 'translateX(0%)' : 'translateX(100%)'}`);
        parts.push('right:0');
        parts.push('top:0');
        break;
      case 'left':
        parts.push(`transform:${isVis ? 'translateX(0%)' : 'translateX(-100%)'}`);
        parts.push('left:0');
        parts.push('top:0');
        break;
      case 'bottom':
        parts.push(`transform:${isVis ? 'translateY(0)' : 'translateY(100%)'}`);
        parts.push('left:0');
        parts.push('bottom:0');
        break;
      case 'top':
        parts.push(`transform:${isVis ? 'translateY(0)' : 'translateY(-100%)'}`);
        parts.push('left:0');
        parts.push('top:0');
        break;
    }

    return htmlSafe(parts.join(';')).toString();
  }

  get bodyClassName(): string | undefined {
    const resolved = resolveOverride(styles.body, this.args.overrides, 'body');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get closeClassName(): string | undefined {
    const resolved = resolveOverride(styles.close, this.args.overrides, 'close');
    const { className } = stylex.props(
      ...resolved,
      this.isFocusVisible && styles.closeFocusVisible,
    );
    return className || undefined;
  }

  get hiddenClassName(): string | undefined {
    const { className } = stylex.props(styles.hidden);
    return className || undefined;
  }

  willDestroy() {
    super.willDestroy();
    this._teardown();
    this._clearTimers();
  }

  <template>
    {{! template-lint-disable no-invalid-interactive }}
    {{!
      The hidden div holds the onArgsChange modifier which watches @isOpen.
      It's always rendered so we can track open/close transitions even
      when shouldRender is false.
    }}
    <div
      class={{this.hiddenClassName}}
      {{bstOnArgsChange this.onIsOpenChange @isOpen}}
    ></div>

    {{#if this.shouldRender}}
      <div
        class={{this.rootClassName}}
        tabindex="-1"
        data-basestrom="drawer"
        ...attributes
        {{bstRef this.captureRoot}}
      >
        <div
          class={{this.backdropClassName}}
          {{on "click" this.handleBackdropClick}}
          aria-hidden="true"
        ></div>

        <div
          class={{this.containerClassName}}
          style={{this.containerStyle}}
        >
          <div class={{this.bodyClassName}}>
            {{yield}}
          </div>

          {{#if this.closeable}}
            <button
              type="button"
              class={{this.closeClassName}}
              aria-label="Close"
              {{on "click" this.handleCloseClick}}
              {{on "focus" this.handleFocus}}
              {{on "blur" this.handleBlur}}
            >
              <svg
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M17.5 6.5l-11 11M6.5 6.5l11 11"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                />
              </svg>
            </button>
          {{/if}}
        </div>
      </div>
    {{/if}}
  </template>
}
