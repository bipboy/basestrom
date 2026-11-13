/**
 * FlexGrid + FlexGridItem - equal-width flex layout with proper gap calculation.
 *
 * Based on baseweb's flex-grid. Uses CSS calc to compute correct item widths
 * accounting for column gaps. The parent FlexGrid uses CSS `column-gap` and `row-gap`,
 * and each FlexGridItem computes its width as:
 *   width = calc((100% - (columnCount - 1) * columnGap) / columnCount)
 *
 * FlexGrid yields a context object so FlexGridItem can compute its own width.
 *
 * Usage:
 * ```hbs
 * <Bst::FlexGrid @columnCount={{3}} @columnGap="16px" @rowGap="16px" as |grid|>
 *   <Bst::FlexGridItem @grid={{grid}}>Item 1</Bst::FlexGridItem>
 *   <Bst::FlexGridItem @grid={{grid}}>Item 2</Bst::FlexGridItem>
 *   <Bst::FlexGridItem @grid={{grid}}>Item 3</Bst::FlexGridItem>
 * </Bst::FlexGrid>
 * ```
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type FlexGridContext,
  type FlexGridItemOverrides,
  type FlexGridItemSignature,
  type FlexGridOverrides,
  type FlexGridSignature,
} from './types';

export {
  type FlexGridContext,
  type FlexGridItemOverrides,
  type FlexGridItemSignature, type FlexGridOverrides,
  type FlexGridSignature
};

export class FlexGrid extends Component<FlexGridSignature> {
  get className(): string | undefined {
    const { className } = stylex.props(
      ...resolveOverride(styles.root, this.args.overrides, 'root'),
    );
    return className || undefined;
  }

  get inlineStyle(): string | undefined {
    const parts: string[] = [];
    const colGap = this.args.columnGap;
    const rowGap = this.args.rowGap;
    if (colGap) parts.push(`column-gap:${colGap}`);
    if (rowGap) parts.push(`row-gap:${rowGap}`);
    return parts.length > 0 ? htmlSafe(parts.join(';')).toString() : undefined;
  }

  get context(): FlexGridContext {
    return {
      columnCount: this.args.columnCount ?? 1,
      columnGap: this.args.columnGap ?? '0px',
      rowGap: this.args.rowGap ?? '0px',
    };
  }

  <template>
    <div
      class={{this.className}}
      style={{this.inlineStyle}}
      ...attributes
      data-basestrom="flex-grid"
    >
      {{yield this.context}}
    </div>
  </template>
}

// --- FlexGridItem ---

export class FlexGridItem extends Component<FlexGridItemSignature> {
  get className(): string | undefined {
    const { className } = stylex.props(
      ...resolveOverride(styles.item, this.args.overrides, 'root'),
    );
    return className || undefined;
  }

  /**
   * Compute inline style for proper width.
   *
   * When CSS column-gap is used on the flex parent, each item's width should be:
   *   width = calc((100% - (n - 1) * gap) / n)
   *
   * The -0.5px avoids sub-pixel rounding issues (same trick as baseweb).
   */
  get itemStyle(): string {
    const colCount = this.args.grid?.columnCount ?? 1;
    const colGap = this.args.grid?.columnGap ?? '0px';

    if (colCount <= 1) {
      return htmlSafe('width:100%').toString();
    }

    const gapQuantity = parseFloat(colGap) || 0;

    if (gapQuantity === 0) {
      // No gap - simple percentage
      const pct = (100 / colCount).toFixed(4);
      return htmlSafe(`width:${pct}%`).toString();
    }

    // With gap: parent uses column-gap, so item width accounts for the space
    // that column-gap takes from the total available width.
    // Formula: (100% - (n-1) * gap) / n
    return htmlSafe(`width:calc((100% - ${colCount - 1} * ${colGap}) / ${colCount} - 0.5px)`).toString();
  }

  <template>
    <div
      class={{this.className}}
      style={{this.itemStyle}}
      ...attributes
      data-basestrom="flex-grid-item"
    >
      {{yield}}
    </div>
  </template>
}
