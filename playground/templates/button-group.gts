import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import ButtonGroup, { StatefulButtonGroup } from '../../src/components/button-group/index.gts';
import Divider from '../../src/components/divider/index.gts';
import {
  ChevronRight as IconChevronRight,
  Plus as IconPlus,
  Search as IconSearch,
  TrashCanFilled as IconTrashCanFilled,
} from '../../src/components/icon/glyphs.gts';
import { HeadingMedium, HeadingSmall, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class ButtonGroupPlayground extends Component {
  @tracked radioSelected: number = 0;
  @tracked checkboxSelected: number[] = [0, 2];

  get checkboxSelectedText(): string {
    return this.checkboxSelected.join(', ');
  }

  handleRadioClick = (_event: MouseEvent | KeyboardEvent, index: number) => {
    this.radioSelected = index;
  };

  handleCheckboxClick = (_event: MouseEvent | KeyboardEvent, index: number) => {
    if (this.checkboxSelected.includes(index)) {
      this.checkboxSelected = this.checkboxSelected.filter((i) => i !== index);
    } else {
      this.checkboxSelected = [...this.checkboxSelected, index];
    }
  };

  <template>
    <HeadingXLarge>ButtonGroup</HeadingXLarge>
    <ParagraphSmall>Groups buttons with coordinated selection state, keyboard navigation, and propagated styling.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Radio Mode (single selection)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Selected: {{this.radioSelected}}</ParagraphXSmall>
    <ButtonGroup
      @mode="radio"
      @selected={{this.radioSelected}}
      @onClick={{this.handleRadioClick}}
      @kind="secondary"
      @size="medium"
      as |group|
    >
      <group.Button>Option A</group.Button>
      <group.Button>Option B</group.Button>
      <group.Button>Option C</group.Button>
    </ButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>Checkbox Mode (multi-selection)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Selected: {{this.checkboxSelectedText}}</ParagraphXSmall>
    <ButtonGroup
      @mode="checkbox"
      @selected={{this.checkboxSelected}}
      @onClick={{this.handleCheckboxClick}}
      @kind="secondary"
      @size="medium"
      as |group|
    >
      <group.Button>Bold</group.Button>
      <group.Button>Italic</group.Button>
      <group.Button>Underline</group.Button>
    </ButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>Simple Clickable Group (no mode)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">No selection state - just visually grouped buttons.</ParagraphXSmall>
    <ButtonGroup @kind="tertiary" @size="small" as |group|>
      <group.Button>Action A</group.Button>
      <group.Button>Action B</group.Button>
      <group.Button>Action C</group.Button>
    </ButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>Kinds</HeadingMedium>

    <HeadingSmall style="margin-top:16px">Primary</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{0}} @kind="primary" as |group|>
      <group.Button>One</group.Button>
      <group.Button>Two</group.Button>
      <group.Button>Three</group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Secondary</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{1}} @kind="secondary" as |group|>
      <group.Button>One</group.Button>
      <group.Button>Two</group.Button>
      <group.Button>Three</group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Tertiary</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{2}} @kind="tertiary" as |group|>
      <group.Button>One</group.Button>
      <group.Button>Two</group.Button>
      <group.Button>Three</group.Button>
    </ButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>Sizes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px">
      <div>
        <ParagraphXSmall>xSmall</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @size="xSmall" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>small</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @size="small" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>medium</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @size="medium" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>large</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @size="large" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
    </div>

    <Divider @size="section" />

    <HeadingMedium>Shapes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px">
      <div>
        <ParagraphXSmall>default</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @shape="default" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>pill</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @shape="pill" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
          <group.Button>C</group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>circle</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @shape="circle" as |group|>
          <group.Button>1</group.Button>
          <group.Button>2</group.Button>
          <group.Button>3</group.Button>
        </ButtonGroup>
      </div>
    </div>

    <Divider @size="section" />

    <HeadingMedium>Disabled</HeadingMedium>
    <ButtonGroup @mode="radio" @selected={{1}} @disabled={{true}} as |group|>
      <group.Button>One</group.Button>
      <group.Button>Two</group.Button>
      <group.Button>Three</group.Button>
    </ButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>Wrap</HeadingMedium>
    <HeadingSmall style="margin-top:16px">wrap=true (wraps to next line)</HeadingSmall>
    <div style="max-width:300px;border:1px dashed #ccc;padding:8px">
      <ButtonGroup @mode="checkbox" @selected={{this.checkboxSelected}} @wrap={{true}} as |group|>
        <group.Button>Alpha</group.Button>
        <group.Button>Beta</group.Button>
        <group.Button>Gamma</group.Button>
        <group.Button>Delta</group.Button>
        <group.Button>Epsilon</group.Button>
      </ButtonGroup>
    </div>

    <HeadingSmall style="margin-top:16px">wrap=false (horizontal scroll)</HeadingSmall>
    <div style="max-width:300px;border:1px dashed #ccc;padding:8px">
      <ButtonGroup @mode="checkbox" @selected={{this.checkboxSelected}} @wrap={{false}} as |group|>
        <group.Button>Alpha</group.Button>
        <group.Button>Beta</group.Button>
        <group.Button>Gamma</group.Button>
        <group.Button>Delta</group.Button>
        <group.Button>Epsilon</group.Button>
      </ButtonGroup>
    </div>

    <Divider @size="section" />

    <HeadingMedium>Padding</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px">
      <div style="border:1px dashed #ccc">
        <ParagraphXSmall style="padding:4px 8px">padding="none"</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @padding="none" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
        </ButtonGroup>
      </div>
      <div style="border:1px dashed #ccc">
        <ParagraphXSmall style="padding:4px 8px">padding="default"</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @padding="default" as |group|>
          <group.Button>A</group.Button>
          <group.Button>B</group.Button>
        </ButtonGroup>
      </div>
    </div>

    <Divider @size="section" />

    <HeadingMedium>StatefulButtonGroup (radio)</HeadingMedium>
    <ParagraphXSmall style="margin-bottom:8px">Manages selection state internally.</ParagraphXSmall>
    <StatefulButtonGroup @mode="radio" @kind="secondary" as |group|>
      <group.Button>First</group.Button>
      <group.Button>Second</group.Button>
      <group.Button>Third</group.Button>
    </StatefulButtonGroup>

    <HeadingSmall style="margin-top:16px">StatefulButtonGroup (checkbox)</HeadingSmall>
    <StatefulButtonGroup @mode="checkbox" @kind="secondary" as |group|>
      <group.Button>Bold</group.Button>
      <group.Button>Italic</group.Button>
      <group.Button>Underline</group.Button>
      <group.Button>Strikethrough</group.Button>
    </StatefulButtonGroup>

    <Divider @size="section" />

    <HeadingMedium>With Enhancers</HeadingMedium>

    <HeadingSmall style="margin-top:16px">Icon only (no text)</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @shape="square" as |group|>
      <group.Button>
        <:default><IconSearch @size="16px" /></:default>
      </group.Button>
      <group.Button>
        <:default><IconPlus @size="16px" /></:default>
      </group.Button>
      <group.Button>
        <:default><IconTrashCanFilled @size="16px" /></:default>
      </group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Start enhancer + text</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" as |group|>
      <group.Button>
        <:startEnhancer><IconSearch @size="16px" /></:startEnhancer>
        <:default>Search</:default>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconPlus @size="16px" /></:startEnhancer>
        <:default>Add</:default>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconTrashCanFilled @size="16px" /></:startEnhancer>
        <:default>Delete</:default>
      </group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Text + end enhancer</HeadingSmall>
    <ButtonGroup @mode="checkbox" @selected={{this.checkboxSelected}} @onClick={{this.handleCheckboxClick}} @kind="secondary" as |group|>
      <group.Button>
        <:default>Upload</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
      <group.Button>
        <:default>Download</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
      <group.Button>
        <:default>Share</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Both enhancers (start + end)</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{1}} @kind="primary" as |group|>
      <group.Button>
        <:startEnhancer><IconSearch @size="16px" /></:startEnhancer>
        <:default>Find</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconPlus @size="16px" /></:startEnhancer>
        <:default>Create</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconTrashCanFilled @size="16px" /></:startEnhancer>
        <:default>Remove</:default>
        <:endEnhancer><IconChevronRight @size="16px" /></:endEnhancer>
      </group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Pill shape with icon + text</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @shape="pill" as |group|>
      <group.Button>
        <:startEnhancer><IconSearch @size="14px" /></:startEnhancer>
        <:default>Search</:default>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconPlus @size="14px" /></:startEnhancer>
        <:default>New</:default>
      </group.Button>
    </ButtonGroup>

    <HeadingSmall style="margin-top:16px">Sizes with enhancers</HeadingSmall>
    <div style="display:flex;flex-direction:column;gap:12px">
      <div>
        <ParagraphXSmall>xSmall</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @size="xSmall" as |group|>
          <group.Button>
            <:startEnhancer><IconPlus @size="12px" /></:startEnhancer>
            <:default>Add</:default>
          </group.Button>
          <group.Button>
            <:startEnhancer><IconSearch @size="12px" /></:startEnhancer>
            <:default>Find</:default>
          </group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>small</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @size="small" as |group|>
          <group.Button>
            <:startEnhancer><IconPlus @size="14px" /></:startEnhancer>
            <:default>Add</:default>
          </group.Button>
          <group.Button>
            <:startEnhancer><IconSearch @size="14px" /></:startEnhancer>
            <:default>Find</:default>
          </group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>medium</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @size="medium" as |group|>
          <group.Button>
            <:startEnhancer><IconPlus @size="16px" /></:startEnhancer>
            <:default>Add</:default>
          </group.Button>
          <group.Button>
            <:startEnhancer><IconSearch @size="16px" /></:startEnhancer>
            <:default>Find</:default>
          </group.Button>
        </ButtonGroup>
      </div>
      <div>
        <ParagraphXSmall>large</ParagraphXSmall>
        <ButtonGroup @mode="radio" @selected={{0}} @kind="secondary" @size="large" as |group|>
          <group.Button>
            <:startEnhancer><IconPlus @size="20px" /></:startEnhancer>
            <:default>Add</:default>
          </group.Button>
          <group.Button>
            <:startEnhancer><IconSearch @size="20px" /></:startEnhancer>
            <:default>Find</:default>
          </group.Button>
        </ButtonGroup>
      </div>
    </div>

    <HeadingSmall style="margin-top:16px">Disabled with enhancers</HeadingSmall>
    <ButtonGroup @mode="radio" @selected={{1}} @kind="secondary" @disabled={{true}} as |group|>
      <group.Button>
        <:startEnhancer><IconSearch @size="16px" /></:startEnhancer>
        <:default>Search</:default>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconPlus @size="16px" /></:startEnhancer>
        <:default>Add</:default>
      </group.Button>
      <group.Button>
        <:startEnhancer><IconTrashCanFilled @size="16px" /></:startEnhancer>
        <:default>Delete</:default>
      </group.Button>
    </ButtonGroup>
  </template>
}

export default ButtonGroupPlayground;
