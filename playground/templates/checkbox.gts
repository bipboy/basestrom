import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Checkbox from '../../src/components/checkbox/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class CheckboxDemo extends Component {
  @tracked checked1 = false;
  @tracked checked2 = true;
  @tracked checked3 = false;
  @tracked checked4 = false;
  @tracked checked5 = true;
  @tracked indeterminate1 = true;

  toggle1 = (e: Event) => { this.checked1 = (e.target as HTMLInputElement).checked; };
  toggle2 = (e: Event) => { this.checked2 = (e.target as HTMLInputElement).checked; };
  toggle3 = (e: Event) => { this.checked3 = (e.target as HTMLInputElement).checked; };
  toggle4 = (e: Event) => { this.checked4 = (e.target as HTMLInputElement).checked; };
  toggle5 = (e: Event) => { this.checked5 = (e.target as HTMLInputElement).checked; };
  toggleIndeterminate = (e: Event) => {
    this.indeterminate1 = false;
    this.checked1 = (e.target as HTMLInputElement).checked;
  };

  <template>
    <HeadingXLarge>Checkbox</HeadingXLarge>
    <ParagraphSmall>Form control for boolean selections. Full a11y support including indeterminate state, Enter key toggle, aria attributes, and interactive element containment.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Checkbox @checked={{this.checked1}} @onChange={{this.toggle1}}>Unchecked by default</Checkbox>
      <Checkbox @checked={{this.checked2}} @onChange={{this.toggle2}}>Checked by default</Checkbox>
    </div>

    <HeadingMedium style="margin-top:24px">States</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Checkbox @disabled={{true}}>Disabled unchecked</Checkbox>
      <Checkbox @checked={{true}} @disabled={{true}}>Disabled checked</Checkbox>
      <Checkbox @isIndeterminate={{true}} @onChange={{this.toggleIndeterminate}}>Indeterminate (DOM property)</Checkbox>
      <Checkbox @isIndeterminate={{true}} @disabled={{true}}>Indeterminate disabled</Checkbox>
      <Checkbox @error={{true}} @checked={{this.checked3}} @onChange={{this.toggle3}}>Error state</Checkbox>
      <Checkbox @error={{true}} @checked={{true}} @disabled={{true}}>Error + disabled + checked</Checkbox>
    </div>

    <HeadingMedium style="margin-top:24px">Label Placement</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Checkbox @checked={{true}}>Label right (default)</Checkbox>
      <Checkbox @checked={{true}} @labelPlacement="left">Label left</Checkbox>
    </div>

    <HeadingMedium style="margin-top:24px">Required &amp; AutoFocus</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Checkbox @required={{true}} @checked={{this.checked4}} @onChange={{this.toggle4}}>Required checkbox (aria-required="true")</Checkbox>
      <Checkbox @autoFocus={{true}} @checked={{this.checked5}} @onChange={{this.toggle5}}>AutoFocus on mount</Checkbox>
    </div>

    <HeadingMedium style="margin-top:24px">ARIA Attributes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px">
      <div>
        <Checkbox @id="terms-checkbox" @checked={{this.checked3}} @onChange={{this.toggle3}} @aria-describedby="terms-description">I accept the terms</Checkbox>
        <ParagraphXSmall id="terms-description" style="margin:4px 0 0 36px;color:#727272">By checking this box you agree to our Terms of Service and Privacy Policy.</ParagraphXSmall>
      </div>
      <div>
        <Checkbox @error={{true}} @aria-errormessage="email-error" @aria-describedby="email-hint">Subscribe to newsletter</Checkbox>
        <ParagraphXSmall id="email-hint" style="margin:4px 0 0 36px;color:#727272">We'll send you weekly updates.</ParagraphXSmall>
        <ParagraphXSmall id="email-error" style="margin:4px 0 0 36px;color:#DE1135" role="alert">Please provide a valid email first.</ParagraphXSmall>
      </div>
      <div>
        <Checkbox @aria-label="Toggle all items" @checked={{true}}>With aria-label (for screen readers)</Checkbox>
      </div>
      <div>
        <Checkbox @aria-controls="controlled-section" @checked={{this.checked4}} @onChange={{this.toggle4}}>Controls a section (aria-controls)</Checkbox>
        <div id="controlled-section" style="margin:8px 0 0 36px;padding:8px;background:#f3f3f3;border-radius:4px">
          <ParagraphXSmall>{{#if this.checked4}}✅ This section is controlled by the checkbox above.{{else}}❌ Section is hidden/inactive.{{/if}}</ParagraphXSmall>
        </div>
      </div>
    </div>

    <HeadingMedium style="margin-top:24px">Contains Interactive Element</HeadingMedium>
    <ParagraphXSmall style="color:#727272;margin-bottom:8px">When @containsInteractiveElement is true, clicking the label doesn't steal focus from child interactive elements.</ParagraphXSmall>
    <Checkbox @containsInteractiveElement={{true}} @checked={{this.checked5}} @onChange={{this.toggle5}}>
      <span>I agree to the <a href="#" style="color:#276EF1">Terms of Service</a></span>
    </Checkbox>

    <HeadingMedium style="margin-top:24px">Enter Key Toggle</HeadingMedium>
    <ParagraphXSmall style="color:#727272;margin-bottom:8px">Focus a checkbox and press Enter - it toggles (native only supports Space).</ParagraphXSmall>
    <Checkbox @checked={{this.checked1}} @onChange={{this.toggle1}}>Try pressing Enter while focused</Checkbox>

    <HeadingMedium style="margin-top:24px">Name &amp; Value (form integration)</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Checkbox @name="preferences" @value="dark_mode" @checked={{true}}>Dark mode</Checkbox>
      <Checkbox @name="preferences" @value="notifications">Notifications</Checkbox>
      <Checkbox @name="preferences" @value="analytics">Analytics</Checkbox>
    </div>
  </template>
}

export default CheckboxDemo;
