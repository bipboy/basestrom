/**
 * Input component - complete port from baseweb input.
 *
 * Supports: 4 sizes (mini, compact/small, default, large), states (focus, error,
 * positive, disabled), clearable, password mask toggle, start/end enhancers,
 * adjoined border-radius control, full a11y attributes.
 *
 * Usage:
 * ```hbs
 * <Bst::Input @value={{this.name}} @onChange={{this.handleChange}} @placeholder="Enter name" />
 *
 * <Bst::Input @value={{this.search}} @onChange={{this.handleChange}} @clearable={{true}}>
 *   <:startEnhancer>🔍</:startEnhancer>
 * </Bst::Input>
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { DeleteAlt, Hide, Show } from '../icon/glyphs.gts';
import { styles } from './styles.stylex';
import {
  ADJOINED,
  SIZE,
  type InputAdjoined,
  type InputOverrides,
  type InputSignature,
  type InputSize,
} from './types';

// Re-export types and constants
export {
  ADJOINED, SIZE, type InputAdjoined,
  type InputOverrides,
  type InputSignature, type InputSize
};
// ─── Component ──────────────────────────────────────────────────────────────────

export default class Input extends Component<InputSignature> {
  @tracked isFocused = false;
  @tracked isFocusVisibleForClear = false;
  @tracked isFocusVisibleForMaskToggle = false;
  @tracked isMasked = true;

  private inputElement: HTMLInputElement | null = null;

  // ─── Computed properties ────────────────────────────────────────────────────

  get size(): InputSize { return this.args.size ?? 'default'; }
  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get isReadOnly(): boolean { return this.args.readOnly ?? false; }
  get isError(): boolean { return this.args.error ?? false; }
  get isPositive(): boolean { return this.args.positive ?? false; }
  get isClearable(): boolean { return this.args.clearable ?? false; }
  get clearOnEscape(): boolean { return this.args.clearOnEscape ?? true; }
  get adjoined(): InputAdjoined { return this.args.adjoined ?? 'none'; }
  get inputType(): string { return this.args.type ?? 'text'; }
  get isRequired(): boolean { return this.args.required ?? false; }
  get isPassword(): boolean { return this.inputType === 'password'; }
  get hasIconTrailing(): boolean { return this.isClearable || this.isPassword; }

  get resolvedInputType(): string {
    if (this.isPassword) {
      return this.isMasked ? 'password' : 'text';
    }
    return this.inputType;
  }

  get showClearButton(): boolean {
    if (this.isDisabled || this.isReadOnly || !this.isClearable) return false;
    const val = this.args.value;
    return val != null && String(val).length > 0;
  }

  get maskToggleLabel(): string {
    return this.isMasked ? 'Show password text' : 'Hide password text';
  }

  get maskToggleIconSize(): string {
    switch (this.size) {
      case 'mini': return '12px';
      case 'compact': return '16px';
      case 'large': return '24px';
      default: return '20px';
    }
  }

  get clearIconSize(): string {
    switch (this.size) {
      case 'large': return '22px';
      case 'mini':
      case 'compact':
        return '14px';
      default: return '16px';
    }
  }

  // ─── Style computations ───────────────────────────────────────────────────

  get fontStyle() {
    switch (this.size) {
      case 'mini': return styles.fontMini;
      case 'compact': return styles.fontCompact;
      case 'large': return styles.fontLarge;
      default: return styles.fontDefault;
    }
  }

  get rootStateStyle() {
    if (this.isDisabled) return styles.rootDisabled;
    if (this.isFocused) return styles.rootFocused;
    if (this.isError) return styles.rootError;
    if (this.isPositive) return styles.rootPositive;
    return styles.rootDefault;
  }

  get inputPaddingStyle() {
    switch (this.size) {
      case 'mini': return styles.inputPaddingMini;
      case 'compact': return styles.inputPaddingCompact;
      case 'large': return styles.inputPaddingLarge;
      default: return styles.inputPaddingDefault;
    }
  }

  get enhancerPaddingStyle() {
    switch (this.size) {
      case 'mini': return styles.enhancerPaddingMini;
      case 'compact': return styles.enhancerPaddingCompact;
      case 'large': return styles.enhancerPaddingLarge;
      default: return styles.enhancerPaddingDefault;
    }
  }

  get enhancerStateStyle() {
    if (this.isDisabled) return styles.enhancerDisabled;
    if (this.isFocused) return styles.enhancerFocused;
    if (this.isError) return styles.enhancerError;
    if (this.isPositive) return styles.enhancerPositive;
    return styles.startEnhancerDefault;
  }

  get inputContainerStateStyle() {
    if (this.isDisabled) return styles.inputContainerDisabled;
    if (this.isFocused) return styles.inputContainerFocused;
    if (this.isError) return styles.inputContainerError;
    if (this.isPositive) return styles.inputContainerPositive;
    return styles.inputContainerDefault;
  }

  get clearIconContainerPaddingStyle() {
    switch (this.size) {
      case 'mini': return styles.clearIconContainerPaddingMini;
      case 'compact': return styles.clearIconContainerPaddingCompact;
      case 'large': return styles.clearIconContainerPaddingLarge;
      default: return styles.clearIconContainerPaddingDefault;
    }
  }

  get maskTogglePaddingStyle() {
    switch (this.size) {
      case 'mini': return styles.maskTogglePaddingMini;
      case 'compact': return styles.maskTogglePaddingCompact;
      case 'large': return styles.maskTogglePaddingLarge;
      default: return styles.maskTogglePaddingDefault;
    }
  }

  // ─── Class name getters ───────────────────────────────────────────────────

  get adjoinedStyle() {
    switch (this.adjoined) {
      case 'left': return styles.adjoinedLeft;
      case 'right': return styles.adjoinedRight;
      case 'both': return styles.adjoinedBoth;
      default: return null;
    }
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');

    // Determine adjoined padding based on the adjoined prop and trailing icons
    const adjoinedVal = this.adjoined;
    const needsLeftPad =
      adjoinedVal === 'both' ||
      adjoinedVal === 'left';
    const needsRightPad =
      adjoinedVal === 'both' ||
      adjoinedVal === 'right' ||
      this.hasIconTrailing;

    const { className } = stylex.props(
      ...resolved,
      this.fontStyle,
      this.rootStateStyle,
      this.size === 'mini' && styles.rootMini,
      this.adjoinedStyle,
      needsLeftPad && styles.rootPaddingLeft,
      needsRightPad && styles.rootPaddingRight,
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

  get inputClassName(): string | undefined {
    const resolved = resolveOverride(styles.input, this.args.overrides, 'input');
    const { className } = stylex.props(
      ...resolved,
      this.inputPaddingStyle,
      this.isDisabled && styles.inputDisabled,
    );
    return className || undefined;
  }

  get startEnhancerClassName(): string | undefined {
    const resolved = resolveOverride(styles.startEnhancer, this.args.overrides, 'startEnhancer');
    const { className } = stylex.props(
      ...resolved,
      this.fontStyle,
      this.enhancerPaddingStyle,
      this.enhancerStateStyle,
    );
    return className || undefined;
  }

  get endEnhancerClassName(): string | undefined {
    const resolved = resolveOverride(styles.endEnhancer, this.args.overrides, 'endEnhancer');
    const stateStyle = (() => {
      if (this.isDisabled) return styles.enhancerDisabled;
      if (this.isFocused) return styles.enhancerFocused;
      if (this.isError) return styles.enhancerError;
      if (this.isPositive) return styles.enhancerPositive;
      return styles.endEnhancerDefault;
    })();
    const { className } = stylex.props(
      ...resolved,
      this.fontStyle,
      this.enhancerPaddingStyle,
      stateStyle,
    );
    return className || undefined;
  }

  get clearIconContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.clearIconContainer, this.args.overrides, 'clearIconContainer');
    const { className } = stylex.props(
      ...resolved,
      this.clearIconContainerPaddingStyle,
    );
    return className || undefined;
  }

  get clearIconClassName(): string | undefined {
    const resolved = resolveOverride(styles.clearIcon, this.args.overrides, 'clearIcon');
    const { className } = stylex.props(
      ...resolved,
      this.isFocusVisibleForClear && styles.clearIconFocusVisible,
    );
    return className || undefined;
  }

  get maskToggleClassName(): string | undefined {
    const { className } = stylex.props(
      styles.maskToggleButton,
      this.maskTogglePaddingStyle,
      this.isFocusVisibleForMaskToggle && styles.maskToggleFocusVisible,
    );
    return className || undefined;
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleRootFocusIn = (event: FocusEvent) => {
    if (!this.isFocused) {
      this.isFocused = true;
    }
    // Only call user onFocus when the actual input element gets focus
    const target = event.target as HTMLElement;
    if (target === this.inputElement) {
      this.args.onFocus?.(event);
    }
  };

  handleRootFocusOut = (event: FocusEvent) => {
    const root = (event.currentTarget as HTMLElement);
    const relatedTarget = event.relatedTarget as Node | null;
    // Only defocus if focus moves OUTSIDE the root container
    if (!relatedTarget || !root.contains(relatedTarget)) {
      this.isFocused = false;
      // Only call user onBlur when focus leaves the entire input
      this.args.onBlur?.(event);
    }
  };

  handleInput = (event: Event) => {
    this.args.onChange?.(event);
  };

  handleKeyDown = (event: KeyboardEvent) => {
    // Clear on Escape
    if (
      this.clearOnEscape &&
      event.key === 'Escape' &&
      this.isClearable &&
      !this.isReadOnly
    ) {
      this.clearValue();
      event.stopPropagation();
    }
    this.args.onKeyDown?.(event);
  };

  handleKeyUp = (event: KeyboardEvent) => {
    this.args.onKeyUp?.(event);
  };

  handleKeyPress = (event: KeyboardEvent) => {
    this.args.onKeyPress?.(event);
  };

  // ─── Clear logic ──────────────────────────────────────────────────────────

  clearValue = () => {
    const input = this.inputElement;
    if (!input) return;

    const nativeInputValueSetter = Object.getOwnPropertyDescriptor(
      HTMLInputElement.prototype,
      'value',
    )?.set;

    if (nativeInputValueSetter) {
      nativeInputValueSetter.call(input, '');
      const inputEvent = new Event('input', { bubbles: true });
      input.dispatchEvent(inputEvent);
    }
  };

  handleClearClick = () => {
    this.clearValue();
    this.inputElement?.focus();
  };

  handleClearFocus = (event: FocusEvent) => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisibleForClear = true;
    }
  };

  handleClearBlur = () => {
    this.isFocusVisibleForClear = false;
  };

  // ─── Mask toggle logic ────────────────────────────────────────────────────

  handleMaskToggle = () => {
    this.isMasked = !this.isMasked;
  };

  handleMaskToggleFocus = (event: FocusEvent) => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisibleForMaskToggle = true;
    }
  };

  handleMaskToggleBlur = () => {
    this.isFocusVisibleForMaskToggle = false;
  };

  // ─── Auto-focus modifier ──────────────────────────────────────────────────

  setupInput = (event: Event) => {
    const input = event.target as HTMLInputElement;
    this.inputElement = input;
  };

  <template>
    {{! template-lint-disable no-autofocus-attribute require-input-label }}
    {{! Root wrapper }}
    <div
      class={{this.rootClassName}}
      data-basestrom="input"
      {{on "focusin" this.handleRootFocusIn}}
      {{on "focusout" this.handleRootFocusOut}}
      ...attributes
    >
      {{! Start Enhancer }}
      {{#if (has-block "startEnhancer")}}
        <div class={{this.startEnhancerClassName}}>
          {{yield to="startEnhancer"}}
        </div>
      {{/if}}

      {{! Input Container }}
      <div class={{this.inputContainerClassName}}>
        <input
          class={{this.inputClassName}}
          type={{this.resolvedInputType}}
          value={{@value}}
          placeholder={{@placeholder}}
          disabled={{this.isDisabled}}
          readonly={{this.isReadOnly}}
          required={{@required}}
          id={{@id}}
          name={{@name}}
          inputmode={{@inputMode}}
          maxlength={{@maxLength}}
          pattern={{@pattern}}
          min={{@min}}
          max={{@max}}
          step={{@step}}
          role={{@role}}
          autocomplete={{@autoComplete}}
          autofocus={{@autoFocus}}
          aria-label={{@aria-label}}
          aria-describedby={{@aria-describedby}}
          aria-errormessage={{@aria-errormessage}}
          aria-labelledby={{@aria-labelledby}}
          aria-activedescendant={{@aria-activedescendant}}
          aria-autocomplete={{@aria-autocomplete}}
          aria-controls={{@aria-controls}}
          aria-haspopup={{@aria-haspopup}}
          aria-invalid={{if this.isError "true"}}
          aria-required={{if this.isRequired "true"}}
          {{on "input" this.handleInput}}
          {{on "keydown" this.handleKeyDown}}
          {{on "keyup" this.handleKeyUp}}
          {{on "keypress" this.handleKeyPress}}
          {{on "focus" this.setupInput}}
        />

        {{! Clear button }}
        {{#if this.showClearButton}}
          <div class={{this.clearIconContainerClassName}}>
            <button
              class={{this.clearIconClassName}}
              type="button"
              aria-label="Clear value"
              title="Clear value"
              {{on "click" this.handleClearClick}}
              {{on "focus" this.handleClearFocus}}
              {{on "blur" this.handleClearBlur}}
            >
              {{! Clear icon - DeleteAlt glyph from baseweb. }}
              <DeleteAlt @size={{this.clearIconSize}} @title="" />
            </button>
          </div>
        {{/if}}

        {{! Password mask toggle }}
        {{#if this.isPassword}}
          <button
            class={{this.maskToggleClassName}}
            type="button"
            aria-label={{this.maskToggleLabel}}
            title={{this.maskToggleLabel}}
            {{on "click" this.handleMaskToggle}}
            {{on "focus" this.handleMaskToggleFocus}}
            {{on "blur" this.handleMaskToggleBlur}}
          >
            {{#if this.isMasked}}
              <Show @size={{this.maskToggleIconSize}} @title="" />
            {{else}}
              <Hide @size={{this.maskToggleIconSize}} @title="" />
            {{/if}}
          </button>
        {{/if}}
      </div>

      {{! End Enhancer }}
      {{#if (has-block "endEnhancer")}}
        <div class={{this.endEnhancerClassName}}>
          {{yield to="endEnhancer"}}
        </div>
      {{/if}}
    </div>
  </template>
}
