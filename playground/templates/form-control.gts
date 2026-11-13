import { hash } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '../../src/components/button/index.gts';
import Checkbox from '../../src/components/checkbox/index.gts';
import FormControl from '../../src/components/form-control/index.gts';
import Input from '../../src/components/input/index.gts';
import { Radio, RadioGroup } from '../../src/components/radio/index.gts';
import Textarea from '../../src/components/textarea/index.gts';
import {
  HeadingMedium,
  HeadingSmall,
  HeadingXLarge,
  ParagraphSmall,
} from '../../src/components/typography/index.gts';

class FormControlDemo extends Component {
  // Mirrors baseweb form-control.scenario.tsx: every state × every input.
  @tracked plain = '';
  @tracked positive = 'ok';
  @tracked errored = '';
  @tracked disabledVal = 'locked';

  // baseweb form-control-with-counter.scenario.tsx
  @tracked counterValue = '';
  @tracked counterMaxedValue = 'short';
  @tracked counterTextarea = '';

  // free-form
  @tracked email = '';
  @tracked emailTouched = false;
  @tracked username = 'ada';
  @tracked bio = 'I work on the Analytical Engine.';

  @tracked terms = false;
  @tracked color = 'red';

  get emailError(): string | boolean {
    if (!this.emailTouched) return false;
    if (this.email.length === 0) return 'Email is required.';
    if (!this.email.includes('@')) return 'Please enter a valid email.';
    return false;
  }
  get usernamePositive(): string | boolean {
    return this.username.length >= 3 ? 'Looks good.' : false;
  }

  set = <K extends keyof this>(key: K, event: Event) => {
    // @ts-expect-error - we know the field accepts the value
    this[key] = (event.target as HTMLInputElement | HTMLTextAreaElement).value;
  };

  setPlain = (e: Event) => this.set('plain', e);
  setPositive = (e: Event) => this.set('positive', e);
  setErrored = (e: Event) => this.set('errored', e);
  setEmail = (e: Event) => this.set('email', e);
  blurEmail = () => { this.emailTouched = true; };
  setUsername = (e: Event) => this.set('username', e);
  setBio = (e: Event) => this.set('bio', e);

  setCounterValue = (e: Event) => this.set('counterValue', e);
  setCounterMaxed = (e: Event) => this.set('counterMaxedValue', e);
  setCounterTextarea = (e: Event) => this.set('counterTextarea', e);

  setTerms = (event: Event) => {
    this.terms = (event.target as HTMLInputElement).checked;
  };
  setColor = (event: Event) => {
    this.color = (event.target as HTMLInputElement).value;
  };

  preventSubmit = (event: Event) => {
    event.preventDefault();
  };

  <template>
    <HeadingXLarge>FormControl</HeadingXLarge>
    <ParagraphSmall>Wraps a single input with a label, optional end enhancer (counter), and an optional caption that swaps to error or positive messaging. Yields its computed state - pass it through to the input.</ParagraphSmall>

    {{!-- ───────────────────────────────────────────────────────────────────── --}}
    {{!-- States - mirrors baseweb form-control.scenario.tsx                     --}}
    {{!-- ───────────────────────────────────────────────────────────────────── --}}

    <HeadingMedium style="margin-top:24px">States × Input</HeadingMedium>
    <ParagraphSmall>Same as baseweb's stock scenario: default, disabled, disabled with enabled input, positive, error.</ParagraphSmall>

    <div style="max-width:480px;display:flex;flex-direction:column;gap:0;margin-top:8px">
      <FormControl @label="Input label" @caption="Input caption" as |fc|>
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.plain}}
          @onChange={{this.setPlain}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Input label disabled"
        @caption="Input caption"
        @disabled={{true}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.plain}}
          @onChange={{this.setPlain}}
          @disabled={{fc.disabled}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Input label disabled with enabled input"
        @caption="Input caption"
        @disabled={{true}}
        as |fc|
      >
        {{!-- Note: the child stays enabled - the consumer chooses whether to forward fc.disabled --}}
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.plain}}
          @onChange={{this.setPlain}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Input label positive"
        @caption="Input caption"
        @positive={{true}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.positive}}
          @onChange={{this.setPositive}}
          @positive={{fc.isPositive}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Input label error"
        @caption="Input caption"
        @error={{true}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.errored}}
          @onChange={{this.setErrored}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
          aria-errormessage={{fc.errorMessageId}}
        />
      </FormControl>
    </div>

    <HeadingMedium style="margin-top:24px">States × Textarea</HeadingMedium>
    <div style="max-width:480px;margin-top:8px">
      <FormControl @label="Textarea label" @caption="Textarea caption" as |fc|>
        <Textarea
          id={{fc.controlId}}
          @size="compact"
          @value={{this.plain}}
          @onChange={{this.setPlain}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Textarea error"
        @caption="Textarea caption"
        @error={{true}}
        as |fc|
      >
        <Textarea
          id={{fc.controlId}}
          @size="compact"
          @value={{this.errored}}
          @onChange={{this.setErrored}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
          aria-errormessage={{fc.errorMessageId}}
        />
      </FormControl>
    </div>

    <HeadingMedium style="margin-top:24px">States × Checkbox / Radio</HeadingMedium>
    <div style="max-width:480px;margin-top:8px">
      <FormControl @label="Checkbox label" @caption="Checkbox caption" as |fc|>
        <Checkbox
          id={{fc.controlId}}
          @checked={{this.terms}}
          @onChange={{this.setTerms}}
          aria-describedby={{fc.captionId}}
        >Checkbox control</Checkbox>
      </FormControl>

      <FormControl @label="RadioGroup label" @caption="RadioGroup caption" as |fc|>
        <RadioGroup
          @value={{this.color}}
          @onChange={{this.setColor}}
          @name="color"
          aria-describedby={{fc.captionId}}
        >
          <Radio @value="red">Red</Radio>
          <Radio @value="green">Green</Radio>
          <Radio @value="blue">Blue</Radio>
        </RadioGroup>
      </FormControl>
    </div>

    {{!-- ───────────────────────────────────────────────────────────────────── --}}
    {{!-- Counter - mirrors form-control-with-counter.scenario.tsx              --}}
    {{!-- ───────────────────────────────────────────────────────────────────── --}}

    <HeadingMedium style="margin-top:24px">Counter</HeadingMedium>
    <ParagraphSmall>Pass <code>@counter</code> with <code>length</code> (and optionally <code>maxLength</code>). The end enhancer renders <code>length</code> or <code>length/maxLength</code> automatically and turns red on overflow. <strong>Note:</strong> unlike React, we can't read the child input's value - pass it explicitly.</ParagraphSmall>

    <div style="max-width:480px;display:flex;flex-direction:column;gap:0;margin-top:8px">
      <FormControl
        @label="Enable counter"
        @caption="Input caption"
        @counter={{hash length=this.counterValue.length}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.counterValue}}
          @onChange={{this.setCounterValue}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Counter with max value"
        @caption="Input caption"
        @counter={{hash length=this.counterMaxedValue.length maxLength=40}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.counterMaxedValue}}
          @maxLength={{40}}
          @onChange={{this.setCounterMaxed}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Counter with textarea"
        @caption="Input caption"
        @counter={{hash length=this.counterTextarea.length maxLength=40}}
        as |fc|
      >
        <Textarea
          id={{fc.controlId}}
          @value={{this.counterTextarea}}
          @maxLength={{40}}
          @onChange={{this.setCounterTextarea}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>

      <FormControl
        @label="Override counter with max length (visual cap differs from native maxlength)"
        @caption="Input caption"
        @counter={{hash length=this.counterMaxedValue.length maxLength=100}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @size="compact"
          @value={{this.counterMaxedValue}}
          @maxLength={{50}}
          @onChange={{this.setCounterMaxed}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>
    </div>

    {{!-- ───────────────────────────────────────────────────────────────────── --}}
    {{!-- Realistic flows                                                       --}}
    {{!-- ───────────────────────────────────────────────────────────────────── --}}

    <HeadingMedium style="margin-top:24px">Validated email (live error)</HeadingMedium>
    <ParagraphSmall>Touch the field, then leave it empty or without a "@" to see the error swap in. Demonstrates wiring <code>aria-errormessage</code>.</ParagraphSmall>
    <div style="max-width:360px;margin-top:8px">
      <FormControl
        @label="Email"
        @caption="We'll never share your email."
        @error={{this.emailError}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @value={{this.email}}
          @onChange={{this.setEmail}}
          @onBlur={{this.blurEmail}}
          @placeholder="ada@lovelace.dev"
          @disabled={{fc.disabled}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
          aria-errormessage={{fc.errorMessageId}}
        />
      </FormControl>
    </div>

    <HeadingMedium style="margin-top:24px">Live positive feedback</HeadingMedium>
    <div style="max-width:360px;margin-top:8px">
      <FormControl
        @label="Username"
        @positive={{this.usernamePositive}}
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @value={{this.username}}
          @onChange={{this.setUsername}}
          @positive={{fc.isPositive}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>
    </div>

    <HeadingMedium style="margin-top:24px">Bio with counter and overflow</HeadingMedium>
    <div style="max-width:360px;margin-top:8px">
      <FormControl
        @label="Bio"
        @caption="Tell us about yourself in 140 characters or less."
        @counter={{hash length=this.bio.length maxLength=140}}
        as |fc|
      >
        <Textarea
          id={{fc.controlId}}
          @value={{this.bio}}
          @onChange={{this.setBio}}
          @maxLength={{200}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>
    </div>

    <HeadingMedium style="margin-top:24px">Custom labelEndEnhancer</HeadingMedium>
    <ParagraphSmall>Plain string when you want full control instead of a counter.</ParagraphSmall>
    <div style="max-width:360px;margin-top:8px">
      <FormControl
        @label="Password"
        @labelEndEnhancer="Required"
        @caption="At least 8 characters."
        as |fc|
      >
        <Input
          id={{fc.controlId}}
          @type="password"
          @value=""
          aria-describedby={{fc.captionId}}
        />
      </FormControl>
    </div>

    <HeadingSmall style="margin-top:24px">Yielded state</HeadingSmall>
    <pre style="background:#f3f3f3;padding:12px;border-radius:8px;overflow:auto;font-size:12px"><code>fc.controlId       string  // matches `for` on the label
fc.disabled        boolean // forwarded
fc.isError         boolean // truthy when @error is set or counter overflows
fc.isPositive      boolean // truthy when @positive is set and no @error
fc.captionId       string  // for aria-describedby
fc.errorMessageId  string? // for aria-errormessage; null unless error</code></pre>

    <HeadingMedium style="margin-top:24px">Submit form</HeadingMedium>
    <form
      style="max-width:360px;margin-top:8px;display:flex;flex-direction:column;gap:8px"
      {{on "submit" this.preventSubmit}}
    >
      <FormControl
        @label="Comment"
        @counter={{hash length=this.counterValue.length maxLength=80}}
        as |fc|
      >
        <Textarea
          id={{fc.controlId}}
          @value={{this.counterValue}}
          @onChange={{this.setCounterValue}}
          @error={{fc.isError}}
          aria-describedby={{fc.captionId}}
        />
      </FormControl>
      <Button @type="submit" @kind="primary">Submit</Button>
    </form>
  </template>
}

export default FormControlDemo;
