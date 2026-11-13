/**
 * Spinner component - port from baseweb spinner.
 *
 * A circular loading indicator. Rotates infinitely with a linear timing.
 *
 * ## Sizes
 *
 * Three named sizes that bind both the box and the border width:
 * - `small`  → 24px box, 2px border
 * - `medium` → 32px box, 4px border (default)
 * - `large`  → 40px box, 8px border
 *
 * Custom dimensions are also supported by passing CSS lengths to
 * `@boxSize` / `@borderWidth` (e.g. `"48px"`, `"3rem"`).
 *
 * ## Colors
 *
 * The "moving" arc on top uses theme `contentAccent` by default. The other
 * three sides use `backgroundTertiary`. Pass `@color` to override the top
 * (active) color with any CSS color string or theme variable.
 *
 * ## Usage
 *
 * ```hbs
 * <Bst::Spinner />
 * <Bst::Spinner @size="large" />
 * <Bst::Spinner @color="#FF0000" />
 * <Bst::Spinner @boxSize="48px" @borderWidth="6px" />
 * ```
 *
 * Inside other components (e.g. Button loading state) use the @overrides API
 * to merge custom StyleX styles onto the root.
 */
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { styles } from './styles.stylex';
import {
  SIZE,
  type SpinnerOverrides,
  type SpinnerSignature,
  type SpinnerSize,
} from './types';

export { SIZE, type SpinnerOverrides, type SpinnerSignature, type SpinnerSize };

export default class Spinner extends Component<SpinnerSignature> {
  get size(): SpinnerSize {
    return this.args.size ?? 'medium';
  }

  get sizeStyle() {
    switch (this.size) {
      case 'small': return styles.sizeSmall;
      case 'large': return styles.sizeLarge;
      default: return styles.sizeMedium;
    }
  }

  get borderStyle() {
    switch (this.size) {
      case 'small': return styles.borderSmall;
      case 'large': return styles.borderLarge;
      default: return styles.borderMedium;
    }
  }

  get rootClassName(): string | undefined {
    // Order matters: preset size/border first, override (passed via @overrides)
    // last so consumers can cleanly replace dimensions or border thickness.
    // If a custom dimension is supplied via @boxSize/@borderWidth, drop the
    // preset for that axis and rely on the inline style instead.
    const sizeStyle = this.args.boxSize ? null : this.sizeStyle;
    const borderStyle = this.args.borderWidth ? null : this.borderStyle;

    const overrideStyle = this.args.overrides?.root;
    const overrideArr = overrideStyle
      ? (Array.isArray(overrideStyle) ? overrideStyle : [overrideStyle])
      : [];

    const { className } = stylex.props(
      styles.base,
      sizeStyle,
      borderStyle,
      ...overrideArr,
    );
    return className || undefined;
  }

  /**
   * Inline style is used for two cases that StyleX cannot satisfy at runtime:
   * 1. Arbitrary @color values (top border color).
   * 2. Arbitrary @boxSize / @borderWidth (one-off sizing).
   */
  get inlineStyle(): string | undefined {
    const parts: string[] = [];
    if (this.args.color) {
      parts.push(`border-top-color:${this.args.color}`);
    }
    if (this.args.boxSize) {
      parts.push(`width:${this.args.boxSize}`);
      parts.push(`height:${this.args.boxSize}`);
    }
    if (this.args.borderWidth) {
      parts.push(`border-width:${this.args.borderWidth}`);
    }
    return parts.length > 0 ? htmlSafe(parts.join(';')).toString() : undefined;
  }

  get ariaLabel(): string {
    return this.args['aria-label'] ?? 'loading';
  }

  <template>
    <i
      class={{this.rootClassName}}
      style={{this.inlineStyle}}
      role="progressbar"
      aria-label={{this.ariaLabel}}
      aria-busy="true"
      ...attributes
      data-basestrom="spinner"
    />
  </template>
}
