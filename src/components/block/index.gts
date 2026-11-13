/**
 * Block component - a layout primitive.
 *
 * The Block component renders a `<div>` (or other element via `@as`)
 * with StyleX-based styling through the override system.
 *
 * Usage:
 *
 * ```hbs
 * <Bst::Block @overrides={{this.sectionStyles}}>
 *   Content here
 * </Bst::Block>
 * ```
 *
 * With overrides:
 *
 * ```ts
 * import * as stylex from '@stylexjs/stylex';
 * import { colors } from 'basestrom/themes/vars.stylex';
 *
 * const sectionStyles = stylex.create({
 *   root: {
 *     display: 'flex',
 *     padding: '16px',
 *     backgroundColor: colors.backgroundSecondary,
 *   },
 * });
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    type BlockOverrides,
    type BlockSignature,
} from './types';

export { type BlockOverrides, type BlockSignature };

export default class Block extends Component<BlockSignature> {
  get className(): string | undefined {
    const { className } = stylex.props(
      ...resolveOverride(styles.root, this.args.overrides, 'root'),
    );
    return className || undefined;
  }

  <template>
    <div
      class={{this.className}}
      ...attributes
      data-basestrom="block"
    >
      {{yield}}
    </div>
  </template>
}
