/**
 * Modal component types.
 *
 * @module basestrom/components/modal/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  default: 'default',
  full: 'full',
  auto: 'auto',
} as const;

export const ROLE = {
  dialog: 'dialog',
  alertdialog: 'alertdialog',
} as const;

export const CLOSE_SOURCE = {
  closeButton: 'closeButton',
  backdrop: 'backdrop',
  escape: 'escape',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type ModalSize = keyof typeof SIZE | string;
export type ModalRole = keyof typeof ROLE;
export type ModalCloseSource = keyof typeof CLOSE_SOURCE;

export type ModalOverrideKeys =
  | 'root'
  | 'dialogContainer'
  | 'dialog'
  | 'close'
  | 'header'
  | 'body'
  | 'footer';

export type ModalOverrides = Overrides<ModalOverrideKeys>;

export interface ModalSignature {
  Args: {
    /** Whether the modal is visible. */
    isOpen?: boolean;
    /** Called when the modal should close, with the source of the close request. */
    onClose?: (params: { closeSource: ModalCloseSource }) => void;
    /** Whether the modal can be dismissed via close button, backdrop click, or Escape. Default: true. */
    closeable?: boolean;
    /** Show the X close button. Default: true (when closeable). */
    showCloseButton?: boolean;
    /** Animate entry/exit. Default: true. */
    animate?: boolean;
    /** Auto-focus the modal on open. Default: true. */
    autoFocus?: boolean;
    /** Trap focus inside the modal while open. Default: true. */
    focusLock?: boolean;
    /** Modal width. 'default' (500px), 'full' (100%), 'auto', or any CSS width. */
    size?: ModalSize;
    /** ARIA role: 'dialog' (default) or 'alertdialog'. */
    role?: ModalRole;
    /** Accessible label for the dialog. */
    'aria-label'?: string;
    /** ID of element that labels the dialog. */
    'aria-labelledby'?: string;
    /** ID of element that describes the dialog. */
    'aria-describedby'?: string;
    /** StyleX overrides. */
    overrides?: ModalOverrides;
  };
  Blocks: {
    /** Default block - rendered inside the dialog after named blocks. */
    default: [];
    /** Heading text or markup. */
    header: [];
    /** Main body content. */
    body: [];
    /** Footer content (typically buttons). Right-aligned by default. */
    footer: [];
  };
  Element: HTMLDivElement;
}
