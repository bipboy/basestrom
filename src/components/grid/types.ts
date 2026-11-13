import type { Overrides } from '../../helpers/overrides';

// --- Constants ---

export const BEHAVIOR = { fluid: 'fluid', fixed: 'fixed' } as const;
export const GRID_STYLE = { default: 'default', compact: 'compact' } as const;

export type GridBehavior = keyof typeof BEHAVIOR;
export type GridStylePreset = keyof typeof GRID_STYLE;

// --- Grid Types ---

export type GridOverrideKeys = 'root';
export type GridOverrides = Overrides<GridOverrideKeys>;

export type GridAlignment = 'start' | 'center' | 'end';

export interface GridSignature {
  Args: {
    /** Vertical alignment of cells: 'start', 'center', 'end'. */
    align?: GridAlignment;
    /** Grid container behavior: 'fluid' (expands) or 'fixed' (centers at max-width). */
    behavior?: GridBehavior;
    /** Max width of grid container in px. Defaults to 1280. */
    maxWidth?: number;
    /** Grid style preset: 'default' or 'compact'. */
    gridStyle?: GridStylePreset;
    /** Number of columns at each breakpoint [small, medium, large]. */
    gridColumns?: number | readonly number[];
    /** Gutter size in px at each breakpoint [small, medium, large]. */
    gridGutters?: number | readonly number[];
    /** Margin size in px at each breakpoint [small, medium, large]. */
    gridMargins?: number | readonly number[];
    /** StyleX style overrides. */
    overrides?: GridOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}

// --- Cell Types ---

export type CellOverrideKeys = 'root';
export type CellOverrides = Overrides<CellOverrideKeys>;

export interface CellSignature {
  Args: {
    /** Columns to span at each breakpoint [small, medium, large]. Single number applies to all. */
    span?: number | readonly [number] | readonly [number, number] | readonly [number, number, number];
    /** Columns to skip (offset) at each breakpoint. */
    skip?: number | readonly [number] | readonly [number, number] | readonly [number, number, number];
    /** Control placement order of cell in flex row at each breakpoint. */
    order?: number | readonly [number] | readonly [number, number] | readonly [number, number, number];
    /** Vertical alignment of this cell. */
    align?: GridAlignment;
    /** StyleX style overrides. */
    overrides?: CellOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}
