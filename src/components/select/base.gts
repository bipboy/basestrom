/**
 * SelectBase component - bare native <select> with styling.
 *
 * Mirrors HDS Form::Select::Base: a thin wrapper over the browser's native
 * select element. The chevron indicator is a CSS background-image (HDS
 * flight-icons chevron-down-16).
 *
 * This component is intentionally minimal - it handles styling only.
 * For label/caption/error, use SelectField which wraps this in FormControl.
 *
 * Usage:
 * ```gts
 * <SelectBase @size="default" @isInvalid={{this.hasError}} ...attributes>
 *   <option value="">Choose...</option>
 *   <option value="a">Option A</option>
 * </SelectBase>
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  SIZE,
  type SelectBaseSignature,
  type SelectOverrides,
  type SelectSize,
} from './types';

export { SIZE, type SelectBaseSignature, type SelectOverrides, type SelectSize };

export default class SelectBase extends Component<SelectBaseSignature> {
  @tracked isFocused = false;

  // ─── Computed ─────────────────────────────────────────────────────────────

  get size(): SelectSize { return this.args.size ?? 'default'; }
  get isInvalid(): boolean { return this.args.isInvalid ?? false; }

  get isDisabled(): boolean {
    // Reads the native `disabled` attribute from ...attributes splat
    return false; // Disabled state is handled via ...attributes on the <select>
  }

  // ─── Style computations ───────────────────────────────────────────────────

  get sizeStyle() {
    switch (this.size) {
      case 'mini': return styles.sizeMini;
      case 'compact': return styles.sizeCompact;
      case 'large': return styles.sizeLarge;
      default: return styles.sizeDefault;
    }
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.sizeStyle,
      this.isFocused && (this.isInvalid ? styles.invalidFocused : styles.focused),
      !this.isFocused && this.isInvalid && styles.invalid,
    );
    return className || undefined;
  }

  /**
   * Disabled styling is applied via a separate className because the disabled
   * state comes from ...attributes (native HTML), not from an @arg.
   * We detect it in the template via the `disabled` attribute.
   */
  get disabledClassName(): string | undefined {
    const { className } = stylex.props(styles.disabled);
    return className || undefined;
  }

  get inlineStyle(): string | undefined {
    if (this.args.width) {
      return htmlSafe(`width: ${this.args.width}`).toString();
    }
    return undefined;
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleFocus = (_event: FocusEvent): void => {
    this.isFocused = true;
  };

  handleBlur = (_event: FocusEvent): void => {
    this.isFocused = false;
  };

  <template>
    <select
      class={{this.rootClassName}}
      style={{this.inlineStyle}}
      data-basestrom="select"
      {{on "focus" this.handleFocus}}
      {{on "blur" this.handleBlur}}
      ...attributes
    >
      {{yield}}
    </select>
  </template>
}
