import type { Overrides } from '../../helpers/overrides';

// --- FlexGrid Context (yielded to children) ---

export interface FlexGridContext {
  columnCount: number;
  columnGap: string;
  rowGap: string;
}

// --- FlexGrid Types ---

export type FlexGridOverrideKeys = 'root';
export type FlexGridOverrides = Overrides<FlexGridOverrideKeys>;

export interface FlexGridSignature {
  Args: {
    /** Number of equal-width columns. Defaults to 1. */
    columnCount?: number;
    /** Gap between columns (CSS value, e.g. '16px', '1rem'). Defaults to '0px'. */
    columnGap?: string;
    /** Gap between rows (CSS value). Defaults to '0px'. */
    rowGap?: string;
    /** StyleX style overrides. */
    overrides?: FlexGridOverrides;
  };
  Blocks: { default: [FlexGridContext] };
  Element: HTMLDivElement;
}

// --- FlexGridItem Types ---

export type FlexGridItemOverrideKeys = 'root';
export type FlexGridItemOverrides = Overrides<FlexGridItemOverrideKeys>;

export interface FlexGridItemSignature {
  Args: {
    /** Context from FlexGrid (pass via `as |grid|`). */
    grid?: FlexGridContext;
    /** StyleX style overrides. */
    overrides?: FlexGridItemOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}
