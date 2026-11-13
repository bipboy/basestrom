import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Switch from '../../src/components/switch/index.gts';
import {
    HeadingMedium,
    HeadingXLarge,
    ParagraphSmall,
    ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class SwitchDemo extends Component {
  @tracked basicOn = false;
  @tracked iconOn = true;
  @tracked smallOn = false;
  @tracked leftOn = true;

  toggleBasic = (e: Event) => { this.basicOn = (e.target as HTMLInputElement).checked; };
  toggleIcon = (e: Event) => { this.iconOn = (e.target as HTMLInputElement).checked; };
  toggleSmall = (e: Event) => { this.smallOn = (e.target as HTMLInputElement).checked; };
  toggleLeft = (e: Event) => { this.leftOn = (e.target as HTMLInputElement).checked; };

  <template>
    <HeadingXLarge>Switch</HeadingXLarge>
    <ParagraphSmall>Toggle control with two sizes, optional checkmark icon when on, and label placement.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Switch @checked={{this.basicOn}} @onChange={{this.toggleBasic}}>Notifications</Switch>
      <Switch @checked={{this.iconOn}} @onChange={{this.toggleIcon}} @showIcon={{true}}>With checkmark icon</Switch>
    </div>

    <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Switch @checked={{this.basicOn}} @onChange={{this.toggleBasic}}>Default size</Switch>
      <Switch @checked={{this.smallOn}} @onChange={{this.toggleSmall}} @size="small">Small size</Switch>
    </div>

    <HeadingMedium style="margin-top:24px">Label placement</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Switch @checked={{this.basicOn}} @onChange={{this.toggleBasic}}>Label right (default)</Switch>
      <Switch @checked={{this.leftOn}} @onChange={{this.toggleLeft}} @labelPlacement="left">Label left</Switch>
    </div>

    <HeadingMedium style="margin-top:24px">States</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px">
      <Switch @disabled={{true}}>Disabled off</Switch>
      <Switch @disabled={{true}} @checked={{true}}>Disabled on</Switch>
    </div>

    <ParagraphXSmall style="margin-top:16px;color:#727272">Press Enter while focused to toggle (Space toggles natively too).</ParagraphXSmall>
  </template>
}

export default SwitchDemo;
