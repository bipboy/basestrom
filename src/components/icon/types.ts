import type { Overrides } from '../../helpers/overrides';

export type IconOverrideKeys = 'svg';
export type IconOverrides = Overrides<IconOverrideKeys>;

export interface IconSignature {
  Args: {
    /** SVG viewBox. Default: `"0 0 24 24"`. */
    viewBox?: string;
    /** Box dimension (`16px`, `1.5rem`, ...). Default: theme `scale600` (16px). */
    size?: string;
    /** Glyph color. Default: `currentColor` (inherits parent text color). */
    color?: string;
    /** Accessible label. When omitted, the icon is hidden from AT (`aria-hidden`). */
    title?: string;
    /** StyleX overrides for the `svg` slot. */
    overrides?: IconOverrides;
  };
  Blocks: {
    default: [];
  };
  Element: SVGSVGElement;
}
