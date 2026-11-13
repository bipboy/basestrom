/**
 * Icon component - port from baseweb icon.
 *
 * The base `<Icon>` renders an `<svg>` with sensible defaults:
 * - `viewBox="0 0 24 24"` (Uber's icon grid)
 * - `width = height = scale600` (16px) by default; override with `@size`
 * - `fill = currentColor` by default; override with `@color`
 *
 * Concrete glyph components (Hide, Show, TrashCan, Plus, Search, ...) are
 * thin wrappers around `<Icon>` that supply the inner `<path>`s and an
 * appropriate default `aria-label`.
 *
 * ## Usage
 *
 * ```hbs
 * <Bst::IconHide />
 * <Bst::IconHide @size="24px" @color="#888" />
 * <Bst::IconTrashCanFilled @title="Delete" />
 * <Bst::Icon @viewBox="0 0 24 24" @size="20px" as |Icon|>
 *   <svg:path d="M..." />
 * </Bst::Icon>
 * ```
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type IconOverrides,
  type IconSignature,
} from './types';

export { type IconOverrides, type IconSignature };

export default class Icon extends Component<IconSignature> {
  get viewBox(): string {
    return this.args.viewBox ?? '0 0 24 24';
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.base, this.args.overrides, 'svg');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  /**
   * Inline style is used so consumers can pass arbitrary CSS lengths/colors
   * without StyleX needing to know them ahead of time.
   */
  get inlineStyle(): string | undefined {
    const parts: string[] = [];
    if (this.args.size) {
      parts.push(`width:${this.args.size}`);
      parts.push(`height:${this.args.size}`);
    }
    if (this.args.color) {
      parts.push(`fill:${this.args.color}`);
      parts.push(`color:${this.args.color}`);
    }
    return parts.length > 0 ? htmlSafe(parts.join(';')).toString() : undefined;
  }

  get isDecorative(): boolean {
    return !this.args.title;
  }

  <template>
    <svg
      class={{this.rootClassName}}
      style={{this.inlineStyle}}
      viewBox={{this.viewBox}}
      xmlns="http://www.w3.org/2000/svg"
      role={{if this.isDecorative "presentation" "img"}}
      aria-hidden={{if this.isDecorative "true"}}
      aria-label={{unless this.isDecorative @title}}
      focusable="false"
      ...attributes
      data-basestrom="icon"
    >
      {{#if @title}}<title>{{@title}}</title>{{/if}}
      {{yield}}
    </svg>
  </template>
}
