/**
 * AspectRatioBox - maintains a fixed aspect ratio for its content.
 *
 * Usage:
 * ```hbs
 * <Bst::AspectRatioBox @aspectRatio={{16/9}}>
 *   <img src="..." alt="..." style="width:100%;height:100%;object-fit:cover" />
 * </Bst::AspectRatioBox>
 * ```
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type AspectRatioBoxOverrides,
  type AspectRatioBoxSignature,
} from './types';

export { type AspectRatioBoxOverrides, type AspectRatioBoxSignature };

export default class AspectRatioBox extends Component<AspectRatioBoxSignature> {
  get ratio(): number {
    return this.args.aspectRatio ?? 1;
  }

  get paddingTop(): string {
    return htmlSafe(`padding-top:${(1 / this.ratio) * 100}%`).toString();
  }

  get rootClassName(): string | undefined {
    const { className } = stylex.props(
      ...resolveOverride(styles.root, this.args.overrides, 'root'),
    );
    return className || undefined;
  }

  get bodyClassName(): string | undefined {
    const { className } = stylex.props(
      ...resolveOverride(styles.body, this.args.overrides, 'body'),
    );
    return className || undefined;
  }

  <template>
    <div
      class={{this.rootClassName}}
      ...attributes
      data-basestrom="aspect-ratio-box"
    >
      <div style={{this.paddingTop}}></div>
      <div class={{this.bodyClassName}}>
        {{yield}}
      </div>
    </div>
  </template>
}
