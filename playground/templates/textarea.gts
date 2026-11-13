import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Textarea from '../../src/components/textarea/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class TextareaDemo extends Component {
  @tracked text = '';
  @tracked bio = 'Hello, I am a developer.';

  handleText = (e: Event) => { this.text = (e.target as HTMLTextAreaElement).value; };
  handleBio = (e: Event) => { this.bio = (e.target as HTMLTextAreaElement).value; };

  <template>
    <HeadingXLarge>Textarea</HeadingXLarge>
    <ParagraphSmall>Multi-line text input with sizes, states, resize control, and character counter.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic</HeadingMedium>
    <div style="max-width:400px">
      <Textarea @value={{this.text}} @onChange={{this.handleText}} @placeholder="Enter text..." />
      <ParagraphXSmall style="color:#727272;margin-top:4px">Value: {{this.text}}</ParagraphXSmall>
    </div>

    <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px;max-width:400px">
      <Textarea @size="mini" @placeholder="Mini" @rows={{2}} />
      <Textarea @size="compact" @placeholder="Compact" @rows={{2}} />
      <Textarea @size="default" @placeholder="Default" @rows={{3}} />
      <Textarea @size="large" @placeholder="Large" @rows={{3}} />
    </div>

    <HeadingMedium style="margin-top:24px">States</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px;max-width:400px">
      <Textarea @placeholder="Default state" />
      <Textarea @error={{true}} @placeholder="Error state" />
      <Textarea @positive={{true}} @placeholder="Positive state" />
      <Textarea @disabled={{true}} @value="Disabled textarea" />
      <Textarea @readOnly={{true}} @value="Read only content that cannot be edited." />
    </div>

    <HeadingMedium style="margin-top:24px">With maxLength counter</HeadingMedium>
    <div style="max-width:400px">
      <Textarea @value={{this.bio}} @onChange={{this.handleBio}} @maxLength={{100}} @placeholder="Write your bio..." @rows={{4}} />
    </div>

    <HeadingMedium style="margin-top:24px">Resize variants</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:12px;max-width:400px">
      <ParagraphXSmall style="color:#727272">resize="none" (default)</ParagraphXSmall>
      <Textarea @resize="none" @placeholder="Cannot resize" @rows={{2}} />
      <ParagraphXSmall style="color:#727272">resize="vertical"</ParagraphXSmall>
      <Textarea @resize="vertical" @placeholder="Drag bottom edge" @rows={{2}} />
      <ParagraphXSmall style="color:#727272">resize="both"</ParagraphXSmall>
      <Textarea @resize="both" @placeholder="Drag any edge" @rows={{2}} />
    </div>
  </template>
}

export default TextareaDemo;
