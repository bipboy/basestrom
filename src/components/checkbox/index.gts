/**
 * Checkbox component - ported from baseweb checkbox-v2.
 *
 * Full a11y support: id, required, autoFocus, aria-describedby,
 * aria-errormessage, aria-controls, indeterminate DOM property,
 * Enter key toggle, stopPropagation on input click,
 * containsInteractiveElement.
 *
 * Usage:
 * ```hbs
 * <Bst::Checkbox @checked={{this.isChecked}} @onChange={{this.toggle}}>
 *   Accept terms
 * </Bst::Checkbox>
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    LABEL_PLACEMENT,
    type CheckboxLabelPlacement,
    type CheckboxOverrides,
    type CheckboxSignature,
} from './types';

// Re-export types and constants
export {
    LABEL_PLACEMENT,
    type CheckboxLabelPlacement,
    type CheckboxOverrides,
    type CheckboxSignature
};

/**
 * Simple helper: sets indeterminate property on an input element.
 * Used via {{on "focus"}} and {{on "change"}} to keep it in sync.
 */
function syncIndeterminate(input: HTMLInputElement, isIndeterminate: boolean): void {
  input.indeterminate = isIndeterminate;
}

export default class Checkbox extends Component<CheckboxSignature> {
  @tracked isFocusVisible = false;

  get isChecked(): boolean { return this.args.checked ?? false; }
  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get isError(): boolean { return this.args.error ?? false; }
  get isIndeterminate(): boolean { return this.args.isIndeterminate ?? false; }
  get isRequired(): boolean { return this.args.required ?? false; }
  get labelPlacement(): CheckboxLabelPlacement { return this.args.labelPlacement ?? 'right'; }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.rootDisabled,
      this.labelPlacement === 'left' && styles.rootLabelLeft,
    );
    return className || undefined;
  }

  get checkmarkContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.checkmarkContainer, this.args.overrides, 'checkmarkContainer');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.checkmarkContainerDisabled,
      this.isError && !this.isDisabled && styles.checkmarkContainerError,
    );
    return className || undefined;
  }

  get checkmarkClassName(): string | undefined {
    const resolved = resolveOverride(styles.checkmark, this.args.overrides, 'checkmark');
    const checked = this.isChecked;
    const indeterminate = this.isIndeterminate;
    const disabled = this.isDisabled;
    const error = this.isError;

    let stateStyle = null;
    if (disabled && indeterminate) {
      stateStyle = styles.checkmarkDisabledIndeterminate;
    } else if (disabled && checked) {
      stateStyle = styles.checkmarkDisabledChecked;
    } else if (disabled) {
      stateStyle = styles.checkmarkDisabled;
    } else if (error && indeterminate) {
      stateStyle = styles.checkmarkErrorIndeterminate;
    } else if (error && checked) {
      stateStyle = styles.checkmarkErrorChecked;
    } else if (error) {
      stateStyle = styles.checkmarkError;
    } else if (indeterminate) {
      stateStyle = styles.checkmarkIndeterminate;
    } else if (checked) {
      stateStyle = styles.checkmarkChecked;
    }

    const { className } = stylex.props(
      ...resolved,
      stateStyle,
      this.isFocusVisible && styles.checkmarkFocusVisible,
    );
    return className || undefined;
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(styles.label, this.args.overrides, 'label');
    const { className } = stylex.props(
      ...resolved,
      this.labelPlacement === 'left' && styles.labelLeft,
      this.isDisabled && styles.labelDisabled,
    );
    return className || undefined;
  }

  get inputClassName(): string | undefined {
    const resolved = resolveOverride(styles.input, this.args.overrides, 'input');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  handleChange = (event: Event) => {
    if (this.isDisabled) return;
    // Keep indeterminate in sync after change
    const input = event.target as HTMLInputElement;
    syncIndeterminate(input, this.isIndeterminate);
    this.args.onChange?.(event);
  };

  /** Toggle on Enter key (native checkbox only toggles on Space). */
  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key === 'Enter' && !this.isDisabled) {
      event.preventDefault();
      const input = event.target as HTMLInputElement;
      // Dispatch a synthetic change event
      const changeEvent = new Event('change', { bubbles: true });
      input.checked = !input.checked;
      input.dispatchEvent(changeEvent);
    }
  };

  /** Prevent a second click event from firing when label is clicked. */
  handleInputClick = (event: Event) => {
    event.stopPropagation();
  };

  /** Prevent label click from moving focus to checkbox when children contain interactive elements. */
  handleLabelClick = (event: Event) => {
    if (this.args.containsInteractiveElement) {
      event.preventDefault();
    }
  };

  handleFocusAndIndeterminate = (event: FocusEvent) => {
    const input = event.target as HTMLInputElement;
    // Sync indeterminate DOM property on every focus (covers initial render case)
    syncIndeterminate(input, this.isIndeterminate);

    if (input.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleBlur = () => {
    requestAnimationFrame(() => {
      this.isFocusVisible = false;
    });
  };

  <template>
    {{! template-lint-disable no-autofocus-attribute no-invalid-interactive }}
    <label
      class={{this.rootClassName}}
      ...attributes
      data-basestrom="checkbox"
      {{on "click" this.handleLabelClick}}
    >
      <span class={{this.checkmarkContainerClassName}}>
        <span class={{this.checkmarkClassName}}></span>
      </span>
      <input
        class={{this.inputClassName}}
        type="checkbox"
        id={{@id}}
        checked={{this.isChecked}}
        disabled={{this.isDisabled}}
        required={{this.isRequired}}
        name={{@name}}
        value={{@value}}
        aria-checked={{if this.isIndeterminate "mixed" (if this.isChecked "true" "false")}}
        aria-invalid={{if this.isError "true"}}
        aria-required={{if this.isRequired "true"}}
        aria-describedby={{@aria-describedby}}
        aria-errormessage={{@aria-errormessage}}
        aria-controls={{@aria-controls}}
        aria-label={{@aria-label}}
        autofocus={{@autoFocus}}
        {{on "change" this.handleChange}}
        {{on "click" this.handleInputClick}}
        {{on "keydown" this.handleKeyDown}}
        {{on "focus" this.handleFocusAndIndeterminate}}
        {{on "blur" this.handleBlur}}
      />
      {{#if (has-block)}}
        <span class={{this.labelClassName}}>
          {{#if @containsInteractiveElement}}
            <span {{on "click" this.handleLabelClick}}>{{yield}}</span>
          {{else}}
            {{yield}}
          {{/if}}
        </span>
      {{/if}}
    </label>
  </template>
}
