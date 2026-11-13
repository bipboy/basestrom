/**
 * LayoutGrid + LayoutCell - full-featured responsive layout grid.
 *
 * A complete port of baseweb's layout-grid system. Uses a responsive
 * column/gutter/margin system with CSS calc for precise cell sizing.
 *
 * This is the primary layout primitive for building application layouts.
 * It supports responsive breakpoints, configurable column counts,
 * gutters, margins, and two behavior modes (fluid/fixed).
 *
 * ## Architecture
 *
 * LayoutGrid yields a context object that LayoutCell consumes.
 * This enables cells to inherit grid-level settings (columns, gutters, gaps, unit)
 * without repeating them on every cell.
 *
 * ## Breakpoints
 *
 * Default breakpoints (matching baseweb):
 * - Small: 0px+ (mobile, 4 columns)
 * - Medium: 600px+ (tablet, 8 columns)
 * - Large: 1136px+ (desktop, 12 columns)
 *
 * ## Usage - Basic App Layout
 *
 * ```hbs
 * <Bst::LayoutGrid @gridStyle="compact" as |ctx|>
 *   {{! Full-width header }}
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 8 12}}>
 *     <AppHeader />
 *   </Bst::LayoutCell>
 *
 *   {{! Sidebar + Main content }}
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 2 3}}>
 *     <Sidebar />
 *   </Bst::LayoutCell>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 6 9}}>
 *     <MainContent />
 *   </Bst::LayoutCell>
 *
 *   {{! Full-width footer }}
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 8 12}}>
 *     <AppFooter />
 *   </Bst::LayoutCell>
 * </Bst::LayoutGrid>
 * ```
 *
 * ## Usage - Fixed-width centered layout
 *
 * ```hbs
 * <Bst::LayoutGrid @behavior="fixed" @gridMaxWidth={{960}} as |ctx|>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 4 6}} @skip={{array 0 2 3}}>
 *     Centered content block
 *   </Bst::LayoutCell>
 * </Bst::LayoutGrid>
 * ```
 *
 * ## Usage - Custom columns and gutters
 *
 * ```hbs
 * <Bst::LayoutGrid
 *   @gridColumns={{array 2 4 6}}
 *   @gridGutters={{array 8 16 24}}
 *   @gridMargins={{array 8 16 32}}
 *   @gridGaps={{array 8 8 16}}
 *   as |ctx|
 * >
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 1 2 3}}>Half width</Bst::LayoutCell>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 1 2 3}}>Half width</Bst::LayoutCell>
 * </Bst::LayoutGrid>
 * ```
 *
 * ## Usage - Responsive order
 *
 * ```hbs
 * <Bst::LayoutGrid as |ctx|>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 4 6}} @order={{array 2 2 1}}>
 *     Appears second on mobile, first on desktop
 *   </Bst::LayoutCell>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 4 6}} @order={{array 1 1 2}}>
 *     Appears first on mobile, second on desktop
 *   </Bst::LayoutCell>
 * </Bst::LayoutGrid>
 * ```
 *
 * ## Usage - Hide cell at breakpoint (span=0)
 *
 * ```hbs
 * <Bst::LayoutGrid as |ctx|>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 0 0 3}}>
 *     Only visible on large screens (desktop sidebar)
 *   </Bst::LayoutCell>
 *   <Bst::LayoutCell @ctx={{ctx}} @span={{array 4 8 9}}>
 *     Main content (full width on mobile/tablet)
 *   </Bst::LayoutCell>
 * </Bst::LayoutGrid>
 * ```
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { cellStyles, gridStyles, gridWrapperStyles } from './styles.stylex';
import {
  type CSSLengthUnit,
  type LayoutCellOverrides,
  type LayoutCellSignature,
  type LayoutGridAlignment,
  type LayoutGridBehavior,
  type LayoutGridContext,
  type LayoutGridOverrides,
  type LayoutGridSignature,
  type LayoutGridStyle,
  type Responsive,
} from './types';

export {
  type CSSLengthUnit, type LayoutCellOverrides,
  type LayoutCellSignature, type LayoutGridAlignment, type LayoutGridBehavior, type LayoutGridContext,
  type LayoutGridOverrides,
  type LayoutGridSignature, type LayoutGridStyle, type Responsive
};

// --- Constants ---

const BREAKPOINTS = [0, 600, 1136] as const;

const COMPACT_PRESET = {
  columns: [4, 8, 12] as readonly number[],
  gutters: [16, 16, 16] as readonly number[],
  margins: [16, 24, 24] as readonly number[],
  gaps: [0, 0, 0] as readonly number[],
  unit: 'px' as CSSLengthUnit,
  maxWidth: 1280,
};

const DEFAULT_COLUMNS = [4, 8, 12] as readonly number[];
const DEFAULT_GUTTERS = [16, 36, 36] as readonly number[];
const DEFAULT_MARGINS = [16, 36, 64] as readonly number[];
const DEFAULT_GAPS = [0, 0, 0] as readonly number[];
const DEFAULT_UNIT: CSSLengthUnit = 'px';
const DEFAULT_MAX_WIDTH = 1280;

// --- Context ---

// --- Helpers ---

function toArray<T>(value: Responsive<T> | undefined, fallback: readonly T[]): readonly T[] {
  if (value === undefined || value === null) return fallback;
  if (Array.isArray(value)) return value;
  return [value as T, value as T, value as T];
}

function getAt<T>(arr: readonly T[], index: number): T {
  return arr[index] ?? arr[arr.length - 1]!;
}

function buildMediaQuery(minWidth: number): string {
  return `@media screen and (min-width: ${minWidth}px)`;
}

// --- LayoutGrid ---

export class LayoutGrid extends Component<LayoutGridSignature> {
  get preset() {
    return this.args.gridStyle === 'compact' ? COMPACT_PRESET : null;
  }

  get behavior(): LayoutGridBehavior {
    return this.args.behavior ?? 'fixed';
  }

  get unit(): CSSLengthUnit {
    return this.args.gridUnit ?? this.preset?.unit ?? DEFAULT_UNIT;
  }

  get columns(): readonly number[] {
    return toArray(this.args.gridColumns, this.preset?.columns ?? DEFAULT_COLUMNS);
  }

  get gutters(): readonly number[] {
    return toArray(this.args.gridGutters, this.preset?.gutters ?? DEFAULT_GUTTERS);
  }

  get margins(): readonly number[] {
    return toArray(this.args.gridMargins, this.preset?.margins ?? DEFAULT_MARGINS);
  }

  get gaps(): readonly number[] {
    return toArray(this.args.gridGaps, this.preset?.gaps ?? DEFAULT_GAPS);
  }

  get maxWidth(): number {
    return this.args.gridMaxWidth ?? this.preset?.maxWidth ?? DEFAULT_MAX_WIDTH;
  }

  get alignArr(): readonly (LayoutGridAlignment | null)[] {
    if (!this.args.align) return [null, null, null];
    if (Array.isArray(this.args.align)) return this.args.align as LayoutGridAlignment[];
    return [this.args.align as LayoutGridAlignment, this.args.align as LayoutGridAlignment, this.args.align as LayoutGridAlignment];
  }

  // --- Wrapper styles ---

  get wrapperClassName(): string | undefined {
    const resolved = resolveOverride(gridWrapperStyles.base, this.args.overrides, 'wrapper');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get wrapperInlineStyle(): string | undefined {
    if (this.behavior === 'fixed') {
      // Fixed: max-width includes margins on the largest breakpoint
      const largestMargin = getAt(this.margins, BREAKPOINTS.length - 1);
      const mw = this.maxWidth + 2 * largestMargin - 1;
      return htmlSafe(`max-width:${mw}${this.unit}`).toString();
    }
    return undefined;
  }

  // --- Grid styles ---

  get gridClassName(): string | undefined {
    const resolved = resolveOverride(gridStyles.base, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get gridInlineStyle(): string {
    const unit = this.unit;
    const parts: string[] = [];

    // Base styles (smallest breakpoint, no media query - applied via inline style)
    const margin0 = getAt(this.margins, 0);
    const gutter0 = getAt(this.gutters, 0);
    const align0 = getAt(this.alignArr, 0);

    parts.push(`padding-left:${margin0}${unit}`);
    parts.push(`padding-right:${margin0}${unit}`);
    parts.push(`margin-left:-${gutter0 / 2}${unit}`);
    parts.push(`margin-right:-${gutter0 / 2}${unit}`);
    if (align0) parts.push(`align-items:${align0}`);

    if (this.behavior === 'fixed') {
      const largestMargin = getAt(this.margins, BREAKPOINTS.length - 1);
      const mw = this.maxWidth + 2 * largestMargin - 1;
      parts.push(`max-width:${mw}${unit}`);
    }

    return htmlSafe(parts.join(';')).toString();
  }

  // --- Context ---

  get context(): LayoutGridContext {
    return {
      gridColumns: this.columns,
      gridGutters: this.gutters,
      gridGaps: this.gaps,
      gridUnit: this.unit,
    };
  }

  // --- Responsive CSS (injected as <style> tag) ---

  get responsiveStyleTag(): string {
    const unit = this.unit;
    const id = `lg-${this.gridId}`;
    let css = '';

    // Base styles (smallest breakpoint)
    {
      const margin0 = getAt(this.margins, 0);
      const gutter0 = getAt(this.gutters, 0);
      const align0 = getAt(this.alignArr, 0);

      let rules = '';
      rules += `padding-left:${margin0}${unit};`;
      rules += `padding-right:${margin0}${unit};`;
      rules += `margin-left:-${gutter0 / 2}${unit};`;
      rules += `margin-right:-${gutter0 / 2}${unit};`;
      if (align0) rules += `align-items:${align0};`;

      if (this.behavior === 'fixed') {
        const largestMargin = getAt(this.margins, BREAKPOINTS.length - 1);
        const mw = this.maxWidth + 2 * largestMargin - 1;
        rules += `max-width:${mw}${unit};`;
      }

      css += `[data-layout-grid-id="${id}"]{${rules}}`;
    }

    // Responsive breakpoints
    for (let i = 1; i < BREAKPOINTS.length; i++) {
      const bp = BREAKPOINTS[i];
      const margin = getAt(this.margins, i);
      const gutter = getAt(this.gutters, i);
      const align = getAt(this.alignArr, i);

      let rules = '';
      rules += `padding-left:${margin}${unit};`;
      rules += `padding-right:${margin}${unit};`;
      rules += `margin-left:-${gutter / 2}${unit};`;
      rules += `margin-right:-${gutter / 2}${unit};`;
      if (align) rules += `align-items:${align};`;

      css += `@media screen and (min-width:${bp}px){[data-layout-grid-id="${id}"]{${rules}}}`;
    }

    return css;
  }

  private _gridId: string | null = null;
  get gridId(): string {
    if (!this._gridId) {
      this._gridId = `${++LayoutGrid._counter}`;
    }
    return this._gridId;
  }

  private static _counter = 0;

  <template>
    {{! template-lint-disable no-forbidden-elements }}
    {{! Inject responsive styles for this grid instance }}
    <style>{{this.responsiveStyleTag}}</style>
    <div
      class={{this.wrapperClassName}}
      style={{this.wrapperInlineStyle}}
      data-basestrom="layout-grid-wrapper"
    >
      <div
        class={{this.gridClassName}}
        data-layout-grid-id="lg-{{this.gridId}}"
        ...attributes
        data-basestrom="layout-grid"
      >
        {{yield this.context}}
      </div>
    </div>
  </template>
}

// --- LayoutCell ---

export class LayoutCell extends Component<LayoutCellSignature> {
  get columns(): readonly number[] {
    return toArray(this.args.gridColumns, this.args.ctx?.gridColumns ?? DEFAULT_COLUMNS);
  }

  get gutters(): readonly number[] {
    return toArray(this.args.gridGutters, this.args.ctx?.gridGutters ?? DEFAULT_GUTTERS);
  }

  get gaps(): readonly number[] {
    return toArray(this.args.gridGaps, this.args.ctx?.gridGaps ?? DEFAULT_GAPS);
  }

  get unit(): CSSLengthUnit {
    return this.args.gridUnit ?? this.args.ctx?.gridUnit ?? DEFAULT_UNIT;
  }

  get spanArr(): readonly number[] {
    return toArray(this.args.span, [1, 1, 1]);
  }

  get skipArr(): readonly number[] {
    return toArray(this.args.skip, [0, 0, 0]);
  }

  get orderArr(): readonly (number | null)[] {
    if (!this.args.order) return [null, null, null];
    if (Array.isArray(this.args.order)) return this.args.order as (number | null)[];
    return [this.args.order as number, this.args.order as number, this.args.order as number];
  }

  get alignArr(): readonly (LayoutGridAlignment | null)[] {
    if (!this.args.align) return [null, null, null];
    if (Array.isArray(this.args.align)) return this.args.align as LayoutGridAlignment[];
    return [this.args.align as LayoutGridAlignment, this.args.align as LayoutGridAlignment, this.args.align as LayoutGridAlignment];
  }

  get cellClassName(): string | undefined {
    const resolved = resolveOverride(cellStyles.base, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  /** Base inline style (smallest breakpoint). */
  get cellInlineStyle(): string {
    const unit = this.unit;
    const span0 = getAt(this.spanArr, 0);
    const skip0 = getAt(this.skipArr, 0);
    const cols0 = getAt(this.columns, 0);
    const gutter0 = getAt(this.gutters, 0);
    const gap0 = getAt(this.gaps, 0);
    const order0 = getAt(this.orderArr, 0);
    const align0 = getAt(this.alignArr, 0);

    if (span0 === 0) {
      return 'width:0;padding-left:0;padding-right:0;margin-left:0;margin-right:0;display:none';
    }

    const effectiveSpan = Math.min(span0, cols0);
    const effectiveSkip = Math.min(skip0, cols0 - 1);
    const widthPct = (100 / cols0) * effectiveSpan;
    const skipPct = (100 / cols0) * effectiveSkip;

    const parts: string[] = [];
    parts.push(`display:block`);
    parts.push(`width:calc(${widthPct}% - ${gutter0}${unit})`);

    if (effectiveSkip > 0) {
      parts.push(`margin-left:calc(${skipPct}% + ${gutter0 / 2}${unit})`);
    } else {
      parts.push(`margin-left:${gutter0 / 2}${unit}`);
    }
    parts.push(`margin-right:${gutter0 / 2}${unit}`);

    if (gap0 > 0) parts.push(`margin-bottom:${gap0}${unit}`);
    if (align0) parts.push(`align-self:${align0}`);
    if (order0 !== null) parts.push(`order:${order0}`);

    return parts.join(';');
  }

  /** Responsive CSS for this cell (injected via <style> tag). */
  get responsiveStyleTag(): string {
    const unit = this.unit;
    const id = `lc-${this.cellId}`;
    let css = '';

    // Base styles (smallest breakpoint - no media query wrapper)
    {
      const span0 = getAt(this.spanArr, 0);
      const skip0 = getAt(this.skipArr, 0);
      const cols0 = getAt(this.columns, 0);
      const gutter0 = getAt(this.gutters, 0);
      const gap0 = getAt(this.gaps, 0);
      const order0 = getAt(this.orderArr, 0);
      const align0 = getAt(this.alignArr, 0);

      let rules = '';
      if (span0 === 0) {
        rules = 'width:0;padding-left:0;padding-right:0;margin-left:0;margin-right:0;display:none;';
      } else {
        const effectiveSpan = Math.min(span0, cols0);
        const effectiveSkip = Math.min(skip0, cols0 - 1);
        const widthPct = (100 / cols0) * effectiveSpan;
        const skipPct = (100 / cols0) * effectiveSkip;

        rules += `display:block;`;
        rules += `width:calc(${widthPct}% - ${gutter0}${unit});`;

        if (effectiveSkip > 0) {
          rules += `margin-left:calc(${skipPct}% + ${gutter0 / 2}${unit});`;
        } else {
          rules += `margin-left:${gutter0 / 2}${unit};`;
        }
        rules += `margin-right:${gutter0 / 2}${unit};`;

        if (gap0 > 0) rules += `margin-bottom:${gap0}${unit};`;
        if (align0) rules += `align-self:${align0};`;
        if (order0 !== null) rules += `order:${order0};`;
      }
      css += `[data-layout-cell-id="${id}"]{${rules}}`;
    }

    // Responsive breakpoints
    for (let i = 1; i < BREAKPOINTS.length; i++) {
      const bp = BREAKPOINTS[i];
      const span = getAt(this.spanArr, i);
      const skip = getAt(this.skipArr, i);
      const cols = getAt(this.columns, i);
      const gutter = getAt(this.gutters, i);
      const gap = getAt(this.gaps, i);
      const order = getAt(this.orderArr, i);
      const align = getAt(this.alignArr, i);

      let rules = '';

      if (span === 0) {
        rules = 'width:0;padding-left:0;padding-right:0;margin-left:0;margin-right:0;display:none;';
      } else {
        const effectiveSpan = Math.min(span, cols);
        const effectiveSkip = Math.min(skip, cols - 1);
        const widthPct = (100 / cols) * effectiveSpan;
        const skipPct = (100 / cols) * effectiveSkip;

        rules += `display:block;`;
        rules += `width:calc(${widthPct}% - ${gutter}${unit});`;

        if (effectiveSkip > 0) {
          rules += `margin-left:calc(${skipPct}% + ${gutter / 2}${unit});`;
        } else {
          rules += `margin-left:${gutter / 2}${unit};`;
        }
        rules += `margin-right:${gutter / 2}${unit};`;

        if (gap > 0) rules += `margin-bottom:${gap}${unit};`;
        if (align) rules += `align-self:${align};`;
        if (order !== null) rules += `order:${order};`;
      }

      css += `@media screen and (min-width:${bp}px){[data-layout-cell-id="${id}"]{${rules}}}`;
    }

    return css;
  }

  private _cellId: string | null = null;
  get cellId(): string {
    if (!this._cellId) {
      this._cellId = `${++LayoutCell._counter}`;
    }
    return this._cellId;
  }

  private static _counter = 0;

  <template>
    {{! template-lint-disable no-forbidden-elements }}
    <style>{{this.responsiveStyleTag}}</style>
    <div
      class={{this.cellClassName}}
      data-layout-cell-id="lc-{{this.cellId}}"
      ...attributes
      data-basestrom="layout-cell"
    >
      {{yield}}
    </div>
  </template>
}
