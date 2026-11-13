import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Divider from '../../src/components/divider/index.gts';
import SlidingButton from '../../src/components/sliding-button/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class SlidingButtonPlayground extends Component {
  @tracked completionLog: string[] = [];
  @tracked isLoading = false;

  handleComplete = () => {
    this.completionLog = [...this.completionLog, `Completed at ${new Date().toLocaleTimeString()}`];
  };

  handleCompleteWithLoading = () => {
    this.isLoading = true;
    setTimeout(() => {
      this.isLoading = false;
      this.completionLog = [...this.completionLog, `Payment processed at ${new Date().toLocaleTimeString()}`];
    }, 2000);
  };

  <template>
    <HeadingXLarge>SlidingButton</HeadingXLarge>
    <ParagraphSmall>A slide-to-confirm interaction where the user drags a grabber across a track to confirm an action.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic (high threshold)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Default threshold requires 80% drag to confirm. Also supports Enter/Space keyboard activation.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to confirm"
        @onComplete={{this.handleComplete}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Low Threshold (20%)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Only requires 20% drag distance to trigger completion.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to unlock"
        @threshold="low"
        @onComplete={{this.handleComplete}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>High Threshold (80%)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Requires 80% drag distance - more deliberate action needed.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to delete"
        @threshold="high"
        @onComplete={{this.handleComplete}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Auto-Reset (slideBackAfterMs)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Resets to idle state 3 seconds after completion. Try sliding it multiple times.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to send"
        @slideBackAfterMs={{3000}}
        @onComplete={{this.handleComplete}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Loading State</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Shows a spinner overlay and disables interaction. Simulates a 2-second async operation.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to pay"
        @isLoading={{this.isLoading}}
        @slideBackAfterMs={{2500}}
        @onComplete={{this.handleCompleteWithLoading}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Disabled State</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Grayed out, no interaction possible.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to confirm"
        @isDisabled={{true}}
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Custom Aria Label</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Accessible label differs from visible text - useful for screen readers.</ParagraphXSmall>
    <div style="max-width:400px">
      <SlidingButton
        @label="Slide to confirm order"
        @onComplete={{this.handleComplete}}
        aria-label="Confirm your order by sliding or pressing Enter"
      />
    </div>

    <Divider @size="section" />

    <HeadingMedium>Different Widths</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">The component fills its container width.</ParagraphXSmall>
    <div style="display:flex;flex-direction:column;gap:16px">
      <div style="max-width:250px">
        <ParagraphXSmall>250px</ParagraphXSmall>
        <SlidingButton @label="Narrow" @onComplete={{this.handleComplete}} />
      </div>
      <div style="max-width:400px">
        <ParagraphXSmall>400px</ParagraphXSmall>
        <SlidingButton @label="Medium width" @onComplete={{this.handleComplete}} />
      </div>
      <div style="max-width:600px">
        <ParagraphXSmall>600px</ParagraphXSmall>
        <SlidingButton @label="Wide container" @onComplete={{this.handleComplete}} />
      </div>
    </div>

    <Divider @size="section" />

    <HeadingMedium>Completion Log</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Actions triggered by sliding buttons above:</ParagraphXSmall>
    <div style="background:#f5f5f5;padding:12px;border-radius:4px;min-height:60px;font-family:monospace;font-size:12px">
      {{#each this.completionLog as |entry|}}
        <div>{{entry}}</div>
      {{/each}}
      {{#unless this.completionLog.length}}
        <ParagraphXSmall style="color:#999">No completions yet. Try sliding a button above.</ParagraphXSmall>
      {{/unless}}
    </div>
  </template>
}

export default SlidingButtonPlayground;
