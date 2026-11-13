/**
 * Divider component - a horizontal separator.
 * Matches baseweb original: uses border-top for the line.
 *
 * Sizes:
 * - cell: 1px border (default)
 * - section: 1px border (same as cell, semantic distinction)
 * - module: 4px (scale100) thick border
 *
 * Usage:
 * ```hbs
 * <Bst::Divider />
 * <Bst::Divider @size="module" />
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    SIZE,
    type DividerOverrides,
    type DividerSignature,
    type DividerSize,
} from './types';

export { SIZE, type DividerOverrides, type DividerSignature, type DividerSize };

export default class Divider extends Component<DividerSignature> {
  get className(): string | undefined {
    const size = this.args.size ?? 'section';
    const overrideResolved = resolveOverride(styles.base, this.args.overrides, 'root');
    const { className } = stylex.props(...overrideResolved, styles[size]);
    return className || undefined;
  }

  <template>
    <hr
      class={{this.className}}
      ...attributes
      aria-hidden="true"
      data-basestrom="divider"
    />
  </template>
}
