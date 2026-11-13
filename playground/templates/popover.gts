import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '../../src/components/button/index.gts';
import StatefulPopover, { Popover } from '../../src/components/popover/index.gts';
import {
  HeadingMedium,
  HeadingXLarge,
  ParagraphSmall,
  ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class PopoverDemo extends Component {
  @tracked controlledOpen = false;
  @tracked lastEvent = '';

  openControlled = () => { this.controlledOpen = true; };
  closeControlled = () => { this.controlledOpen = false; };
  toggleControlled = () => { this.controlledOpen = !this.controlledOpen; };

  handleClickOutside = () => {
    this.controlledOpen = false;
    this.lastEvent = 'onClickOutside';
  };

  handleEsc = () => {
    this.controlledOpen = false;
    this.lastEvent = 'onEsc';
  };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Popover</HeadingXLarge>
      <ParagraphSmall>An overlay anchored to a trigger element. Supports controlled and stateful variants, placements, arrow, focus management, and hover trigger.</ParagraphSmall>
    </div>

    {{! ─── Stateful (basic) ──────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Stateful (basic click)</HeadingMedium>
      <ParagraphSmall>Click the button to toggle. Click outside or press Escape to dismiss.</ParagraphSmall>
      <div style="margin-top:16px">
        <StatefulPopover>
          <:trigger as |pop|>
            <Button @kind="primary" {{pop.anchor}}>Click me</Button>
          </:trigger>
          <:content>
            <div style="padding:16px;max-width:240px">
              <ParagraphSmall>Hello from the popover!</ParagraphSmall>
            </div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    {{! ─── Placements ────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Placements</HeadingMedium>
      <ParagraphSmall>Various placement positions relative to the trigger.</ParagraphSmall>
      <div style="margin-top:16px;display:flex;flex-wrap:wrap;gap:8px">
        <StatefulPopover @placement="top">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>top</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: top</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
        <StatefulPopover @placement="topLeft">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>topLeft</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: topLeft</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
        <StatefulPopover @placement="bottom">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>bottom</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: bottom</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
        <StatefulPopover @placement="bottomLeft">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>bottomLeft</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: bottomLeft</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
        <StatefulPopover @placement="left">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>left</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: left</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
        <StatefulPopover @placement="right">
          <:trigger as |pop|>
            <Button @kind="secondary" @size="small" {{pop.anchor}}>right</Button>
          </:trigger>
          <:content>
            <div style="padding:12px"><ParagraphXSmall>Placement: right</ParagraphXSmall></div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    {{! ─── With arrow ────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>With arrow</HeadingMedium>
      <div style="margin-top:16px">
        <StatefulPopover @showArrow={{true}} @placement="bottom">
          <:trigger as |pop|>
            <Button @kind="secondary" {{pop.anchor}}>Show arrow</Button>
          </:trigger>
          <:content>
            <div style="padding:16px">
              <ParagraphSmall>This popover has an arrow pointing at the trigger.</ParagraphSmall>
            </div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    {{! ─── Hover trigger ─────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Hover trigger</HeadingMedium>
      <ParagraphSmall>Opens on mouseenter, closes on mouseleave (with 200ms delays).</ParagraphSmall>
      <div style="margin-top:16px">
        <StatefulPopover @triggerType="hover" @accessibilityType="tooltip">
          <:trigger as |pop|>
            <Button @kind="secondary" {{pop.anchor}}>Hover me</Button>
          </:trigger>
          <:content>
            <div style="padding:12px">
              <ParagraphSmall>Tooltip-style popover</ParagraphSmall>
            </div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    {{! ─── Controlled ────────────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Controlled</HeadingMedium>
      <ParagraphSmall>External state drives open/close. Reports dismissal via <code>onClickOutside</code> / <code>onEsc</code>.</ParagraphSmall>
      <div style="margin-top:16px">
        <Popover @isOpen={{this.controlledOpen}} @onClickOutside={{this.handleClickOutside}} @onEsc={{this.handleEsc}}>
          <:trigger as |pop|>
            <Button @kind="primary" {{pop.anchor}} {{on "click" this.toggleControlled}}>Controlled toggle</Button>
          </:trigger>
          <:content>
            <div style="padding:16px;max-width:240px">
              <ParagraphSmall>Controlled popover content.</ParagraphSmall>
              <Button @kind="tertiary" @size="small" {{on "click" this.closeControlled}} style="margin-top:8px">Close from inside</Button>
            </div>
          </:content>
        </Popover>
        <ParagraphXSmall style="margin-top:8px">isOpen: {{if this.controlledOpen "true" "false"}} - Last event: {{if this.lastEvent this.lastEvent "(none)"}}</ParagraphXSmall>
      </div>
    </div>

    {{! ─── Focus management ──────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Focus management</HeadingMedium>
      <ParagraphSmall><code>@autoFocus</code>, <code>@focusLock</code>, and <code>@returnFocus</code> for accessible overlays.</ParagraphSmall>
      <div style="margin-top:16px">
        <StatefulPopover @autoFocus={{true}} @focusLock={{true}} @returnFocus={{true}}>
          <:trigger as |pop|>
            <Button @kind="secondary" {{pop.anchor}}>Open with focus trap</Button>
          </:trigger>
          <:content as |pop|>
            <div style="padding:16px;max-width:280px">
              <ParagraphSmall>Tab is confined to this content. Press Escape or click outside to dismiss.</ParagraphSmall>
              <div style="margin-top:12px;display:flex;gap:8px">
                <Button @kind="tertiary" @size="small" {{on "click" pop.close}}>Cancel</Button>
                <Button @kind="primary" @size="small" {{on "click" pop.close}}>Confirm</Button>
              </div>
            </div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    {{! ─── Non-dismissable ───────────────────────────────────────────────────── }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Non-dismissable</HeadingMedium>
      <ParagraphSmall><code>@dismissOnClickOutside={{"{{"}}false{{"}}"}}</code> and <code>@dismissOnEsc={{"{{"}}false{{"}}"}}</code> - only the close button works.</ParagraphSmall>
      <div style="margin-top:16px">
        <StatefulPopover @dismissOnClickOutside={{false}} @dismissOnEsc={{false}}>
          <:trigger as |pop|>
            <Button @kind="secondary" {{pop.anchor}}>Sticky popover</Button>
          </:trigger>
          <:content as |pop|>
            <div style="padding:16px;max-width:240px">
              <ParagraphSmall>You can only close me with the button below.</ParagraphSmall>
              <Button @kind="primary" @size="small" {{on "click" pop.close}} style="margin-top:8px">Close</Button>
            </div>
          </:content>
        </StatefulPopover>
      </div>
    </div>

    <ParagraphXSmall style="margin-top:32px;color:#727272">Built on ember-basic-dropdown. Content is portaled to the document body.</ParagraphXSmall>
  </template>
}

export default PopoverDemo;
