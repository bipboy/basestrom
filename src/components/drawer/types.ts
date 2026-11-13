/**
 * Drawer component types.
 *
 * @module basestrom/components/drawer/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  default: 'default',
  full: 'full',
  auto: 'auto',
} as const;

export const SIZE_DIMENSION: Record<string, string> = {
  default: '500px',
  full: '100%',
  auto: 'auto',
};

export const ANCHOR = {
  left: 'left',
  right: 'right',
  top: 'top',
  bottom: 'bottom',
} as const;

export const CLOSE_SOURCE = {
  closeButton: 'closeButton',
  backdrop: 'backdrop',
  escape: 'escape',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type Anchor = keyof typeof ANCHOR;
export type CloseSource = keyof typeof CLOSE_SOURCE;

export type DrawerOverrideKeys =
  | 'root'
  | 'backdrop'
  | 'container'
  | 'body'
  | 'close';

export type DrawerOverrides = Overrides<DrawerOverrideKeys>;

export interface DrawerSignature {
  Args: {
    /** Whether the drawer is visible. */
    isOpen: boolean;
    /** Called when the drawer should close. */
    onClose?: (params: { closeSource?: CloseSource }) => void;
    /** Which edge to anchor to. Default: 'right'. */
    anchor?: Anchor;
    /** Size: 'default' (500px), 'full', 'auto', or any CSS value. */
    size?: string;
    /** Animate open/close transitions. Default: true. */
    animate?: boolean;
    /** Whether the drawer can be closed by user. Default: true. */
    closeable?: boolean;
    /** Show backdrop overlay. Default: true. */
    showBackdrop?: boolean;
    /** Auto-focus drawer on open. Default: true. */
    autoFocus?: boolean;
    /** Called when backdrop is clicked. */
    onBackdropClick?: (event: Event) => void;
    /** StyleX overrides. */
    overrides?: DrawerOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}
