/**
 * Textarea component - complete port from baseweb textarea.
 *
 * Architecture matches baseweb's 3-layer DOM structure:
 *   Root (border container) > InputContainer (background) > Textarea (input element)
 *
 * Supports: 4 sizes (mini, compact/small, default/medium, large),
 * states (default, focus, error, disabled, positive),
 * placeholder, value binding, rows, maxLength with counter,
 * resize control, autoFocus, full aria support, focus-visible tracking.
 *
 * Usage:
 * ```hbs
 * <Bst::Textarea
 *   @value={{this.text}}
 *   @onChange={{this.handleChange}}
 *   @placeholder="Enter text..."
 *   @size="default"
 *   @rows={{5}}
 *   @maxLength={{200}}
 *   @resize="vertical"
 * />
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    SIZE,
    type TextareaOverrides,
    type TextareaResize,
    type TextareaSignature,
    type TextareaSize,
} from './types';

// Re-export types and constants
export {
    SIZE, type TextareaOverrides, type TextareaResize, type TextareaSignature, type TextareaSize
};

export default class Textarea extends Component<TextareaSignature> {
  @tracked isFocused = false;
  @tracked isFocusVisible = false;

  get size(): TextareaSize { return this.args.size ?? 'default'; }
  get rows(): number { return this.args.rows ?? 3; }
  get resize(): TextareaResize { return this.args.resize ?? 'none'; }
  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get isError(): boolean { return this.args.error ?? false; }
  get isPositive(): boolean { return this.args.positive ?? false; }
  get isReadOnly(): boolean { return this.args.readOnly ?? false; }
  get isRequired(): boolean { return this.args.required ?? false; }
  get maxLength(): number | undefined { return this.args.maxLength; }

  get charCount(): number {
    return this.args.value?.length ?? 0;
  }

  get showCounter(): boolean {
    return this.maxLength !== undefined;
  }

  get isOverLimit(): boolean {
    return this.maxLength !== undefined && this.charCount > this.maxLength;
  }

  // ─── Font style (applied to root, inherited by textarea) ──────────────────

  get fontStyle() {
    switch (this.size) {
      case 'mini': return styles.fontMini;
      case 'compact': return styles.fontCompact;
      case 'large': return styles.fontLarge;
      default: return styles.fontDefault;
    }
  }

  // ─── Root state style ─────────────────────────────────────────────────────

  get rootStateStyle() {
    if (this.isDisabled) return styles.rootDisabled;
    if (this.isFocused) return styles.rootFocused;
    if (this.isError) return styles.rootError;
    if (this.isPositive) return styles.rootPositive;
    return null;
  }

  // ─── InputContainer state style ───────────────────────────────────────────

  get inputContainerStateStyle() {
    if (this.isDisabled) return styles.inputContainerDisabled;
    if (this.isFocused) return styles.inputContainerFocused;
    if (this.isError) return styles.inputContainerError;
    if (this.isPositive) return styles.inputContainerPositive;
    return null;
  }

  // ─── Textarea padding style ───────────────────────────────────────────────

  get textareaPaddingStyle() {
    switch (this.size) {
      case 'mini': return styles.sizeMini;
      case 'compact': return styles.sizeCompact;
      case 'large': return styles.sizeLarge;
      default: return styles.sizeDefault;
    }
  }

  // ─── Textarea resize style ────────────────────────────────────────────────

  get textareaResizeStyle() {
    switch (this.resize) {
      case 'vertical': return styles.resizeVertical;
      case 'horizontal': return styles.resizeHorizontal;
      case 'both': return styles.resizeBoth;
      default: return styles.resizeNone;
    }
  }

  // ─── Class name getters ───────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');

    const { className } = stylex.props(
      ...resolved,
      this.fontStyle,
      this.size === 'mini' && styles.rootMini,
      this.rootStateStyle,
      this.resize !== 'none' && styles.rootResizable,
    );
    return className || undefined;
  }

  get inputContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.inputContainer, this.args.overrides, 'inputContainer');

    const { className } = stylex.props(
      ...resolved,
      this.fontStyle,
      this.inputContainerStateStyle,
    );
    return className || undefined;
  }

  get textareaClassName(): string | undefined {
    const resolved = resolveOverride(styles.textarea, this.args.overrides, 'textarea');

    const { className } = stylex.props(
      ...resolved,
      this.textareaPaddingStyle,
      this.textareaResizeStyle,
      this.isDisabled && styles.textareaDisabled,
    );
    return className || undefined;
  }

  get counterClassName(): string | undefined {
    const resolved = resolveOverride(styles.counter, this.args.overrides, 'counter');

    const { className } = stylex.props(
      ...resolved,
      this.isOverLimit && styles.counterError,
    );
    return className || undefined;
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleFocus = (event: FocusEvent) => {
    this.isFocused = true;
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleBlur = () => {
    requestAnimationFrame(() => {
      this.isFocused = false;
      this.isFocusVisible = false;
    });
  };

  handleInput = (event: Event) => {
    this.args.onChange?.(event);
  };

  <template>
    {{! template-lint-disable no-autofocus-attribute }}
    <div
      class={{this.rootClassName}}
      data-basestrom="textarea"
    >
      <div class={{this.inputContainerClassName}}>
        <textarea
          class={{this.textareaClassName}}
          value={{@value}}
          placeholder={{@placeholder}}
          rows={{this.rows}}
          maxlength={{this.maxLength}}
          disabled={{this.isDisabled}}
          readonly={{this.isReadOnly}}
          required={{this.isRequired}}
          id={{@id}}
          name={{@name}}
          aria-label={{@aria-label}}
          aria-describedby={{@aria-describedby}}
          aria-errormessage={{@aria-errormessage}}
          aria-invalid={{if this.isError "true"}}
          aria-required={{if this.isRequired "true"}}
          autofocus={{@autoFocus}}
          ...attributes
          {{on "input" this.handleInput}}
          {{on "focus" this.handleFocus}}
          {{on "blur" this.handleBlur}}
        ></textarea>
      </div>
    </div>
    {{#if this.showCounter}}
      <div class={{this.counterClassName}} data-basestrom="textarea-counter">
        {{this.charCount}}/{{this.maxLength}}
      </div>
    {{/if}}
  </template>
}
