/**
 * Radio + RadioGroup - complete port from baseweb radio-v2.
 *
 * RadioGroup yields a context object that Radio components consume.
 * This enables: name propagation, selected value tracking, roving tabindex,
 * coordinated focus-visible state, and auto-registration.
 *
 * Usage:
 * ```hbs
 * <Bst::RadioGroup @value={{this.selected}} @onChange={{this.handle}} @name="plan" as |group|>
 *   <Bst::Radio @group={{group}} @value="a">Option A</Bst::Radio>
 *   <Bst::Radio @group={{group}} @value="b" @description="More details">Option B</Bst::Radio>
 *   <Bst::Radio @group={{group}} @value="c" @disabled={{true}}>Option C</Bst::Radio>
 * </Bst::RadioGroup>
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { groupStyles, radioStyles } from './styles.stylex';
import {
    ALIGN,
    LABEL_PLACEMENT,
    type RadioAlign,
    type RadioGroupContext,
    type RadioGroupOverrides,
    type RadioGroupSignature,
    type RadioLabelPlacement,
    type RadioOverrides,
    type RadioSignature,
} from './types';

// Re-export types and constants
export {
    ALIGN,
    LABEL_PLACEMENT,
    type RadioAlign, type RadioGroupContext,
    type RadioGroupOverrides,
    type RadioGroupSignature, type RadioLabelPlacement, type RadioOverrides,
    type RadioSignature
};

// --- RadioGroup ---

export class RadioGroup extends Component<RadioGroupSignature> {
  @tracked focusedIndex = -1;
  @tracked isFocusVisible = false;

  private radioCount = 0;

  get className(): string | undefined {
    const resolved = resolveOverride(groupStyles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.args.align === 'horizontal' && groupStyles.horizontal,
    );
    return className || undefined;
  }

  registerRadio = (): number => {
    return this.radioCount++;
  };

  onRadioFocus = (index: number, event: FocusEvent): void => {
    this.focusedIndex = index;
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  onRadioBlur = (_index: number): void => {
    this.focusedIndex = -1;
    this.isFocusVisible = false;
  };

  get context(): RadioGroupContext {
    return {
      name: this.args.name,
      selectedValue: this.args.value,
      disabled: this.args.disabled,
      error: this.args.error,
      required: this.args.required,
      autoFocus: this.args.autoFocus,
      labelPlacement: this.args.labelPlacement,
      isFocusVisible: this.isFocusVisible,
      focusedIndex: this.focusedIndex,
      registerRadio: this.registerRadio,
      onChange: this.args.onChange,
      onRadioFocus: this.onRadioFocus,
      onRadioBlur: this.onRadioBlur,
    };
  }

  <template>
    <div
      class={{this.className}}
      role="radiogroup"
      aria-invalid={{if @error "true"}}
      aria-required={{if @required "true"}}
      aria-describedby={{@aria-describedby}}
      aria-errormessage={{@aria-errormessage}}
      aria-label={{@aria-label}}
      aria-labelledby={{@aria-labelledby}}
      ...attributes
      data-basestrom="radio-group"
    >
      {{yield this.context}}
    </div>
  </template>
}

// --- Radio ---

export class Radio extends Component<RadioSignature> {
	@tracked private _isFocusVisible = false;
	private _radioIndex: number | null = null;
	private _didAutoFocus = false;

	get radioIndex(): number {
		if (this._radioIndex === null) {
			this._radioIndex = this.args.group?.registerRadio?.() ?? -1;
		}
		return this._radioIndex;
	}

  /** Whether this radio should auto-focus (from own prop or group context). */
  get shouldAutoFocus(): boolean {
    const autoFocus = this.args.autoFocus ?? this.args.group?.autoFocus ?? false;
    if (!autoFocus) return false;
    // Only auto-focus the checked radio, or the first one if none is selected
    if (this.isChecked) return true;
    if (this.args.group && !this.args.group.selectedValue && this.radioIndex === 0) return true;
    return false;
  }

  // --- Resolved props (group context takes precedence) ---

  get isChecked(): boolean {
    if (this.args.group) {
      return this.args.group.selectedValue === this.args.value;
    }
    return this.args.checked ?? false;
  }

  get isDisabled(): boolean {
    return this.args.disabled || this.args.group?.disabled || false;
  }

  get isError(): boolean {
    return this.args.error || this.args.group?.error || false;
  }

  get isRequired(): boolean {
    return this.args.required || this.args.group?.required || false;
  }

  get name(): string | undefined {
    return this.args.group?.name ?? this.args.name;
  }

  get labelPlacement(): RadioLabelPlacement {
    return this.args.group?.labelPlacement ?? this.args.labelPlacement ?? 'right';
  }

  get isFocusVisible(): boolean {
    if (this.args.group) {
      return this.args.group.isFocusVisible && this.args.group.focusedIndex === this.radioIndex;
    }
    return this._isFocusVisible;
  }

  get tabIndex(): string {
    if (this.args.group) {
      // Roving tabindex: only checked (or first if none selected) is tabbable
      if (this.isChecked) return '0';
      if (this.radioIndex === 0 && !this.args.group.selectedValue) return '0';
      return '-1';
    }
    return '0';
  }

  // --- Styles ---

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && radioStyles.rootDisabled,
      this.labelPlacement === 'left' && radioStyles.rootLabelLeft,
    );
    return className || undefined;
  }

  get backplateClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.backplate, this.args.overrides, 'backplate');
    const { className } = stylex.props(
      ...resolved,
      this.isError && !this.isDisabled && radioStyles.backplateError,
      this.isDisabled && radioStyles.backplateDisabled,
    );
    return className || undefined;
  }

  get markOuterClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.markOuter, this.args.overrides, 'markOuter');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && radioStyles.markOuterDisabled,
      this.isError && !this.isDisabled && radioStyles.markOuterError,
      this.isFocusVisible && this.isChecked && radioStyles.markOuterFocusVisible,
    );
    return className || undefined;
  }

  get markInnerClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.markInner, this.args.overrides, 'markInner');
    const { className } = stylex.props(
      ...resolved,
      this.isChecked && radioStyles.markInnerChecked,
      this.isDisabled && radioStyles.markInnerDisabled,
    );
    return className || undefined;
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.label, this.args.overrides, 'label');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && radioStyles.labelDisabled,
    );
    return className || undefined;
  }

  get labelWrapperClassName(): string | undefined {
    const { className } = stylex.props(radioStyles.labelWrapper);
    return className || undefined;
  }

  get descriptionClassName(): string | undefined {
    const { className } = stylex.props(radioStyles.description);
    return className || undefined;
  }

  get inputClassName(): string | undefined {
    const resolved = resolveOverride(radioStyles.input, this.args.overrides, 'input');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // --- Event handlers ---

  handleChange = (event: Event) => {
    if (this.isDisabled) return;
    if (this.args.group?.onChange) {
      this.args.group.onChange(event);
    } else {
      this.args.onChange?.(event);
    }
  };

  /** Prevent a second click event from firing when label is clicked. */
  handleInputClick = (event: Event) => {
    event.stopPropagation();
  };

  /** Prevent label click from moving focus to radio when children contain interactive elements. */
  handleLabelClick = (event: Event) => {
    if (this.args.containsInteractiveElement) {
      event.preventDefault();
    }
  };

  handleFocus = (event: FocusEvent) => {
    if (this.args.group) {
      this.args.group.onRadioFocus(this.radioIndex, event);
    } else if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this._isFocusVisible = true;
    }
  };

  handleBlur = () => {
    requestAnimationFrame(() => {
      if (this.args.group) {
        this.args.group.onRadioBlur(this.radioIndex);
      } else {
        this._isFocusVisible = false;
      }
    });
  };

  <template>
    {{! template-lint-disable no-positive-tabindex no-invalid-interactive no-autofocus-attribute no-unsupported-role-attributes }}
    <label
      class={{this.rootClassName}}
      ...attributes
      data-basestrom="radio"
      {{on "click" this.handleLabelClick}}
    >
      <span class={{this.backplateClassName}}>
        <span class={{this.markOuterClassName}}>
          <span class={{this.markInnerClassName}}></span>
        </span>
      </span>
      <input
        class={{this.inputClassName}}
        type="radio"
        checked={{this.isChecked}}
        disabled={{this.isDisabled}}
        required={{this.isRequired}}
        name={{this.name}}
        value={{@value}}
        tabindex={{this.tabIndex}}
        aria-invalid={{if this.isError "true"}}
        aria-describedby={{@aria-describedby}}
        aria-errormessage={{@aria-errormessage}}
        autofocus={{this.shouldAutoFocus}}
        {{on "change" this.handleChange}}
        {{on "click" this.handleInputClick}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
      />
      {{#if (has-block)}}
        <span class={{this.labelWrapperClassName}}>
          <span class={{this.labelClassName}}>
            {{#if @containsInteractiveElement}}
              <span {{on "click" this.handleLabelClick}}>{{yield}}</span>
            {{else}}
              {{yield}}
            {{/if}}
          </span>
          {{#if @description}}
            <span class={{this.descriptionClassName}}>{{@description}}</span>
          {{/if}}
        </span>
      {{/if}}
    </label>
  </template>
}
