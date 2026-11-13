import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import ButtonTimed from '../../src/components/button-timed/index.gts';
import Divider from '../../src/components/divider/index.gts';
import { HeadingMedium, HeadingSmall, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class ButtonTimedPlayground extends Component {
  @tracked isPaused = false;
  @tracked actionLog: string[] = [];

  handleClick = () => {
    this.actionLog = [...this.actionLog, `Triggered at ${new Date().toLocaleTimeString()}`];
  };

  togglePause = () => {
    this.isPaused = !this.isPaused;
  };

  <template>
    <HeadingXLarge>ButtonTimed</HeadingXLarge>
    <ParagraphSmall>A button with a countdown timer that auto-triggers its action when time expires.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic (10 seconds)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Clicks automatically when timer reaches zero, or click manually to trigger immediately.</ParagraphXSmall>
    <ButtonTimed
      @initialTime={{10}}
      @onClick={{this.handleClick}}
    >
      Redirecting
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>Short Timer (5 seconds)</HeadingMedium>
    <ButtonTimed
      @initialTime={{5}}
      @onClick={{this.handleClick}}
    >
      Auto-submit
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>Long Timer (60 seconds)</HeadingMedium>
    <ButtonTimed
      @initialTime={{60}}
      @onClick={{this.handleClick}}
    >
      Processing
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>Paused State</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Paused: {{this.isPaused}}</ParagraphXSmall>
    <div style="display:flex;gap:12px;align-items:center;flex-wrap:wrap">
      <ButtonTimed
        @initialTime={{30}}
        @paused={{this.isPaused}}
        @onClick={{this.handleClick}}
      >
        Pausable Timer
      </ButtonTimed>
      <button type="button" style="padding:8px 16px;cursor:pointer" {{on "click" this.togglePause}}>
        {{if this.isPaused "Resume" "Pause"}}
      </button>
    </div>

    <Divider @size="section" />

    <HeadingMedium>Kinds</HeadingMedium>

    <HeadingSmall style="margin-top:16px">Primary (default)</HeadingSmall>
    <ButtonTimed @initialTime={{15}} @onClick={{this.handleClick}} @kind="primary">
      Primary Action
    </ButtonTimed>

    <HeadingSmall style="margin-top:16px">Secondary</HeadingSmall>
    <ButtonTimed @initialTime={{15}} @onClick={{this.handleClick}} @kind="secondary">
      Secondary Action
    </ButtonTimed>

    <HeadingSmall style="margin-top:16px">Tertiary</HeadingSmall>
    <ButtonTimed @initialTime={{15}} @onClick={{this.handleClick}} @kind="tertiary">
      Tertiary Action
    </ButtonTimed>

    <HeadingSmall style="margin-top:16px">Danger Primary</HeadingSmall>
    <ButtonTimed @initialTime={{15}} @onClick={{this.handleClick}} @kind="dangerPrimary">
      Danger Action
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>Disabled</HeadingMedium>
    <ButtonTimed @initialTime={{20}} @onClick={{this.handleClick}} @disabled={{true}}>
      Disabled Timer
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>With Enhancers</HeadingMedium>
    <ButtonTimed @initialTime={{10}} @onClick={{this.handleClick}}>
      <:startEnhancer>🔄</:startEnhancer>
      <:default>Undo Action</:default>
    </ButtonTimed>

    <Divider @size="section" />

    <HeadingMedium>Action Log</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Actions triggered by timers above:</ParagraphXSmall>
    <div style="background:#f5f5f5;padding:12px;border-radius:4px;min-height:60px;font-family:monospace;font-size:12px">
      {{#each this.actionLog as |entry|}}
        <div>{{entry}}</div>
      {{/each}}
      {{#unless this.actionLog.length}}
        <ParagraphXSmall style="color:#999">No actions triggered yet.</ParagraphXSmall>
      {{/unless}}
    </div>
  </template>
}

export default ButtonTimedPlayground;
