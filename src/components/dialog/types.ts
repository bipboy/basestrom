/**
 * Dialog component types.
 *
 * @module basestrom/components/dialog/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  xSmall: 'xSmall',
  small: 'small',
  medium: 'medium',
  large: 'large',
} as const;

export const PLACEMENT = {
  center: 'center',
  topLeft: 'topLeft',
  topCenter: 'topCenter',
  topRight: 'topRight',
  bottomLeft: 'bottomLeft',
  bottomCenter: 'bottomCenter',
  bottomRight: 'bottomRight',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type Size = keyof typeof SIZE;
export type Placement = keyof typeof PLACEMENT;

export type DialogOverrideKeys =
  | 'root'
  | 'overlay'
  | 'scrollContainer'
  | 'heading'
  | 'body'
  | 'artwork'
  | 'buttonDock'
  | 'dismissButton';

export type DialogOverrides = Overrides<DialogOverrideKeys>;

export interface DialogSignature {
  Args: {
    /** Whether the dialog is visible. */
    isOpen: boolean;
    /** Heading text displayed at the top. */
    heading: string;
    /** Called when the dialog should close (Escape, overlay click, dismiss button). */
    onDismiss?: () => void;
    /** Show the X dismiss button. Default: true. */
    showDismissButton?: boolean;
    /** Show overlay backdrop. Default: true. */
    hasOverlay?: boolean;
    /** Max number of heading lines before truncation. Default: 2. */
    numHeadingLines?: number;
    /** Placement of the dialog on screen. Default: 'center'. */
    placement?: Placement;
    /** Size (width) of the dialog. Default: 'xSmall'. */
    size?: Size;
    /** Auto-focus dialog root on open. Default: true. */
    autoFocus?: boolean;
    /** StyleX overrides. */
    overrides?: DialogOverrides;
  };
  Blocks: {
    default: [];
    artwork: [];
    buttonDock: [];
  };
  Element: HTMLDivElement;
}
