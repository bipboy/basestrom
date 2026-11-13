/**
 * Switch component - port from baseweb switch.
 *
 * A toggle control with two sizes, optional checkmark icon when on,
 * and label placement on either side.
 *
 * Usage:
 * ```hbs
 * <Bst::Switch @checked={{this.isOn}} @onChange={{this.toggle}}>
 *   Notifications
 * </Bst::Switch>
 *
 * <Bst::Switch
 *   @checked={{this.isOn}}
 *   @onChange={{this.toggle}}
 *   @size="small"
 *   @showIcon={{true}}
 *   @labelPlacement="left"
 * >
 *   Compact
 * </Bst::Switch>
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { colors } from '../../themes/vars.stylex';
import {
  inputStyles,
  labelStyles,
  rootStyles,
  toggleStyles,
  trackStyles,
} from './styles.stylex';
import {
  LABEL_PLACEMENT,
  SIZE,
  type SwitchLabelPlacement,
  type SwitchOverrides,
  type SwitchSignature,
  type SwitchSize,
} from './types';

// Re-export types and constants
export {
  LABEL_PLACEMENT, SIZE, type SwitchLabelPlacement,
  type SwitchOverrides,
  type SwitchSignature, type SwitchSize
};

// --- Helpers ----------------------------------------------------------------

/**
 * Generates the SVG data-URI for the checkmark icon shown when the switch
 * is on and `@showIcon` is true. The fill uses the StyleX color custom
 * property so it adapts to the current theme.
 */
function checkmarkUrl(size: SwitchSize): string {
  const iconSize = size === SIZE.small ? 12 : 16;
  // colors.contentPrimary is a stylex var (string like 'var(--xxx)').
  // We embed it directly in the SVG fill so theme changes propagate.
  const fill = String(colors.contentPrimary);
  const svg = `<svg width='${iconSize}' height='${iconSize}' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'><path d='m8.5 19.84-6.56-6.56 2.12-2.12L8.5 15.6 19.94 4.16l2.12 2.12L8.5 19.84Z' fill='${fill}'/></svg>`;
  return `url("data:image/svg+xml;utf8,${encodeURIComponent(svg)}")`;
}

// --- Component --------------------------------------------------------------

export default class Switch extends Component<SwitchSignature> {
  @tracked isFocusVisible = false;
  @tracked isHovered = false;

  // -- Resolved props --------------------------------------------------------

  get isChecked(): boolean { return this.args.checked ?? false; }
  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get isRequired(): boolean { return this.args.required ?? false; }
  get size(): SwitchSize { return this.args.size ?? 'default'; }
  get labelPlacement(): SwitchLabelPlacement { return this.args.labelPlacement ?? 'right'; }
  get showIcon(): boolean { return this.args.showIcon ?? false; }

  get isLabelLeft(): boolean { return this.labelPlacement === 'left'; }
  get isLabelRight(): boolean { return this.labelPlacement === 'right'; }

  // -- Styles ----------------------------------------------------------------

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(rootStyles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && rootStyles.rootDisabled,
      this.labelPlacement === 'left' && rootStyles.rootLabelLeft,
    );
    return className || undefined;
  }

  get trackClassName(): string | undefined {
    const resolved = resolveOverride(trackStyles.base, this.args.overrides, 'toggleTrack');
    const isHoverActive = this.isHovered && !this.isDisabled;
    const { className } = stylex.props(
      ...resolved,
      this.size === 'small' ? trackStyles.sizeSmall : trackStyles.sizeDefault,
      this.isChecked && !this.isDisabled && trackStyles.checked,
      isHoverActive && this.isChecked && trackStyles.hoverChecked,
      isHoverActive && !this.isChecked && trackStyles.hoverUnchecked,
      this.isDisabled && trackStyles.disabled,
      this.isFocusVisible && !this.isDisabled && trackStyles.focusVisible,
    );
    return className || undefined;
  }

  get toggleClassName(): string | undefined {
    const resolved = resolveOverride(toggleStyles.base, this.args.overrides, 'toggle');
    let sizeStyle;
    if (this.size === 'small') {
      sizeStyle = this.isChecked ? toggleStyles.smallOn : toggleStyles.smallOff;
    } else {
      sizeStyle = this.isChecked ? toggleStyles.defaultOn : toggleStyles.defaultOff;
    }
    const isHoverActive = this.isHovered && !this.isDisabled;
    const { className } = stylex.props(
      ...resolved,
      sizeStyle,
      isHoverActive && this.isChecked && toggleStyles.hoverChecked,
      isHoverActive && !this.isChecked && toggleStyles.hoverUnchecked,
      this.isDisabled && toggleStyles.disabled,
    );
    return className || undefined;
  }

  /**
   * Inline style is used solely to set the checkmark background-image when
   * `@showIcon` is enabled and the switch is on. We can't express this
   * easily in StyleX since the SVG fill needs the live theme color value.
   */
  get toggleStyle(): string | undefined {
    if (!this.showIcon || !this.isChecked) return undefined;
    return htmlSafe(`background-image:${checkmarkUrl(this.size)}`).toString();
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(labelStyles.base, this.args.overrides, 'label');
    const { className } = stylex.props(
      ...resolved,
      this.size === 'small' ? labelStyles.sizeSmall : labelStyles.sizeDefault,
      this.labelPlacement === 'left' ? labelStyles.placementLeft : labelStyles.placementRight,
      this.isDisabled && labelStyles.disabled,
    );
    return className || undefined;
  }

  get inputClassName(): string | undefined {
    const resolved = resolveOverride(inputStyles.base, this.args.overrides, 'input');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // -- Event handlers --------------------------------------------------------

  handleChange = (event: Event) => {
    if (this.isDisabled) return;
    this.args.onChange?.(event);
  };

  /** Prevent a second click event from firing when label is clicked. */
  handleInputClick = (event: Event) => {
    event.stopPropagation();
  };

  /** Prevent label click from moving focus when children are interactive. */
  handleLabelClick = (event: Event) => {
    if (this.args.containsInteractiveElement) {
      event.preventDefault();
    }
  };

  /**
   * Toggle on Enter (Space already toggles natively for checkbox-role inputs).
   */
  handleKeyDown = (event: KeyboardEvent) => {
    if (event.key !== 'Enter' || this.isDisabled) return;
    event.preventDefault();
    const input = event.target as HTMLInputElement;
    input.checked = !input.checked;
    input.dispatchEvent(new Event('change', { bubbles: true }));
  };

  handleFocus = (event: FocusEvent) => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleBlur = () => {
    requestAnimationFrame(() => {
      this.isFocusVisible = false;
    });
  };

  handleMouseEnter = () => {
    this.isHovered = true;
  };

  handleMouseLeave = () => {
    this.isHovered = false;
  };

  <template>
    {{! template-lint-disable no-invalid-interactive no-autofocus-attribute }}
    <label
      class={{this.rootClassName}}
      title={{@title}}
      ...attributes
      data-basestrom="switch"
      {{on "click" this.handleLabelClick}}
      {{on "mouseenter" this.handleMouseEnter}}
      {{on "mouseleave" this.handleMouseLeave}}
    >
      {{#if this.isLabelLeft}}
        {{#if (has-block)}}
          <span class={{this.labelClassName}}>
            {{#if @containsInteractiveElement}}
              <span {{on "click" this.handleLabelClick}}>{{yield}}</span>
            {{else}}
              {{yield}}
            {{/if}}
          </span>
        {{/if}}
      {{/if}}

      <span class={{this.trackClassName}}>
        <span class={{this.toggleClassName}} style={{this.toggleStyle}}></span>
      </span>

      <input
        class={{this.inputClassName}}
        type="checkbox"
        role="switch"
        id={{@id}}
        name={{@name}}
        value={{@value}}
        checked={{this.isChecked}}
        disabled={{this.isDisabled}}
        required={{this.isRequired}}
        autofocus={{if @autoFocus true}}
        aria-checked={{if this.isChecked "true" "false"}}
        aria-label={{@aria-label}}
        aria-describedby={{@aria-describedby}}
        aria-errormessage={{@aria-errormessage}}
        aria-invalid={{if @aria-invalid "true"}}
        aria-required={{if this.isRequired "true"}}
        {{on "change" this.handleChange}}
        {{on "click" this.handleInputClick}}
        {{on "keydown" this.handleKeyDown}}
        {{on "focus" this.handleFocus}}
        {{on "blur" this.handleBlur}}
      />

      {{#if this.isLabelRight}}
        {{#if (has-block)}}
          <span class={{this.labelClassName}}>
            {{#if @containsInteractiveElement}}
              <span {{on "click" this.handleLabelClick}}>{{yield}}</span>
            {{else}}
              {{yield}}
            {{/if}}
          </span>
        {{/if}}
      {{/if}}
    </label>
  </template>
}
