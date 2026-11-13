/**
 * Modal component - port from baseweb modal.
 *
 * A controlled overlay panel that renders above the page content with a
 * semi-transparent backdrop. Closes on Escape, backdrop click, and an
 * optional close (X) button.
 *
 * Features:
 * - Sizes: 'default' (500px), 'full' (100%), 'auto', or custom CSS width
 * - Backdrop with click-to-dismiss (configurable)
 * - Escape key dismiss (configurable)
 * - Focus trap (Tab cycles inside modal)
 * - Auto-focus on open, return focus on close
 * - Body scroll lock when open
 * - Animated entry (fade backdrop, fade + slide-up dialog)
 * - Close source reported to onClose: 'closeButton' | 'backdrop' | 'escape'
 * - Named blocks for layout: <:header>, <:body>, <:footer>
 *
 * Usage:
 * ```hbs
 * <Bst::Modal @isOpen={{this.show}} @onClose={{this.handleClose}}>
 *   <:header>Confirm action</:header>
 *   <:body>Are you sure you want to proceed?</:body>
 *   <:footer>
 *     <Bst::Button @kind="tertiary" {{on "click" this.cancel}}>Cancel</Bst::Button>
 *     <Bst::Button @kind="primary" {{on "click" this.confirm}}>Confirm</Bst::Button>
 *   </:footer>
 * </Bst::Modal>
 * ```
 */
import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { trapFocus } from '../../a11y';
import { resolveOverride } from '../../helpers/overrides';
import { bstRef } from '../../modifiers';
import { styles } from './styles.stylex';
import {
    CLOSE_SOURCE,
    ROLE,
    SIZE,
    type ModalCloseSource,
    type ModalOverrides,
    type ModalRole,
    type ModalSignature,
    type ModalSize,
} from './types';

// Re-export types and constants
export {
    CLOSE_SOURCE, ROLE, SIZE, type ModalCloseSource,
    type ModalOverrides, type ModalRole, type ModalSignature, type ModalSize
};

// Make modifier available in strict-mode template with original name
const ref = bstRef;

// --- Component --------------------------------------------------------------

export default class Modal extends Component<ModalSignature> {
  @tracked private isFocusVisible = false;

  private dialogElement: HTMLElement | null = null;
  private cleanupFocusTrap: (() => void) | null = null;
  private cleanupKeydown: (() => void) | null = null;
  private cleanupBackdropClick: (() => void) | null = null;
  private savedOverflow: string | null = null;
  private previouslyFocused: HTMLElement | null = null;

  constructor(owner: any, args: ModalSignature['Args']) {
    super(owner, args);
    registerDestructor(this, () => this.teardown());
  }

  // --- Resolved props -----------------------------------------------------

  get isOpen(): boolean {
    return this.args.isOpen ?? false;
  }

  get closeable(): boolean {
    return this.args.closeable ?? true;
  }

  get showCloseButton(): boolean {
    return (this.args.showCloseButton ?? true) && this.closeable;
  }

  get animate(): boolean {
    return this.args.animate ?? true;
  }

  get autoFocus(): boolean {
    return this.args.autoFocus ?? true;
  }

  get focusLock(): boolean {
    return this.args.focusLock ?? true;
  }

  get size(): ModalSize {
    return this.args.size ?? 'default';
  }

  get role(): ModalRole {
    return this.args.role ?? 'dialog';
  }

  // --- Style getters -------------------------------------------------------

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get dialogContainerClassName(): string | undefined {
    const resolved = resolveOverride(
      styles.dialogContainer,
      this.args.overrides,
      'dialogContainer',
    );
    const { className } = stylex.props(
      ...resolved,
      this.animate && styles.dialogContainerAnimated,
    );
    return className || undefined;
  }

  get dialogSizeStyle() {
    if (this.size === 'default') return styles.sizeDefault;
    if (this.size === 'full') return styles.sizeFull;
    if (this.size === 'auto') return styles.sizeAuto;
    return null;
  }

  /** Inline style for custom (string) sizes. */
  get dialogInlineStyle(): string | undefined {
    const s = this.size;
    if (s === 'default' || s === 'full' || s === 'auto') return undefined;
    return `width:${s}`;
  }

  get dialogClassName(): string | undefined {
    const resolved = resolveOverride(styles.dialog, this.args.overrides, 'dialog');
    const { className } = stylex.props(
      ...resolved,
      this.dialogSizeStyle,
      this.animate && styles.dialogAnimated,
    );
    return className || undefined;
  }

  get closeClassName(): string | undefined {
    const resolved = resolveOverride(styles.close, this.args.overrides, 'close');
    const { className } = stylex.props(
      ...resolved,
      styles.closeHover,
      this.isFocusVisible && styles.closeFocusVisible,
    );
    return className || undefined;
  }

  get headerClassName(): string | undefined {
    const resolved = resolveOverride(styles.header, this.args.overrides, 'header');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get bodyClassName(): string | undefined {
    const resolved = resolveOverride(styles.body, this.args.overrides, 'body');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get footerClassName(): string | undefined {
    const resolved = resolveOverride(styles.footer, this.args.overrides, 'footer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // --- Setup / Teardown ---------------------------------------------------

  private setup(element: HTMLElement) {
    // Remember previously focused element for return focus on close.
    if (typeof document !== 'undefined') {
      this.previouslyFocused =
        (document.activeElement as HTMLElement | null) ?? null;
    }

    // Auto-focus the dialog (or first focusable inside via focus trap).
    if (this.autoFocus) {
      requestAnimationFrame(() => {
        element.focus({ preventScroll: true });
      });
    }

    // Focus trap.
    if (this.focusLock) {
      this.cleanupFocusTrap = trapFocus(element);
    }

    // Body scroll lock.
    if (typeof document !== 'undefined') {
      this.savedOverflow = document.body.style.overflow ?? '';
      document.body.style.overflow = 'hidden';
    }

    // Escape key.
    const handleKeydown = (event: KeyboardEvent) => {
      if (event.key === 'Escape' && this.closeable) {
        event.preventDefault();
        this.args.onClose?.({ closeSource: 'escape' });
      }
    };
    document.addEventListener('keydown', handleKeydown);
    this.cleanupKeydown = () =>
      document.removeEventListener('keydown', handleKeydown);
  }

  private teardown() {
    // Cleanup focus trap.
    if (this.cleanupFocusTrap) {
      this.cleanupFocusTrap();
      this.cleanupFocusTrap = null;
    }
    // Cleanup keydown.
    if (this.cleanupKeydown) {
      this.cleanupKeydown();
      this.cleanupKeydown = null;
    }
    // Cleanup backdrop click.
    if (this.cleanupBackdropClick) {
      this.cleanupBackdropClick();
      this.cleanupBackdropClick = null;
    }
    // Restore body scroll.
    if (this.savedOverflow !== null && typeof document !== 'undefined') {
      document.body.style.overflow = this.savedOverflow;
      this.savedOverflow = null;
    }
    // Return focus to previously-focused element.
    if (this.previouslyFocused && typeof document !== 'undefined') {
      try {
        this.previouslyFocused.focus({ preventScroll: true });
      } catch {
        // Element may have been removed; ignore.
      }
      this.previouslyFocused = null;
    }
    this.dialogElement = null;
  }

  // --- Refs / handlers ---------------------------------------------------

  captureDialog = (el: Element | null) => {
    if (el) {
      this.dialogElement = el as HTMLElement;
      this.setup(el as HTMLElement);
    } else {
      this.teardown();
    }
  };

  handleBackdropClick = (event: MouseEvent) => {
    if (!this.closeable) return;
    // Only treat clicks ON the container itself (the backdrop) - not on
    // the dialog or its children.
    if (event.target === event.currentTarget) {
      this.args.onClose?.({ closeSource: 'backdrop' });
    }
  };

  handleCloseClick = () => {
    this.args.onClose?.({ closeSource: 'closeButton' });
  };

  handleCloseFocus = (event: FocusEvent) => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleCloseBlur = () => {
    this.isFocusVisible = false;
  };

  <template>
    {{! template-lint-disable no-invalid-interactive }}
    {{#if this.isOpen}}
      <div
        class={{this.rootClassName}}
        data-basestrom="modal-root"
      >
        <div
          class={{this.dialogContainerClassName}}
          data-basestrom="modal-container"
          {{on "click" this.handleBackdropClick}}
        >
          <div
            class={{this.dialogClassName}}
            style={{this.dialogInlineStyle}}
            role={{this.role}}
            aria-modal="true"
            aria-label={{@aria-label}}
            aria-labelledby={{@aria-labelledby}}
            aria-describedby={{@aria-describedby}}
            tabindex="-1"
            data-basestrom="modal"
            ...attributes
            {{bstRef this.captureDialog}}
          >
            {{#if this.showCloseButton}}
              <button
                type="button"
                class={{this.closeClassName}}
                aria-label="Close"
                {{on "click" this.handleCloseClick}}
                {{on "focus" this.handleCloseFocus}}
                {{on "blur" this.handleCloseBlur}}
              >
                <svg
                  width="10"
                  height="10"
                  viewBox="0 0 10 10"
                  xmlns="http://www.w3.org/2000/svg"
                  aria-hidden="true"
                  focusable="false"
                >
                  <path
                    d="M9 1L5 5M1 9L5 5M5 5L1 1M5 5L9 9"
                    stroke="currentColor"
                    stroke-width="2"
                    stroke-linecap="round"
                  ></path>
                </svg>
              </button>
            {{/if}}

            {{#if (has-block "header")}}
              <div class={{this.headerClassName}} data-basestrom="modal-header">
                {{yield to="header"}}
              </div>
            {{/if}}

            {{#if (has-block "body")}}
              <div class={{this.bodyClassName}} data-basestrom="modal-body">
                {{yield to="body"}}
              </div>
            {{/if}}

            {{yield}}

            {{#if (has-block "footer")}}
              <div class={{this.footerClassName}} data-basestrom="modal-footer">
                {{yield to="footer"}}
              </div>
            {{/if}}
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}
