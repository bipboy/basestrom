/**
 * Link component types.
 *
 * @module basestrom/components/link/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Types ──────────────────────────────────────────────────────────────────────

export type LinkOverrideKeys = 'root';
export type LinkOverrides = Overrides<LinkOverrideKeys>;

export interface LinkSignature {
  Args: {
    /** External URL. Renders a native <a> element. */
    href?: string;
    /** Ember route name. Renders via <LinkTo>. */
    route?: string;
    /** Single dynamic segment model for the route. */
    model?: unknown;
    /** Multiple dynamic segment models for the route. */
    models?: unknown[];
    /** Query params hash for the route. */
    query?: Record<string, unknown>;
    /** Link target (_blank, _self, etc). */
    target?: string;
    /** Rel attribute (e.g. "noopener noreferrer"). Auto-set for target="_blank". */
    rel?: string;
    /** Animate underline on hover (baseweb style). */
    animateUnderline?: boolean;
    /** Disable the link. */
    disabled?: boolean;
    /** StyleX style overrides. */
    overrides?: LinkOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLAnchorElement | HTMLButtonElement;
}
