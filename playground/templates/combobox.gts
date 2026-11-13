import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Combobox from '../../src/components/combobox/index.gts';
import { Search as IconSearch } from '../../src/components/icon/glyphs.gts';
import {
  HeadingMedium,
  HeadingXLarge,
  ParagraphSmall,
  ParagraphXSmall,
} from '../../src/components/typography/index.gts';

// ─── Custom option node for the "Custom rendering" demo ─────────────────────────

import type { TemplateOnlyComponent } from '@ember/component/template-only';

interface FruitOptionSig {
  Args: { option: string; isSelected: boolean };
}

const FruitOption: TemplateOnlyComponent<FruitOptionSig> = <template>
  <span style="display:flex;align-items:center;gap:8px">
    {{#if @isSelected}}✓{{else}}•{{/if}}
    <strong>{{@option}}</strong>
  </span>
</template>;

// ─── Demo ───────────────────────────────────────────────────────────────────────

class ComboboxDemo extends Component {
  @tracked basicValue = '';
  @tracked controlledValue = '';
  @tracked disabledValue = 'Cannot edit';
  @tracked sizeValue = '';
  @tracked customValue = '';
  @tracked submitValue = '';
  @tracked lastSubmit = '';
  @tracked lastSelected: string | null = null;

  fruits = ['Apple', 'Banana', 'Blueberry', 'Cherry', 'Grape', 'Lemon', 'Mango', 'Orange', 'Pear', 'Pineapple', 'Strawberry', 'Watermelon'];
  cities = ['Amsterdam', 'Berlin', 'Chicago', 'Dubai', 'Edinburgh', 'Florence', 'Geneva', 'Helsinki', 'Istanbul', 'Jakarta'];

  mapOptionToString = (option: string) => option;

  handleBasicChange = (value: string, option: string | null) => {
    this.basicValue = value;
    this.lastSelected = option;
  };

  handleControlledChange = (value: string, _option: string | null) => {
    this.controlledValue = value;
  };

  handleSizeChange = (value: string, _option: string | null) => {
    this.sizeValue = value;
  };

  handleCustomChange = (value: string, _option: string | null) => {
    this.customValue = value;
  };

  handleSubmitChange = (value: string, _option: string | null) => {
    this.submitValue = value;
  };

  handleSubmit = ({ value }: { closeListbox: () => void; value: string }) => {
    this.lastSubmit = value;
  };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Combobox</HeadingXLarge>
      <ParagraphSmall>A text input paired with a filterable option listbox. Type to filter, arrow keys to navigate, Enter to select.</ParagraphSmall>
    </div>

    {{! ─── Basic ─────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Basic</HeadingMedium>
      <ParagraphSmall>Type to filter fruits. Arrow keys navigate, Enter selects, Escape closes.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.basicValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleBasicChange}}
        />
        <ParagraphXSmall style="margin-top:8px">Value: "{{this.basicValue}}" - Last selected: {{if this.lastSelected this.lastSelected "(none)"}}</ParagraphXSmall>
      </div>
    </div>

    {{! ─── Sizes ─────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Sizes</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Combobox
          @value={{this.sizeValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleSizeChange}}
          @size="mini"
        />
        <Combobox
          @value={{this.sizeValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleSizeChange}}
          @size="compact"
        />
        <Combobox
          @value={{this.sizeValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleSizeChange}}
          @size="default"
        />
        <Combobox
          @value={{this.sizeValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleSizeChange}}
          @size="large"
        />
      </div>
    </div>

    {{! ─── States ────────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>States</HeadingMedium>
      <div style="margin-top:16px;max-width:400px;display:flex;flex-direction:column;gap:12px">
        <Combobox
          @value={{this.controlledValue}}
          @options={{this.cities}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleControlledChange}}
          @error={{true}}
        />
        <Combobox
          @value={{this.controlledValue}}
          @options={{this.cities}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleControlledChange}}
          @positive={{true}}
        />
        <Combobox
          @value={{this.disabledValue}}
          @options={{this.cities}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleControlledChange}}
          @disabled={{true}}
        />
      </div>
    </div>

    {{! ─── Clearable ─────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Clearable</HeadingMedium>
      <ParagraphSmall>The clear button appears when the input has a value.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.controlledValue}}
          @options={{this.cities}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleControlledChange}}
          @clearable={{true}}
        />
      </div>
    </div>

    {{! ─── Custom option rendering ───────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Custom option rendering</HeadingMedium>
      <ParagraphSmall>Using <code>@mapOptionToNode</code> to customize how each option is displayed.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.customValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @mapOptionToNode={{FruitOption}}
          @onChange={{this.handleCustomChange}}
        />
      </div>
    </div>

    {{! ─── onSubmit ──────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>onSubmit (Enter with no selection)</HeadingMedium>
      <ParagraphSmall>Press Enter when no option is highlighted to trigger <code>onSubmit</code>.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.submitValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleSubmitChange}}
          @onSubmit={{this.handleSubmit}}
        />
        <ParagraphXSmall style="margin-top:8px">Last submitted: "{{this.lastSubmit}}"</ParagraphXSmall>
      </div>
    </div>

    {{! ─── Autocomplete disabled ─────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Autocomplete disabled</HeadingMedium>
      <ParagraphSmall>With <code>@autocomplete={{"{{"}}false{{"}}"}}</code> the input does NOT preview the highlighted option.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.basicValue}}
          @options={{this.fruits}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleBasicChange}}
          @autocomplete={{false}}
        />
      </div>
    </div>

    {{! ─── Start enhancer ────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Start enhancer</HeadingMedium>
      <ParagraphSmall>A leading icon via the <code>&lt;:startEnhancer&gt;</code> block (forwarded to the inner Input). Useful for a search-style combobox.</ParagraphSmall>
      <div style="margin-top:16px;max-width:400px">
        <Combobox
          @value={{this.controlledValue}}
          @options={{this.cities}}
          @mapOptionToString={{this.mapOptionToString}}
          @onChange={{this.handleControlledChange}}
        >
          <:startEnhancer><IconSearch @size="16px" /></:startEnhancer>
        </Combobox>
      </div>
    </div>

    <ParagraphXSmall style="margin-top:32px;color:#727272">Built on ember-basic-dropdown. Options filter as you type (case-insensitive substring match).</ParagraphXSmall>
  </template>
}

export default ComboboxDemo;
