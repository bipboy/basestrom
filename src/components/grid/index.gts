/**
 * Grid + Cell - responsive layout grid system.
 *
 * Based on baseweb's layout-grid. Uses a 4/8/12 column system
 * with responsive breakpoints at 320/600/1136px.
 *
 * Supports:
 * - @behavior: 'fluid' (default) or 'fixed' (centers at max-width)
 * - @gridStyle: 'default' (theme values) or 'compact' (preset values)
 * - @gridColumns, @gridGutters, @gridMargins: custom responsive values
 * - Cell @order: control flex order at each breakpoint
 *
 * Usage:
 * ```hbs
 * <Bst::Grid @behavior="fixed" @gridStyle="compact">
 *   <Bst::Cell @span={{array 4 4 6}}>Left</Bst::Cell>
 *   <Bst::Cell @span={{array 4 4 6}}>Right</Bst::Cell>
 * </Bst::Grid>
 * ```
 *
 * Span values are [small, medium, large] where:
 * - small: out of 4 columns (default)
 * - medium: out of 8 columns (default)
 * - large: out of 12 columns (default)
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { cellStyles, gridStyles } from './styles.stylex';
import {
  BEHAVIOR,
  GRID_STYLE,
  type CellOverrides,
  type CellSignature,
  type GridAlignment,
  type GridBehavior,
  type GridOverrides,
  type GridSignature,
  type GridStylePreset,
} from './types';

export {
  BEHAVIOR,
  GRID_STYLE, type CellOverrides,
  type CellSignature, type GridAlignment, type GridBehavior, type GridOverrides, type GridSignature, type GridStylePreset
};

/** Preset values for 'compact' grid style (matches baseweb). */
const COMPACT_PRESET = {
  columns: [4, 8, 12] as const,
  gutters: [16, 16, 16] as const,
  margins: [16, 24, 24] as const,
  maxWidth: 1280,
};

// --- Grid ---

export class Grid extends Component<GridSignature> {
  get behavior(): GridBehavior {
    return this.args.behavior ?? 'fluid';
  }

  get maxWidth(): number {
    if (this.args.maxWidth != null) return this.args.maxWidth;
    if (this.args.gridStyle === 'compact') return COMPACT_PRESET.maxWidth;
    return 1280;
  }

  get wrapperStyle(): string {
    const parts: string[] = [];
    if (this.behavior === 'fixed') {
      parts.push(`max-width:${this.maxWidth}px`);
      parts.push('margin-left:auto');
      parts.push('margin-right:auto');
    } else {
      parts.push(`max-width:${this.maxWidth}px`);
    }
    return htmlSafe(parts.join(';')).toString();
  }

  get wrapperClassName(): string | undefined {
    const { className } = stylex.props(
      gridStyles.wrapper,
      this.behavior === 'fluid' && gridStyles.wrapperFluid,
      gridStyles.marginSmall,
      gridStyles.marginMedium,
      gridStyles.marginLarge,
    );
    return className || undefined;
  }

  get gridClassName(): string | undefined {
    const align = this.args.align;
    const alignStyle = align === 'center'
      ? gridStyles.alignCenter
      : align === 'end'
        ? gridStyles.alignEnd
        : align === 'start'
          ? gridStyles.alignStart
          : null;

    const overrideResolved = resolveOverride(gridStyles.grid, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...overrideResolved,
      gridStyles.gutterSmall,
      gridStyles.gutterMedium,
      gridStyles.gutterLarge,
      alignStyle,
    );
    return className || undefined;
  }

  <template>
    <div
      class={{this.wrapperClassName}}
      style={{this.wrapperStyle}}
      data-basestrom="grid-wrapper"
    >
      <div
        class={{this.gridClassName}}
        ...attributes
        data-basestrom="grid"
      >
        {{yield}}
      </div>
    </div>
  </template>
}

// --- Cell ---

export class Cell extends Component<CellSignature> {
  get className(): string | undefined {
    const overrideResolved = resolveOverride(cellStyles.base, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...overrideResolved,
      cellStyles.gutterSmall,
      cellStyles.gutterMedium,
      cellStyles.gutterLarge,
      this.spanStyle('small'),
      this.spanStyle('medium'),
      this.spanStyle('large'),
      this.skipStyle('small'),
      this.skipStyle('medium'),
      this.skipStyle('large'),
      this.orderStyle('small'),
      this.orderStyle('medium'),
      this.orderStyle('large'),
      this.alignStyle,
    );
    return className || undefined;
  }

  get alignStyle() {
    const align = this.args.align;
    if (align === 'center') return cellStyles.alignCenter;
    if (align === 'end') return cellStyles.alignEnd;
    if (align === 'start') return cellStyles.alignStart;
    return null;
  }

  private getResponsiveValue(value: number | readonly number[] | undefined, index: number): number | undefined {
    if (value === undefined) return undefined;
    if (typeof value === 'number') return value;
    return value[index] ?? value[value.length - 1];
  }

  private spanStyle(breakpoint: 'small' | 'medium' | 'large') {
    const index = breakpoint === 'small' ? 0 : breakpoint === 'medium' ? 1 : 2;
    const span = this.getResponsiveValue(this.args.span, index);
    if (!span) return breakpoint === 'small' ? cellStyles.spanSmall4 : null; // default full width on small

    const key = `span${breakpoint.charAt(0).toUpperCase() + breakpoint.slice(1)}${span}` as keyof typeof cellStyles;
    return cellStyles[key] ?? null;
  }

  private skipStyle(breakpoint: 'small' | 'medium' | 'large') {
    const index = breakpoint === 'small' ? 0 : breakpoint === 'medium' ? 1 : 2;
    const skip = this.getResponsiveValue(this.args.skip, index);
    if (!skip) return null;

    const key = `skip${breakpoint.charAt(0).toUpperCase() + breakpoint.slice(1)}${skip}` as keyof typeof cellStyles;
    return cellStyles[key] ?? null;
  }

  private orderStyle(breakpoint: 'small' | 'medium' | 'large') {
    const index = breakpoint === 'small' ? 0 : breakpoint === 'medium' ? 1 : 2;
    const order = this.getResponsiveValue(this.args.order, index);
    if (order === undefined) return null;

    const key = `order${breakpoint.charAt(0).toUpperCase() + breakpoint.slice(1)}${order}` as keyof typeof cellStyles;
    return cellStyles[key] ?? null;
  }

  <template>
    <div
      class={{this.className}}
      ...attributes
      data-basestrom="cell"
    >
      {{yield}}
    </div>
  </template>
}
