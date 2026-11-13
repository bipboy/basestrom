import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Alert, Check, Search } from '../../src/components/icon/glyphs.gts';
import Input from '../../src/components/input/index.gts';
import {
  HeadingMedium,
  HeadingSmall,
  HeadingXLarge,
  ParagraphSmall,
  ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class InputDemo extends Component {
  @tracked text = '';
  @tracked search = '';
  @tracked password = '';
  @tracked email = '';
  @tracked number = '';
  @tracked clearableCompact = 'Compact clearable';
  @tracked clearableDefault = 'Default clearable';
  @tracked clearableLarge = 'Large clearable';

  handleText = (e: Event) => { this.text = (e.target as HTMLInputElement).value; };
  handleSearch = (e: Event) => { this.search = (e.target as HTMLInputElement).value; };
  handlePassword = (e: Event) => { this.password = (e.target as HTMLInputElement).value; };
  handleEmail = (e: Event) => { this.email = (e.target as HTMLInputElement).value; };
  handleNumber = (e: Event) => { this.number = (e.target as HTMLInputElement).value; };
  handleClearableCompact = (e: Event) => { this.clearableCompact = (e.target as HTMLInputElement).value; };
  handleClearableDefault = (e: Event) => { this.clearableDefault = (e.target as HTMLInputElement).value; };
  handleClearableLarge = (e: Event) => { this.clearableLarge = (e.target as HTMLInputElement).value; };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Input</HeadingXLarge>
      <ParagraphSmall>Text input with sizes, states, clearable, password toggle, and enhancers.</ParagraphSmall>
    </div>

    {{! ─── Basic ─────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Basic</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @value={{this.text}} @onChange={{this.handleText}} @placeholder="Enter text..." />
        <ParagraphXSmall>Value: {{this.text}}</ParagraphXSmall>
      </div>
    </div>

    {{! ─── Sizes ─────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Sizes</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @size="mini" @placeholder="Mini" />
        <Input @size="compact" @placeholder="Compact" />
        <Input @size="default" @placeholder="Default" />
        <Input @size="large" @placeholder="Large" />
      </div>
    </div>

    {{! ─── Sizes with enhancers ──────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Sizes with enhancers</HeadingMedium>
      <ParagraphSmall>Enhancers should scale proportionally with input size.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @size="mini" @value="Mini">
          <:startEnhancer><Search @size="12px" /></:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
        <Input @size="compact" @value="Compact">
          <:startEnhancer><Search @size="14px" /></:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
        <Input @size="default" @value="Default">
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
        <Input @size="large" @value="Large">
          <:startEnhancer><Search @size="20px" /></:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
      </div>
    </div>

    {{! ─── States ────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>States</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @placeholder="Default state" />
        <Input @error={{true}} @placeholder="Error state" />
        <Input @positive={{true}} @placeholder="Positive state" />
        <Input @disabled={{true}} @placeholder="Disabled state" @value="Can't edit" />
        <Input @readOnly={{true}} @value="Read only value" />
      </div>
    </div>

    {{! ─── States with enhancers (key baseweb scenario) ──────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>States with enhancers</HeadingMedium>
      <ParagraphSmall>Enhancer background and colors must transition in sync with the input state.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @value="Default" @autoFocus={{false}}>
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
        <Input @value="Focused (click me)" @autoFocus={{true}}>
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
        <Input @value="Positive" @positive={{true}}>
          <:startEnhancer><Check @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
        <Input @value="Error" @error={{true}}>
          <:startEnhancer><Alert @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
        <Input @value="Disabled" @disabled={{true}}>
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
        <Input @value="Read Only" @readOnly={{true}}>
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>
      </div>
    </div>

    {{! ─── Clearable ─────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Clearable</HeadingMedium>
      <ParagraphSmall>Clear icon appears when value is non-empty. Escape key also clears.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @value={{this.clearableCompact}} @onChange={{this.handleClearableCompact}} @clearable={{true}} @size="compact" @placeholder="Compact clearable" />
        <Input @value={{this.clearableDefault}} @onChange={{this.handleClearableDefault}} @clearable={{true}} @placeholder="Default clearable" />
        <Input @value={{this.clearableLarge}} @onChange={{this.handleClearableLarge}} @clearable={{true}} @size="large" @placeholder="Large clearable" />
      </div>
    </div>

    {{! ─── Clearable + clearOnEscape=false ───────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Clearable (no Escape)</HeadingMedium>
      <ParagraphSmall>clearOnEscape=false - Escape key does NOT clear value.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Input @value={{this.search}} @onChange={{this.handleSearch}} @clearable={{true}} @clearOnEscape={{false}} @placeholder="Type then press Escape..." />
      </div>
    </div>

    {{! ─── Clearable + Enhancers ─────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Clearable + Enhancers</HeadingMedium>
      <ParagraphSmall>Clear icon coexists with start/end enhancers.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @value={{this.search}} @onChange={{this.handleSearch}} @clearable={{true}} @placeholder="Search...">
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
        </Input>
        <Input @value={{this.email}} @onChange={{this.handleEmail}} @clearable={{true}} @placeholder="Username">
          <:startEnhancer>@</:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
      </div>
    </div>

    {{! ─── Password (mask toggle) ────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Password (mask toggle)</HeadingMedium>
      <ParagraphSmall>All sizes with mask toggle icon.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @type="password" @size="mini" @value="pass1234" @placeholder="Mini password" />
        <Input @type="password" @size="compact" @value="pass1234" @placeholder="Compact password" />
        <Input @type="password" @value={{this.password}} @onChange={{this.handlePassword}} @placeholder="Default password" />
        <Input @type="password" @size="large" @value="pass1234" @placeholder="Large password" />
      </div>
    </div>

    {{! ─── Enhancers basic ───────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Enhancers</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <HeadingSmall>Start enhancer</HeadingSmall>
        <Input @placeholder="Search...">
          <:startEnhancer><Search @size="16px" /></:startEnhancer>
        </Input>

        <HeadingSmall>End enhancer</HeadingSmall>
        <Input @value={{this.email}} @onChange={{this.handleEmail}} @placeholder="Email">
          <:endEnhancer>@gmail.com</:endEnhancer>
        </Input>

        <HeadingSmall>Both enhancers</HeadingSmall>
        <Input @placeholder="Amount">
          <:startEnhancer>$</:startEnhancer>
          <:endEnhancer>.00</:endEnhancer>
        </Input>

        <HeadingSmall>Icon enhancers</HeadingSmall>
        <Input @placeholder="Enter URL">
          <:startEnhancer>https://</:startEnhancer>
          <:endEnhancer>.com</:endEnhancer>
        </Input>
      </div>
    </div>

    {{! ─── Number Input ──────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Number Input</HeadingMedium>
      <div style="margin-top:16px;max-width:200px">
        <Input @type="number" @value={{this.number}} @onChange={{this.handleNumber}} @placeholder="0" @min={{0}} @max={{100}} @step={{1}} />
        <ParagraphXSmall>Value: {{this.number}}</ParagraphXSmall>
      </div>
    </div>

    {{! ─── AutoFocus ─────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>AutoFocus</HeadingMedium>
      <ParagraphSmall>This input should be focused on page load.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Input @autoFocus={{true}} @placeholder="I'm auto-focused" />
      </div>
    </div>

    {{! ─── AutoComplete ──────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>AutoComplete</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @autoComplete="email" @placeholder="Email (autocomplete=email)" @name="email" />
        <Input @autoComplete="off" @placeholder="No autocomplete" />
      </div>
    </div>

    {{! ─── Required ──────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Required</HeadingMedium>
      <ParagraphSmall>aria-required is set when @required={{true}}.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Input @required={{true}} @placeholder="This field is required" />
      </div>
    </div>

    {{! ─── Max Length ────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Max Length</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Input @maxLength={{10}} @placeholder="Max 10 chars" />
      </div>
    </div>

    {{! ─── Pattern Validation ────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Pattern</HeadingMedium>
      <ParagraphSmall>Only digits allowed (pattern=[0-9]+).</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Input @pattern="[0-9]+" @placeholder="Digits only" />
      </div>
    </div>

    {{! ─── InputMode ─────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>InputMode</HeadingMedium>
      <ParagraphSmall>Mobile virtual keyboard hint. No visible effect on desktop - test on mobile device or emulator.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Input @inputMode="numeric" @placeholder="inputMode=numeric (number pad on mobile)" />
        <Input @inputMode="tel" @placeholder="inputMode=tel (phone pad on mobile)" />
        <Input @inputMode="url" @placeholder="inputMode=url (url keyboard on mobile)" />
      </div>
    </div>

    {{! ─── Adjoined (grouped inputs) ────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Adjoined</HeadingMedium>
      <ParagraphSmall>Border-radius and border-width control for grouping inputs. Borders collapse at shared edges.</ParagraphSmall>
      <div style="margin-top:16px;max-width:600px;display:flex">
        <Input @adjoined="left" @placeholder="Left" />
        <Input @adjoined="both" @placeholder="Both" />
        <Input @adjoined="right" @placeholder="Right" />
      </div>
      <div style="margin-top:12px;max-width:400px;display:flex">
        <Input @adjoined="left" @placeholder="Left" />
        <Input @adjoined="right" @placeholder="Right" />
      </div>
    </div>
  </template>
}

export default InputDemo;
