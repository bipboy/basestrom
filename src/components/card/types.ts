/**
 * Card component types.
 *
 * @module basestrom/components/card/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Types ──────────────────────────────────────────────────────────────────────

export type CardOverrideKeys =
  | 'root'
  | 'headerImage'
  | 'contents'
  | 'thumbnail'
  | 'title'
  | 'body'
  | 'action';

export type CardOverrides = Overrides<CardOverrideKeys>;

export interface CardSignature {
  Args: {
    /** Content to render as the card title (rendered as heading). */
    title?: string;
    /** Image URL for the header image (full-width, top of card). */
    headerImage?: string;
    /** Alt text for header image. */
    headerImageAlt?: string;
    /** Image URL for the thumbnail (small, floated right). */
    thumbnail?: string;
    /** Alt text for thumbnail. */
    thumbnailAlt?: string;
    /** StyleX overrides. */
    overrides?: CardOverrides;
  };
  Blocks: {
    default: [];
    body: [];
    action: [];
  };
  Element: HTMLElement;
}
