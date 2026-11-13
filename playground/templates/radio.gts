import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Radio, RadioGroup } from '../../src/components/radio/index.gts';
import { HeadingMedium, HeadingSmall, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class RadioDemo extends Component {
  @tracked selected = 'b';
  @tracked plan = 'free';
  @tracked size = 's';
  @tracked errorVal = 'err';

  handleChange = (event: Event) => { this.selected = (event.target as HTMLInputElement).value; };
  handlePlanChange = (event: Event) => { this.plan = (event.target as HTMLInputElement).value; };
  handleSizeChange = (event: Event) => { this.size = (event.target as HTMLInputElement).value; };
  handleErrorChange = (event: Event) => { this.errorVal = (event.target as HTMLInputElement).value; };

  <template>
    <HeadingXLarge>Radio</HeadingXLarge>
    <ParagraphSmall>Form control for single selection from a group. Full a11y support including aria-describedby, aria-errormessage, autoFocus, and containsInteractiveElement.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic RadioGroup</HeadingMedium>
    <ParagraphXSmall style="color:#727272;margin-bottom:8px">Selected: {{this.selected}}</ParagraphXSmall>
    <RadioGroup @value={{this.selected}} @onChange={{this.handleChange}} @name="demo" as |group|>
      <Radio @group={{group}} @value="a">Option A</Radio>
      <Radio @group={{group}} @value="b">Option B</Radio>
      <Radio @group={{group}} @value="c">Option C</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">With Description</HeadingMedium>
    <RadioGroup @name="plan" @value={{this.plan}} @onChange={{this.handlePlanChange}} as |group|>
      <Radio @group={{group}} @value="free" @description="Basic features, no cost">Free</Radio>
      <Radio @group={{group}} @value="pro" @description="Advanced features, $10/mo">Pro</Radio>
      <Radio @group={{group}} @value="enterprise" @description="Custom solutions, contact us">Enterprise</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">Horizontal Layout</HeadingMedium>
    <RadioGroup @align="horizontal" @name="size" @value={{this.size}} @onChange={{this.handleSizeChange}} as |group|>
      <Radio @group={{group}} @value="s">Small</Radio>
      <Radio @group={{group}} @value="m">Medium</Radio>
      <Radio @group={{group}} @value="l">Large</Radio>
      <Radio @group={{group}} @value="xl">XLarge</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">States</HeadingMedium>
    <HeadingSmall style="margin-top:12px">Disabled group</HeadingSmall>
    <RadioGroup @name="disabled-group" @value="a" @disabled={{true}} as |group|>
      <Radio @group={{group}} @value="a">Disabled checked</Radio>
      <Radio @group={{group}} @value="b">Disabled unchecked</Radio>
    </RadioGroup>

    <HeadingSmall style="margin-top:16px">Individual disabled</HeadingSmall>
    <RadioGroup @name="partial-disabled" @value="normal" as |group|>
      <Radio @group={{group}} @value="normal">Normal (selected)</Radio>
      <Radio @group={{group}} @value="disabled" @disabled={{true}}>This one is disabled</Radio>
      <Radio @group={{group}} @value="also-normal">Also normal</Radio>
    </RadioGroup>

    <HeadingSmall style="margin-top:16px">Error state</HeadingSmall>
    <RadioGroup @name="error-states" @error={{true}} @value={{this.errorVal}} @onChange={{this.handleErrorChange}} as |group|>
      <Radio @group={{group}} @value="err">Error checked</Radio>
      <Radio @group={{group}} @value="err2">Error unchecked</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">ARIA Attributes</HeadingMedium>
    <HeadingSmall style="margin-top:12px">aria-describedby &amp; aria-errormessage on group</HeadingSmall>
    <RadioGroup @name="aria-demo" @value="option1" @error={{true}} @aria-describedby="radio-hint" @aria-errormessage="radio-error" @aria-label="Payment method selection" as |group|>
      <Radio @group={{group}} @value="option1">Credit Card</Radio>
      <Radio @group={{group}} @value="option2">PayPal</Radio>
      <Radio @group={{group}} @value="option3">Bank Transfer</Radio>
    </RadioGroup>
    <ParagraphXSmall id="radio-hint" style="margin:4px 0 0;color:#727272">Select your preferred payment method.</ParagraphXSmall>
    <ParagraphXSmall id="radio-error" style="margin:4px 0 0;color:#DE1135" role="alert">Payment method is required to proceed.</ParagraphXSmall>

    <HeadingSmall style="margin-top:16px">aria-describedby on individual radio</HeadingSmall>
    <RadioGroup @name="radio-aria-individual" @value="fast" as |group|>
      <Radio @group={{group}} @value="fast" @aria-describedby="fast-desc">Express Shipping</Radio>
      <Radio @group={{group}} @value="standard" @aria-describedby="standard-desc">Standard Shipping</Radio>
    </RadioGroup>
    <ParagraphXSmall id="fast-desc" style="margin:4px 0 0;color:#727272">Arrives in 1-2 business days. Extra $15.</ParagraphXSmall>
    <ParagraphXSmall id="standard-desc" style="margin:4px 0 0;color:#727272">Arrives in 5-7 business days. Free.</ParagraphXSmall>

    <HeadingMedium style="margin-top:24px">AutoFocus</HeadingMedium>
    <ParagraphXSmall style="color:#727272;margin-bottom:8px">The selected radio in this group auto-focuses on mount.</ParagraphXSmall>
    <RadioGroup @name="autofocus-demo" @value="focused" @autoFocus={{true}} as |group|>
      <Radio @group={{group}} @value="not-focused">Not focused</Radio>
      <Radio @group={{group}} @value="focused">This one auto-focuses</Radio>
      <Radio @group={{group}} @value="also-not">Also not focused</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">Contains Interactive Element</HeadingMedium>
    <ParagraphXSmall style="color:#727272;margin-bottom:8px">When @containsInteractiveElement is true, clicking the label doesn't steal focus from child interactive elements.</ParagraphXSmall>
    <RadioGroup @name="interactive-demo" @value="agree" as |group|>
      <Radio @group={{group}} @value="agree" @containsInteractiveElement={{true}}>
        <span>I agree to the <a href="#" style="color:#276EF1">Terms of Service</a> and <a href="#" style="color:#276EF1">Privacy Policy</a></span>
      </Radio>
      <Radio @group={{group}} @value="disagree">I do not agree</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">Required</HeadingMedium>
    <RadioGroup @name="required-demo" @required={{true}} @value="" as |group|>
      <Radio @group={{group}} @value="yes">Yes</Radio>
      <Radio @group={{group}} @value="no">No</Radio>
      <Radio @group={{group}} @value="maybe">Maybe</Radio>
    </RadioGroup>
    <ParagraphXSmall style="color:#727272;margin-top:4px">This group has required - form won't submit without selection.</ParagraphXSmall>

    <HeadingMedium style="margin-top:24px">Label Placement</HeadingMedium>
    <RadioGroup @name="label-placement" @value="right" @labelPlacement="left" as |group|>
      <Radio @group={{group}} @value="right">Label on left (via group)</Radio>
      <Radio @group={{group}} @value="left">Another option</Radio>
    </RadioGroup>

    <HeadingMedium style="margin-top:24px">Standalone (no group)</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:8px">
      <Radio @value="standalone" @checked={{true}}>Standalone checked</Radio>
      <Radio @value="standalone2" @disabled={{true}}>Standalone disabled</Radio>
      <Radio @value="standalone3" @error={{true}}>Standalone error</Radio>
    </div>
  </template>
}

export default RadioDemo;
