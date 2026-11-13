/**
 * Snackbar component types.
 *
 * @module basestrom/components/snackbar/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const DURATION = {
  infinite: 0,
  short: 3000,
  medium: 5000,
  long: 7000,
} as const;

export const PLACEMENT = {
  topLeft: 'topLeft',
  top: 'top',
  topRight: 'topRight',
  bottomLeft: 'bottomLeft',
  bottom: 'bottom',
  bottomRight: 'bottomRight',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type Duration = (typeof DURATION)[keyof typeof DURATION];
export type Placement = (typeof PLACEMENT)[keyof typeof PLACEMENT];

export type SnackbarOverrideKeys =
  | 'root'
  | 'content'
  | 'startEnhancerContainer'
  | 'spinner'
  | 'message'
  | 'wrapActionButtonContainer'
  | 'actionButtonContainer'
  | 'actionButton'
  | 'placementContainer';

export type SnackbarOverrides = Overrides<SnackbarOverrideKeys>;

// ─── SnackbarElement ────────────────────────────────────────────────────────────

export interface SnackbarElementSignature {
  Args: {
    /** Primary message displayed in snackbar. */
    message: string;
    /** Text displayed in action button. */
    actionMessage?: string;
    /** Function executed on action button click. */
    actionOnClick?: (event: MouseEvent) => void;
    /** Renders spinner in start enhancer position. */
    progress?: boolean;
    /** If action button present, focus it. Default: true. */
    focus?: boolean;
    /** StyleX overrides. */
    overrides?: SnackbarOverrides;
  };
  Blocks: {
    startEnhancer: [];
  };
  Element: HTMLDivElement;
}

// ─── SnackbarContainer ──────────────────────────────────────────────────────────

export interface SnackbarItem {
  message: string;
  actionMessage?: string;
  actionOnClick?: (event: MouseEvent) => void;
  progress?: boolean;
  duration?: Duration;
}

export interface SnackbarContainerSignature {
  Args: {
    /** Location on page where snackbar will render. Default: 'top'. */
    placement?: Placement;
    /** Default display duration in ms. Default: DURATION.short (3000). */
    defaultDuration?: Duration;
    /** StyleX overrides. */
    overrides?: SnackbarOverrides;
  };
  Blocks: {
    default: [{
      enqueue: (item: SnackbarItem) => void;
      dequeue: () => void;
    }];
  };
  Element: HTMLDivElement;
}
