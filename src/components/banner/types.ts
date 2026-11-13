/**
 * Banner component types.
 *
 * @module basestrom/components/banner/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const ACTION_POSITION = {
  trailing: 'trailing',
  below: 'below',
} as const;

export const ARTWORK_TYPE = {
  icon: 'icon',
  badge: 'badge',
} as const;

export const HIERARCHY = {
  low: 'low',
  high: 'high',
} as const;

export const KIND = {
  info: 'info',
  negative: 'negative',
  positive: 'positive',
  warning: 'warning',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type ActionPosition = (typeof ACTION_POSITION)[keyof typeof ACTION_POSITION];
export type ArtworkType = (typeof ARTWORK_TYPE)[keyof typeof ARTWORK_TYPE];
export type Hierarchy = (typeof HIERARCHY)[keyof typeof HIERARCHY];
export type Kind = (typeof KIND)[keyof typeof KIND];

export type BannerOverrideKeys =
  | 'root'
  | 'leadingContent'
  | 'messageContent'
  | 'title'
  | 'message'
  | 'trailingContent'
  | 'trailingButtonContainer'
  | 'trailingIconButton'
  | 'belowContent'
  | 'actionButton';

export type BannerOverrides = Overrides<BannerOverrideKeys>;

export interface BannerSignature {
  Args: {
    /** Determines color scheme and conveys message intent. Default: 'info'. */
    kind?: Kind;
    /** Determines message priority by rendering in pale or saturated colors. Default: 'low'. */
    hierarchy?: Hierarchy;
    /** Bold text displayed as a title line. */
    title?: string;
    /** Message text content. */
    message?: string;
    /** Used to make the banner visually distinct from its container. */
    nested?: boolean;
    /** Action button label (trailing position). */
    actionLabel?: string;
    /** Action button click handler. */
    onActionClick?: (event: MouseEvent) => void;
    /** Action position: 'trailing' (default) or 'below'. */
    actionPosition?: ActionPosition;
    /** Icon for trailing action (renders icon button instead of text button). */
    actionIcon?: string;
    /** StyleX overrides. */
    overrides?: BannerOverrides;
    /** aria-label for the banner. */
    'aria-label'?: string;
  };
  Blocks: {
    default: [];
    artwork: [];
    action: [];
  };
  Element: HTMLDivElement;
}
