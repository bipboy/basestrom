/**
 * Skeleton - loading placeholder component.
 * Matches baseweb original behavior:
 * - With rows: renders flex column of row placeholders
 * - Without rows: renders a single block placeholder
 * - Animation: 135deg gradient sweep, 1.5s ease-out
 *
 * Usage:
 * ```hbs
 * <Bst::Skeleton @rows={{3}} @animation={{true}} />
 * <Bst::Skeleton @height="200px" @width="100%" @animation={{true}} />
 * ```
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type SkeletonOverrides,
  type SkeletonSignature,
} from './types';

export { type SkeletonOverrides, type SkeletonSignature };

export default class Skeleton extends Component<SkeletonSignature> {
  get isAnimated(): boolean {
    return this.args.animation ?? false;
  }

  get rowCount(): number {
    return this.args.rows ?? 0;
  }

  get hasRows(): boolean {
    return this.rowCount > 0;
  }

  get rowIndices(): number[] {
    return Array.from({ length: this.rowCount }, (_, i) => i);
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    // If no rows, the root itself is the placeholder
    const animStyle = !this.hasRows
      ? (this.isAnimated ? styles.rootAnimated : styles.rootStatic)
      : null;
    const { className } = stylex.props(...resolved, animStyle);
    return className || undefined;
  }

  get rootStyle(): string | undefined {
    const parts: string[] = [];
    if (this.args.height) parts.push(`height:${this.args.height}`);
    if (this.args.width) parts.push(`width:${this.args.width}`);
    return parts.length > 0 ? htmlSafe(parts.join(';')).toString() : undefined;
  }

  rowClassName = (index: number): string | undefined => {
    const isLast = index === this.rowCount - 1;
    const resolved = resolveOverride(styles.row, this.args.overrides, 'row');
    const { className } = stylex.props(
      ...resolved,
      this.isAnimated ? styles.rowAnimated : styles.rowStatic,
      isLast ? styles.rowLast : styles.rowSpacing,
      this.args.autoSizeRows ? styles.rowAutoSize : null,
    );
    return className || undefined;
  };

  <template>
    <div
      class={{this.rootClassName}}
      style={{this.rootStyle}}
      ...attributes
      data-basestrom="skeleton"
    >
      {{#if this.hasRows}}
        {{#each this.rowIndices as |index|}}
          <div class={{this.rowClassName index}} data-basestrom="skeleton-row"></div>
        {{/each}}
      {{/if}}
    </div>
  </template>
}
