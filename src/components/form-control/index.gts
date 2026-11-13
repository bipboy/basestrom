/**
 * FormControl component - port from baseweb form-control.
 *
 * Wraps a single input control with a label, optional label end enhancer
 * (such as a character counter), and an optional caption. The caption swaps
 * to error or positive messaging when those args are set.
 *
 * Unlike React, Glimmer can't transparently inject props into a yielded
 * component. Instead of cloning children, FormControl yields its computed
 * state to the consumer who then wires it to the input:
 *
 * ```hbs
 * <Bst::FormControl
 *   @label="Email"
 *   @caption="We'll never share your email."
 *   @error={{this.emailError}}
 *   as |fc|
 * >
 *   <Bst::Input
 *     id={{fc.controlId}}
 *     @value={{this.email}}
 *     @onChange={{this.handleEmailChange}}
 *     @disabled={{fc.disabled}}
 *     @error={{fc.isError}}
 *     @positive={{fc.isPositive}}
 *     aria-describedby={{fc.captionId}}
 *     aria-errormessage={{fc.errorMessageId}}
 *   />
 * </Bst::FormControl>
 * ```
 *
 * `as |fc|` exposes:
 *  - `fc.controlId`: id to put on the input (matches `@htmlFor` if provided)
 *  - `fc.disabled`: forwarded `@disabled`
 *  - `fc.isError`: `true` when `@error` is truthy
 *  - `fc.isPositive`: `true` when `@positive` is truthy and `@error` isn't
 *  - `fc.captionId`: id for `aria-describedby` linking to the caption text
 *  - `fc.errorMessageId`: same id, but `null` unless an error is shown
 *
 * Counter:
 *
 * ```hbs
 * <Bst::FormControl
 *   @label="Bio"
 *   @counter={{hash length=this.bio.length maxLength=140}}
 *   as |fc|
 * >
 *   <Bst::Textarea @value={{this.bio}} @maxLength={{140}} />
 * </Bst::FormControl>
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { generateId } from '../../a11y';
import { resolveOverride } from '../../helpers/overrides';
import { Alert, Check } from '../icon/glyphs.gts';
import { styles } from './styles.stylex';
import {
    type FormControlCounter,
    type FormControlOverrides,
    type FormControlSignature,
    type FormControlYieldedState,
} from './types';

export {
    type FormControlCounter, type FormControlOverrides,
    type FormControlSignature, type FormControlYieldedState
};

export default class FormControl extends Component<FormControlSignature> {
  /** Stable id for the caption (`aria-describedby` / `aria-errormessage`). */
  readonly captionId = generateId('bst-fc-caption');

  /** Fallback id for the input when the consumer doesn't pass `@htmlFor`. */
  readonly generatedControlId = generateId('bst-fc');

  get controlId(): string {
    return this.args.htmlFor ?? this.generatedControlId;
  }

  get isDisabled(): boolean {
    return this.args.disabled ?? false;
  }

  get isError(): boolean {
    return !!this.args.error || this.counterIsError;
  }

  get isPositive(): boolean {
    return !this.isError && !!this.args.positive;
  }

  get errorMessageId(): string | undefined {
    return this.isError ? this.captionId : undefined;
  }

  // ─── Counter derivation ────────────────────────────────────────────────────

  get counterObject(): { length?: number; maxLength?: number; error?: boolean } | null {
    const c = this.args.counter;
    if (!c) return null;
    if (c === true) return {};
    return c;
  }

  get counterIsError(): boolean {
    const c = this.counterObject;
    if (!c) return false;
    if (c.error === true) return true;
    if (c.error === undefined && typeof c.length === 'number' && typeof c.maxLength === 'number') {
      return c.length > c.maxLength;
    }
    return false;
  }

  get effectiveLabelEndEnhancer(): string | undefined {
    if (this.args.labelEndEnhancer != null) return this.args.labelEndEnhancer;
    const c = this.counterObject;
    if (!c || typeof c.length !== 'number') return undefined;
    return typeof c.maxLength === 'number' ? `${c.length}/${c.maxLength}` : `${c.length}`;
  }

  // ─── Caption text resolution ───────────────────────────────────────────────

  get captionText(): string | null {
    if (typeof this.args.error === 'string') return this.args.error;
    if (typeof this.args.positive === 'string' && !this.args.error) {
      return this.args.positive;
    }
    if (this.args.caption) return this.args.caption;
    return null;
  }

  /**
   * The default ! / ✓ caption icon. Suppressed when a custom :captionIcon
   * block is provided (template-side check).
   */
  get showDefaultCaptionIcon(): boolean {
    return this.captionText != null && (this.isError || this.isPositive);
  }

  // ─── Yielded state ─────────────────────────────────────────────────────────

  get yieldedState(): FormControlYieldedState {
    return {
      controlId: this.controlId,
      disabled: this.isDisabled,
      isError: this.isError,
      isPositive: this.isPositive,
      captionId: this.captionId,
      errorMessageId: this.errorMessageId,
    };
  }

  /**
   * Whether to render the label row at all. True if either `@label` is set
   * or the consumer supplied a `:label` block. The latter check happens in
   * the template via `(has-block 'label')`.
   */
  get hasLabelArg(): boolean {
    return !!this.args.label;
  }

  // ─── Class names ───────────────────────────────────────────────────────────

  get labelContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.labelContainer, this.args.overrides, 'labelContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(styles.label, this.args.overrides, 'label');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.labelDisabled,
    );
    return className || undefined;
  }

  get labelEndEnhancerClassName(): string | undefined {
    const resolved = resolveOverride(styles.labelEndEnhancer, this.args.overrides, 'labelEndEnhancer');
    const { className } = stylex.props(
      ...resolved,
      this.isDisabled && styles.labelEndEnhancerDisabled,
      this.counterIsError && styles.labelEndEnhancerError,
    );
    return className || undefined;
  }

  get controlContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.controlContainer, this.args.overrides, 'controlContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get captionClassName(): string | undefined {
    const resolved = resolveOverride(styles.caption, this.args.overrides, 'caption');
    const { className } = stylex.props(
      ...resolved,
      this.isError && styles.captionError,
      this.isPositive && styles.captionPositive,
    );
    return className || undefined;
  }

  get captionIconClassName(): string | undefined {
    const resolved = resolveOverride(styles.captionIcon, this.args.overrides, 'captionIcon');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get captionMessageClassName(): string | undefined {
    const resolved = resolveOverride(styles.captionMessage, this.args.overrides, 'captionMessage');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  <template>
    <div ...attributes data-basestrom="form-control">
      {{#if this.hasLabelArg}}
        <div class={{this.labelContainerClassName}}>
          <label
            class={{this.labelClassName}}
            for={{this.controlId}}
            data-basestrom="form-control-label"
          >
            {{@label}}
          </label>
          {{#if this.effectiveLabelEndEnhancer}}
            <span class={{this.labelEndEnhancerClassName}}>
              {{this.effectiveLabelEndEnhancer}}
            </span>
          {{/if}}
        </div>
      {{else if (has-block "label")}}
        <div class={{this.labelContainerClassName}}>
          <span class={{this.labelClassName}} data-basestrom="form-control-label">
            {{yield to="label"}}
          </span>
          {{#if this.effectiveLabelEndEnhancer}}
            <span class={{this.labelEndEnhancerClassName}}>
              {{this.effectiveLabelEndEnhancer}}
            </span>
          {{/if}}
        </div>
      {{/if}}

      <div class={{this.controlContainerClassName}} data-basestrom="form-control-container">
        {{yield this.yieldedState}}

        {{#if this.captionText}}
          <div
            class={{this.captionClassName}}
            id={{this.captionId}}
            data-basestrom="form-control-caption"
            role={{if this.isError "alert"}}
          >
            {{#if (has-block "captionIcon")}}
              <span class={{this.captionIconClassName}}>
                {{yield to="captionIcon"}}
              </span>
            {{else if this.showDefaultCaptionIcon}}
              <span class={{this.captionIconClassName}}>
                {{#if this.isError}}
                  <Alert @size="12px" @title="" />
                {{else}}
                  <Check @size="12px" @title="" />
                {{/if}}
              </span>
            {{/if}}
            <span class={{this.captionMessageClassName}}>
              {{this.captionText}}
            </span>
          </div>
        {{else if (has-block "caption")}}
          <div
            class={{this.captionClassName}}
            id={{this.captionId}}
            data-basestrom="form-control-caption"
            role={{if this.isError "alert"}}
          >
            {{#if (has-block "captionIcon")}}
              <span class={{this.captionIconClassName}}>
                {{yield to="captionIcon"}}
              </span>
            {{/if}}
            <span class={{this.captionMessageClassName}}>
              {{yield to="caption"}}
            </span>
          </div>
        {{/if}}
      </div>
    </div>
  </template>
}
