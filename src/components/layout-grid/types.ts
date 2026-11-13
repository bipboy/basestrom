import type { Overrides } from '../../helpers/overrides';

// --- Types ---

export type Responsive<T> = T | readonly T[];

export type LayoutGridBehavior = 'fluid' | 'fixed';
export type LayoutGridStyle = 'default' | 'compact';
export type LayoutGridAlignment = 'flex-start' | 'center' | 'flex-end';

export type CSSLengthUnit = 'px' | 'rem' | 'em' | '%' | 'vw' | 'vh';

// --- Context ---

export interface LayoutGridContext {
  gridColumns: readonly number[];
  gridGutters: readonly number[];
  gridGaps: readonly number[];
  gridUnit: CSSLengthUnit;
}

// --- LayoutGrid Types ---

export type LayoutGridOverrideKeys = 'root' | 'wrapper';
export type LayoutGridOverrides = Overrides<LayoutGridOverrideKeys>;

export interface LayoutGridSignature {
  Args: {
    /** Grid container behavior: 'fluid' (expands to max-width) or 'fixed' (centers at max-width). Default: 'fixed'. */
    behavior?: LayoutGridBehavior;
    /** Grid style preset: 'default' (theme values) or 'compact' (tighter spacing). */
    gridStyle?: LayoutGridStyle;
    /** Number of columns at each breakpoint [small, medium, large]. */
    gridColumns?: Responsive<number>;
    /** Gap between columns (gutter) in px at each breakpoint [small, medium, large]. */
    gridGutters?: Responsive<number>;
    /** Margin on each side of the grid container in px at each breakpoint [small, medium, large]. */
    gridMargins?: Responsive<number>;
    /** Gap between rows in px at each breakpoint [small, medium, large]. */
    gridGaps?: Responsive<number>;
    /** CSS unit for grid measurements. Default: 'px'. */
    gridUnit?: CSSLengthUnit;
    /** Maximum width of the grid container in px. Default: 1280. */
    gridMaxWidth?: number;
    /** Vertical alignment of cells at each breakpoint. */
    align?: Responsive<LayoutGridAlignment>;
    /** StyleX style overrides. */
    overrides?: LayoutGridOverrides;
  };
  Blocks: { default: [LayoutGridContext] };
  Element: HTMLDivElement;
}

// --- LayoutCell Types ---

export type LayoutCellOverrideKeys = 'root';
export type LayoutCellOverrides = Overrides<LayoutCellOverrideKeys>;

export interface LayoutCellSignature {
  Args: {
    /** Context from LayoutGrid (pass via `as |ctx|`). */
    ctx?: LayoutGridContext;
    /** Number of columns the cell should span at each breakpoint [small, medium, large]. Use 0 to hide. */
    span?: Responsive<number>;
    /** Number of columns to offset (skip) at each breakpoint [small, medium, large]. */
    skip?: Responsive<number>;
    /** Flex order at each breakpoint [small, medium, large]. */
    order?: Responsive<number>;
    /** Vertical alignment of this cell at each breakpoint. */
    align?: Responsive<LayoutGridAlignment>;
    /** Override grid columns for this cell (rarely needed). */
    gridColumns?: Responsive<number>;
    /** Override grid gutters for this cell (rarely needed). */
    gridGutters?: Responsive<number>;
    /** Override grid gaps for this cell (rarely needed). */
    gridGaps?: Responsive<number>;
    /** Override grid unit for this cell (rarely needed). */
    gridUnit?: CSSLengthUnit;
    /** StyleX style overrides. */
    overrides?: LayoutCellOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}
