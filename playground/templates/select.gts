import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import SelectBase from '../../src/components/select/base.gts';
import SelectField from '../../src/components/select/field.gts';
import {
    HeadingMedium,
    HeadingXLarge,
    ParagraphSmall,
    ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class SelectDemo extends Component {
  @tracked selectedRegion = '';
  @tracked selectedEnv = '';

  handleRegionChange = (event: Event) => {
    this.selectedRegion = (event.target as HTMLSelectElement).value;
  };

  handleEnvChange = (event: Event) => {
    this.selectedEnv = (event.target as HTMLSelectElement).value;
  };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Select</HeadingXLarge>
      <ParagraphSmall>Native &lt;select&gt; styled with basestrom tokens. Split into Base (bare) and Field (with FormControl).</ParagraphSmall>
    </div>

    {{! ─── Base: Basic ───────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Base - Basic</HeadingMedium>
      <div style="margin-top:16px;max-width:320px;display:flex;flex-direction:column;gap:12px">
        <SelectBase {{on "change" this.handleRegionChange}}>
          <option value="">Select a region...</option>
          <option value="us-east-1">US East (N. Virginia)</option>
          <option value="us-west-2">US West (Oregon)</option>
          <option value="eu-west-1">EU West (Ireland)</option>
          <option value="ap-southeast-1">Asia Pacific (Singapore)</option>
        </SelectBase>
        <ParagraphXSmall>Selected: {{this.selectedRegion}}</ParagraphXSmall>
      </div>
    </div>

    {{! ─── Base: Sizes ───────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Base - Sizes</HeadingMedium>
      <div style="margin-top:16px;max-width:320px;display:flex;flex-direction:column;gap:12px">
        <SelectBase @size="mini">
          <option value="">Mini</option>
          <option value="a">Option A</option>
          <option value="b">Option B</option>
        </SelectBase>
        <SelectBase @size="compact">
          <option value="">Compact</option>
          <option value="a">Option A</option>
          <option value="b">Option B</option>
        </SelectBase>
        <SelectBase @size="default">
          <option value="">Default</option>
          <option value="a">Option A</option>
          <option value="b">Option B</option>
        </SelectBase>
        <SelectBase @size="large">
          <option value="">Large</option>
          <option value="a">Option A</option>
          <option value="b">Option B</option>
        </SelectBase>
      </div>
    </div>

    {{! ─── Base: States ──────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Base - States</HeadingMedium>
      <div style="margin-top:16px;max-width:320px;display:flex;flex-direction:column;gap:12px">
        <SelectBase>
          <option value="">Default</option>
          <option value="a">Option A</option>
        </SelectBase>
        <SelectBase @isInvalid={{true}}>
          <option value="">Invalid / Error</option>
          <option value="a">Option A</option>
        </SelectBase>
        <SelectBase disabled>
          <option value="">Disabled</option>
          <option value="a">Option A</option>
        </SelectBase>
      </div>
    </div>

    {{! ─── Base: Custom Width ────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Base - Custom Width</HeadingMedium>
      <div style="margin-top:16px;display:flex;gap:12px;align-items:flex-start;flex-wrap:wrap">
        <SelectBase @width="140px" @size="compact">
          <option value="">140px</option>
          <option value="a">Option A</option>
        </SelectBase>
        <SelectBase @width="240px" @size="compact">
          <option value="">240px</option>
          <option value="a">Option A</option>
        </SelectBase>
        <SelectBase @width="auto" @size="compact">
          <option value="">auto width</option>
          <option value="a">A longer option text</option>
        </SelectBase>
      </div>
    </div>

    {{! ─── Base: Optgroups ───────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Base - Option Groups</HeadingMedium>
      <div style="margin-top:16px;max-width:320px">
        <SelectBase>
          <option value="">Select a city...</option>
          <optgroup label="North America">
            <option value="nyc">New York</option>
            <option value="sf">San Francisco</option>
            <option value="tor">Toronto</option>
          </optgroup>
          <optgroup label="Europe">
            <option value="ldn">London</option>
            <option value="ber">Berlin</option>
            <option value="ams">Amsterdam</option>
          </optgroup>
          <optgroup label="Asia">
            <option value="sgp">Singapore</option>
            <option value="tyo">Tokyo</option>
          </optgroup>
        </SelectBase>
      </div>
    </div>

    {{! ─── Field: With FormControl ───────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Field - With FormControl</HeadingMedium>
      <ParagraphSmall>SelectField wraps SelectBase in FormControl for label, caption, and error.</ParagraphSmall>
      <div style="margin-top:16px;max-width:320px;display:flex;flex-direction:column;gap:8px">
        <SelectField
          @label="Deploy Region"
          @caption="Choose the region closest to your users."
          {{on "change" this.handleRegionChange}}
        >
          <option value="">Select region...</option>
          <option value="us-east-1">US East (N. Virginia)</option>
          <option value="us-west-2">US West (Oregon)</option>
          <option value="eu-west-1">EU West (Ireland)</option>
        </SelectField>

        <SelectField
          @label="Environment"
          @error="This field is required."
          @isRequired={{true}}
          {{on "change" this.handleEnvChange}}
        >
          <option value="">Select environment...</option>
          <option value="dev">Development</option>
          <option value="staging">Staging</option>
          <option value="prod">Production</option>
        </SelectField>

        <SelectField
          @label="Tier"
          @caption="Contact admin to change."
          @disabled={{true}}
        >
          <option value="free">Free</option>
          <option value="pro">Pro</option>
          <option value="enterprise">Enterprise</option>
        </SelectField>
      </div>
    </div>

    {{! ─── Field: Sizes ──────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Field - Sizes</HeadingMedium>
      <div style="margin-top:16px;max-width:320px;display:flex;flex-direction:column;gap:8px">
        <SelectField @label="Mini" @size="mini">
          <option value="">Choose...</option>
          <option value="a">Option A</option>
        </SelectField>
        <SelectField @label="Compact" @size="compact">
          <option value="">Choose...</option>
          <option value="a">Option A</option>
        </SelectField>
        <SelectField @label="Default" @size="default">
          <option value="">Choose...</option>
          <option value="a">Option A</option>
        </SelectField>
        <SelectField @label="Large" @size="large">
          <option value="">Choose...</option>
          <option value="a">Option A</option>
        </SelectField>
      </div>
    </div>
  </template>
}

export default SelectDemo;
