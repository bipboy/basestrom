/**
 * SelectField component - SelectBase wrapped in FormControl.
 *
 * Mirrors HDS Form::Select::Field: combines the bare select with label,
 * caption, error messaging, and accessibility wiring via FormControl.
 *
 * Usage:
 * ```gts
 * <SelectField @label="Region" @caption="Deploy target" @error={{this.error}} as |S|>
 *   <option value="">Choose region...</option>
 *   <option value="us-east-1">US East</option>
 *   <option value="eu-west-1">EU West</option>
 * </SelectField>
 * ```
 */
import type { TOC } from '@ember/component/template-only';
import FormControl from '../form-control/index.gts';
import SelectBase from './base.gts';
import type { SelectFieldSignature } from './types';

export { type SelectFieldSignature };

const SelectField: TOC<SelectFieldSignature> = <template>
  <FormControl
    @label={{@label}}
    @caption={{@caption}}
    @error={{@error}}
    @positive={{@positive}}
    @disabled={{@disabled}}
    @counter={{@counter}}
    @labelEndEnhancer={{@labelEndEnhancer}}
    as |fc|
  >
    <SelectBase
      @isInvalid={{fc.isError}}
      @size={{@size}}
      @width={{@width}}
      @overrides={{@overrides}}
      id={{fc.controlId}}
      disabled={{fc.disabled}}
      required={{@isRequired}}
      aria-describedby={{fc.captionId}}
      aria-errormessage={{fc.errorMessageId}}
      aria-invalid={{if fc.isError "true"}}
      aria-required={{if @isRequired "true"}}
      ...attributes
    >
      {{yield}}
    </SelectBase>
  </FormControl>
</template>;

export default SelectField;
