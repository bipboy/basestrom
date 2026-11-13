import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Slider, { StatefulSlider } from '../../src/components/slider/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class SliderDemo extends Component {
  @tracked singleValue = [40];
  @tracked rangeValue = [20, 70];
  @tracked steppedValue = [50];

  get singleValueText(): string { return this.singleValue.join(', '); }
  get rangeValueText(): string { return this.rangeValue.join(', '); }
  get steppedValueText(): string { return this.steppedValue.join(', '); }

  handleSingleChange = (params: { value: number[] }) => { this.singleValue = params.value; };
  handleRangeChange = (params: { value: number[] }) => { this.rangeValue = params.value; };
  handleSteppedChange = (params: { value: number[] }) => { this.steppedValue = params.value; };

  temperatureLabel = (value: number): string => `${value}°C`;

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Slider</HeadingXLarge>
      <ParagraphSmall>Draggable slider with single thumb, range mode, marks, and keyboard navigation.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Basic (single thumb)</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.singleValue}} @onChange={{this.handleSingleChange}} />
        <ParagraphXSmall>Value: {{this.singleValueText}}</ParagraphXSmall>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Range (two thumbs)</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.rangeValue}} @onChange={{this.handleRangeChange}} />
        <ParagraphXSmall>Value: {{this.rangeValueText}}</ParagraphXSmall>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Marks (step=10)</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.steppedValue}} @onChange={{this.handleSteppedChange}} @step={{10}} @marks={{true}} />
        <ParagraphXSmall>Value: {{this.steppedValueText}}</ParagraphXSmall>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Persistent Thumb Label</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.singleValue}} @onChange={{this.handleSingleChange}} @persistentThumb={{true}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Custom Label (temperature)</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.steppedValue}} @onChange={{this.handleSteppedChange}} @min={{-20}} @max={{50}} @step={{5}} @valueToLabel={{this.temperatureLabel}} @persistentThumb={{true}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Disabled</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <Slider @value={{this.singleValue}} @disabled={{true}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Stateful (uncontrolled)</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;padding-top:60px">
        <StatefulSlider @step={{5}} @marks={{true}} />
      </div>
    </div>
  </template>
}

export default SliderDemo;
