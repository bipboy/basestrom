import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { Segment, SegmentedControl } from '../../src/components/segmented-control/index.gts';
import {
    HeadingMedium,
    HeadingXLarge,
    ParagraphSmall,
    ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class SegmentedControlDemo extends Component {
  @tracked basicKey: string | number = 'day';
  @tracked fixedKey: string | number = 'a';
  @tracked badgeKey: string | number = 'inbox';
  @tracked sizeSmallKey: string | number = 'a';
  @tracked sizeMediumKey: string | number = 'a';
  @tracked sizeLargeKey: string | number = 'a';

  setBasic = ({ activeKey }: { activeKey: string | number }) => {
    this.basicKey = activeKey;
  };
  setFixed = ({ activeKey }: { activeKey: string | number }) => {
    this.fixedKey = activeKey;
  };
  setBadge = ({ activeKey }: { activeKey: string | number }) => {
    this.badgeKey = activeKey;
  };
  setSizeSmall = ({ activeKey }: { activeKey: string | number }) => {
    this.sizeSmallKey = activeKey;
  };
  setSizeMedium = ({ activeKey }: { activeKey: string | number }) => {
    this.sizeMediumKey = activeKey;
  };
  setSizeLarge = ({ activeKey }: { activeKey: string | number }) => {
    this.sizeLargeKey = activeKey;
  };

  <template>
    <HeadingXLarge>SegmentedControl</HeadingXLarge>
    <ParagraphSmall>Group of segments where one is active. The active highlight animates between segments.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic (intrinsic width)</HeadingMedium>
    <SegmentedControl @activeKey={{this.basicKey}} @onChange={{this.setBasic}} as |group|>
      <Segment @group={{group}} @key="day" @label="Day" />
      <Segment @group={{group}} @key="week" @label="Week" />
      <Segment @group={{group}} @key="month" @label="Month" />
      <Segment @group={{group}} @key="year" @label="Year" />
    </SegmentedControl>
    <ParagraphXSmall style="margin-top:8px;color:#727272">Active key: {{this.basicKey}}</ParagraphXSmall>

    <HeadingMedium style="margin-top:24px">Fixed fill (equal-width segments)</HeadingMedium>
    <SegmentedControl
      @activeKey={{this.fixedKey}}
      @onChange={{this.setFixed}}
      @fill="fixed"
      @width="400px"
      as |group|
    >
      <Segment @group={{group}} @key="a" @label="Option A" />
      <Segment @group={{group}} @key="b" @label="Option B" />
      <Segment @group={{group}} @key="c" @label="Option C" />
    </SegmentedControl>

    <HeadingMedium style="margin-top:24px">With description and badges</HeadingMedium>
    <SegmentedControl @activeKey={{this.badgeKey}} @onChange={{this.setBadge}} as |group|>
      <Segment @group={{group}} @key="inbox" @label="Inbox" @description="Recent messages" @badge={{12}} />
      <Segment @group={{group}} @key="drafts" @label="Drafts" @badgeHint={{true}} />
      <Segment @group={{group}} @key="sent" @label="Sent" />
    </SegmentedControl>

    <HeadingMedium style="margin-top:24px">Disabled</HeadingMedium>
    <SegmentedControl @activeKey="b" @disabled={{true}} as |group|>
      <Segment @group={{group}} @key="a" @label="Option A" />
      <Segment @group={{group}} @key="b" @label="Option B (active)" />
      <Segment @group={{group}} @key="c" @label="Option C" />
    </SegmentedControl>

    <ParagraphXSmall style="margin-top:16px;color:#727272">Use ArrowLeft/ArrowRight to navigate between segments. By default, focus also activates.</ParagraphXSmall>

    <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
    <ParagraphSmall>Three sizes: small, medium (default), large.</ParagraphSmall>

    <ParagraphXSmall style="margin-top:16px;color:#727272">Small</ParagraphXSmall>
    <SegmentedControl @activeKey={{this.sizeSmallKey}} @onChange={{this.setSizeSmall}} @size="small" as |group|>
      <Segment @group={{group}} @key="a" @label="First" />
      <Segment @group={{group}} @key="b" @label="Second" />
      <Segment @group={{group}} @key="c" @label="Third" />
    </SegmentedControl>

    <ParagraphXSmall style="margin-top:16px;color:#727272">Medium (default)</ParagraphXSmall>
    <SegmentedControl @activeKey={{this.sizeMediumKey}} @onChange={{this.setSizeMedium}} @size="medium" as |group|>
      <Segment @group={{group}} @key="a" @label="First" />
      <Segment @group={{group}} @key="b" @label="Second" />
      <Segment @group={{group}} @key="c" @label="Third" />
    </SegmentedControl>

    <ParagraphXSmall style="margin-top:16px;color:#727272">Large</ParagraphXSmall>
    <SegmentedControl @activeKey={{this.sizeLargeKey}} @onChange={{this.setSizeLarge}} @size="large" as |group|>
      <Segment @group={{group}} @key="a" @label="First" />
      <Segment @group={{group}} @key="b" @label="Second" />
      <Segment @group={{group}} @key="c" @label="Third" />
    </SegmentedControl>
  </template>
}

export default SegmentedControlDemo;
