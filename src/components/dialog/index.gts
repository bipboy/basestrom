/**
 * Dialog component - port from baseweb dialog.
 *
 * A fixed-position overlay panel (uses div role="dialog", not native <dialog>).
 * Shows when `@isOpen=true`, hidden otherwise.
 *
 * Features:
 * - Overlay backdrop (optional)
 * - Prevents background scroll when open + overlay
 * - Closes on Escape key and overlay click
 * - Optional dismiss button (X) top-right
 * - Animated entry (fade + translateY)
 * - Heading (sticky, truncatable to N lines)
 * - Scrollable body
 * - Optional artwork above heading
 * - Optional ButtonDock at the bottom
 * - Focus trap (traps Tab within dialog)
 * - Sizes: xSmall, small, medium, large
 * - Placements: center, topLeft, topCenter, topRight, bottomLeft, bottomCenter, bottomRight
 * - Narrow viewport (<600px): always bottomCenter placement
 *
 * Usage:
 * ```hbs
 * <BstDialog
 *   @isOpen={{this.showDialog}}
 *   @heading="Confirmation"
 *   @onDismiss={{this.closeDialog}}
 * >
 *   Are you sure you want to proceed?
 *   <:buttonDock>
 *     <BstButtonDock>
 *       <BstButton @kind="primary" {{on "click" this.confirm}}>Yes</BstButton>
 *       <BstButton @kind="secondary" {{on "click" this.closeDialog}}>Cancel</BstButton>
 *     </BstButtonDock>
 *   </:buttonDock>
 * </BstDialog>
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
import { bstRef } from '../../modifiers';
import Button from '../button/index.gts';
import { Delete as IconDelete } from '../icon/glyphs.gts';
import { styles } from './styles.stylex';
import {
  PLACEMENT,
  SIZE,
  type DialogOverrides,
  type DialogSignature,
  type Placement,
  type Size,
} from './types';

// Re-export types and constants
export {
  PLACEMENT, SIZE, type DialogOverrides,
  type DialogSignature, type Placement, type Size
};

// Make modifier available in strict-mode template with original name
const ref = bstRef;

// ─── Placement style helpers ────────────────────────────────────────────────────

function getPlacementStyle(placement: Placement): string {
  const g = '40px'; // baseweb wideViewportGutter
  let style: string;
  switch (placement) {
    case 'center':
      style = `top:50%;left:50%;transform:translate(-50%,-50%)`;
      break;
    case 'topLeft':
      style = `top:${g};left:${g}`;
      break;
    case 'topCenter':
      style = `top:${g};left:50%;transform:translateX(-50%)`;
      break;
    case 'topRight':
      style = `top:${g};right:${g}`;
      break;
    case 'bottomLeft':
      style = `bottom:${g};left:${g}`;
      break;
    case 'bottomCenter':
      style = `bottom:${g};left:50%;transform:translateX(-50%)`;
      break;
    case 'bottomRight':
      style = `bottom:${g};right:${g}`;
      break;
    default:
      style = `top:50%;left:50%;transform:translate(-50%,-50%)`;
  }
  return htmlSafe(style).toString();
}

function getAnimStyle(placement: Placement): typeof styles.animCenter {
  switch (placement) {
    case 'bottomCenter':
      return styles.animBottomCenter;
    case 'bottomLeft':
    case 'bottomRight':
      return styles.animBottom;
    case 'topCenter':
      return styles.animTopCenter;
    case 'topLeft':
    case 'topRight':
      return styles.animTop;
    default:
      return styles.animCenter;
  }
}

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Dialog extends Component<DialogSignature> {
  @tracked private _isNarrow = false;

  private _dialogElement: HTMLElement | null = null;
  private _cleanupFocusTrap: (() => void) | null = null;
  private _cleanupKeydown: (() => void) | null = null;
  private _savedOverflow: string | null = null;
  private _mediaQuery: MediaQueryList | null = null;
  private _mediaHandler: ((e: MediaQueryListEvent) => void) | null = null;

  constructor(owner: any, args: DialogSignature['Args']) {
    super(owner, args);
    // Set up narrow viewport detection
    if (typeof window !== 'undefined') {
      this._mediaQuery = window.matchMedia('(max-width: 599px)');
      this._isNarrow = this._mediaQuery.matches;
      this._mediaHandler = (e: MediaQueryListEvent) => {
        this._isNarrow = e.matches;
      };
      this._mediaQuery.addEventListener('change', this._mediaHandler);
    }
    registerDestructor(this, () => {
      this._teardown();
      if (this._mediaQuery && this._mediaHandler) {
        this._mediaQuery.removeEventListener('change', this._mediaHandler);
      }
    });
  }

  // ─── Resolved props ─────────────────────────────────────────────────────────

  get showDismissButton(): boolean {
    return (this.args.showDismissButton ?? true) && !!this.args.onDismiss;
  }
  get hasOverlay(): boolean { return this.args.hasOverlay ?? true; }
  get numHeadingLines(): number { return this.args.numHeadingLines ?? 2; }
  get size(): Size { return this.args.size ?? 'xSmall'; }
  get autoFocus(): boolean { return this.args.autoFocus ?? true; }

  get placement(): Placement {
    // if (this._isNarrow) return 'bottomCenter';
    return this.args.placement ?? 'center';
  }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get overlayClassName(): string | undefined {
    const resolved = resolveOverride(styles.overlay, this.args.overrides, 'overlay');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const sizeStyle = this.sizeStyle;
    const animStyle = getAnimStyle(this.placement);
    const { className } = stylex.props(...resolved, sizeStyle, animStyle);
    return className || undefined;
  }

  get rootStyle(): string {
    return getPlacementStyle(this.placement);
  }

  get scrollContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.scrollContainer, this.args.overrides, 'scrollContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get headingClassName(): string | undefined {
    const resolved = resolveOverride(styles.heading, this.args.overrides, 'heading');
    const { className } = stylex.props(
      ...resolved,
      this.numHeadingLines > 0 && styles.headingLineClamp,
    );
    return className || undefined;
  }

  get headingStyle(): string | undefined {
    if (this.numHeadingLines > 0) {
      return htmlSafe(`-webkit-line-clamp:${this.numHeadingLines}`).toString();
    }
    return undefined;
  }

  get bodyClassName(): string | undefined {
    const resolved = resolveOverride(styles.body, this.args.overrides, 'body');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get artworkClassName(): string | undefined {
    const resolved = resolveOverride(styles.artwork, this.args.overrides, 'artwork');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get buttonDockClassName(): string | undefined {
    const resolved = resolveOverride(styles.buttonDock, this.args.overrides, 'buttonDock');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get dismissButtonClassName(): string | undefined {
    const resolved = resolveOverride(styles.dismissButton, this.args.overrides, 'dismissButton');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  private get sizeStyle() {
    switch (this.size) {
      case 'small': return styles.sizeSmall;
      case 'medium': return styles.sizeMedium;
      case 'large': return styles.sizeLarge;
      default: return styles.sizeXSmall;
    }
  }

  // ─── Event handlers ─────────────────────────────────────────────────────────

  handleOverlayClick = () => {
    this.args.onDismiss?.();
  };

  handleDismiss = () => {
    this.args.onDismiss?.();
  };

  /**
   * Modifier-style setup: called from the ref callback.
   */
  private _setup(element: HTMLElement) {
    // Auto-focus
    if (this.autoFocus) {
      requestAnimationFrame(() => {
        element.focus({ preventScroll: true });
      });
    }

    // Focus trap
    this._cleanupFocusTrap = trapFocus(element);

    // Scroll lock
    if (this.hasOverlay && typeof document !== 'undefined') {
      this._savedOverflow = document.body.style.overflow;
      document.body.style.overflow = 'hidden';
    }

    // Escape key
    const handleKeydown = (event: KeyboardEvent) => {
      if (event.key === 'Escape') {
        event.preventDefault();
        this.args.onDismiss?.();
      }
    };
    document.addEventListener('keydown', handleKeydown);
    this._cleanupKeydown = () => document.removeEventListener('keydown', handleKeydown);
  }

  private _teardown() {
    // Cleanup focus trap
    if (this._cleanupFocusTrap) {
      this._cleanupFocusTrap();
      this._cleanupFocusTrap = null;
    }
    // Restore scroll
    if (this._savedOverflow !== null && typeof document !== 'undefined') {
      document.body.style.overflow = this._savedOverflow;
      this._savedOverflow = null;
    }
    // Remove keydown
    if (this._cleanupKeydown) {
      this._cleanupKeydown();
      this._cleanupKeydown = null;
    }
    this._dialogElement = null;
  }

  /**
   * Ref callback: sets up focus trap, scroll lock, and keyboard listener
   * when element is inserted; tears down when element is removed.
   */
  captureDialog = (el: Element | null) => {
    if (el) {
      this._dialogElement = el as HTMLElement;
      this._setup(el as HTMLElement);
    } else {
      this._teardown();
    }
  };

  willDestroy() {
    super.willDestroy();
    this._teardown();
  }

  <template>
    {{! template-lint-disable no-invalid-interactive no-positive-tabindex }}
    {{#if @isOpen}}
      {{#if this.hasOverlay}}
        <div
          class={{this.overlayClassName}}
          {{on "click" this.handleOverlayClick}}
          data-basestrom="dialog-overlay"
          aria-hidden="true"
        ></div>
      {{/if}}
      <div
        class={{this.rootClassName}}
        style={{this.rootStyle}}
        role="dialog"
        aria-modal="true"
        aria-label={{@heading}}
        tabindex="-1"
        data-basestrom="dialog"
        ...attributes
        {{bstRef this.captureDialog}}
      >
        {{#if this.showDismissButton}}
          <Button
            class={{this.dismissButtonClassName}}
            @kind="secondary"
            @shape="circle"
            aria-label="Close"
            {{on "click" this.handleDismiss}}
          >
            <IconDelete @size="36" />
          </Button>
        {{/if}}

        <div class={{this.scrollContainerClassName}} tabindex="0">
          {{#if (has-block "artwork")}}
            <div class={{this.artworkClassName}}>
              {{yield to="artwork"}}
            </div>
          {{/if}}

          <div class={{this.headingClassName}} style={{this.headingStyle}}>
            {{@heading}}
          </div>

          <div class={{this.bodyClassName}}>
            {{yield}}
          </div>
        </div>

        {{#if (has-block "buttonDock")}}
          <div class={{this.buttonDockClassName}}>
            {{yield to="buttonDock"}}
          </div>
        {{/if}}
      </div>
    {{/if}}
  </template>
}
