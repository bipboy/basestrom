import type { Overrides } from '../../helpers/overrides';

// ─── Types ──────────────────────────────────────────────────────────────────────

export const KIND = {
  info: 'info',
  negative: 'negative',
  positive: 'positive',
  warning: 'warning',
} as const;

export type Kind = (typeof KIND)[keyof typeof KIND];

export type SystemBannerOverrideKeys =
  | 'root'
  | 'leadingContent'
  | 'messageContent'
  | 'title'
  | 'message'
  | 'trailingContent'
  | 'trailingIconButton';

export type SystemBannerOverrides = Overrides<SystemBannerOverrideKeys>;

export interface SystemBannerSignature {
  Args: {
    /** Determines color scheme. Default: 'info'. */
    kind?: Kind;
    /** Bold title text. */
    title?: string;
    /** Message text content. */
    message?: string;
    /** Primary action label (used as aria-label when banner is clickable). */
    primaryActionLabel?: string;
    /** Primary action click handler. */
    onPrimaryAction?: (event: MouseEvent) => void;
    /** Secondary action label (renders trailing button/icon). */
    secondaryActionLabel?: string;
    /** Secondary action click handler. */
    onSecondaryAction?: (event: MouseEvent) => void;
    /** StyleX overrides. */
    overrides?: SystemBannerOverrides;
    /** aria-label for the banner. */
    'aria-label'?: string;
  };
  Blocks: {
    default: [];
    artwork: [];
    secondaryIcon: [];
  };
  Element: HTMLDivElement | HTMLButtonElement;
}
