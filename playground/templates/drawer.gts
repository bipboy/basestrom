import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '../../src/components/button/index.gts';
import Drawer from '../../src/components/drawer/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class DrawerDemo extends Component {
  @tracked showRight = false;
  @tracked showLeft = false;
  @tracked showTop = false;
  @tracked showBottom = false;
  @tracked showFull = false;
  @tracked showNoBackdrop = false;
  @tracked showNoClose = false;
  @tracked showNoAnimate = false;

  openRight = () => { this.showRight = true; };
  openLeft = () => { this.showLeft = true; };
  openTop = () => { this.showTop = true; };
  openBottom = () => { this.showBottom = true; };
  openFull = () => { this.showFull = true; };
  openNoBackdrop = () => { this.showNoBackdrop = true; };
  openNoClose = () => { this.showNoClose = true; };
  openNoAnimate = () => { this.showNoAnimate = true; };

  close = () => {
    this.showRight = false;
    this.showLeft = false;
    this.showTop = false;
    this.showBottom = false;
    this.showFull = false;
    this.showNoBackdrop = false;
    this.showNoClose = false;
    this.showNoAnimate = false;
  };

  <template>
    <HeadingXLarge>Drawer</HeadingXLarge>
    <ParagraphSmall>A sliding panel that overlays from any edge. Supports animated transitions, backdrop, focus trap, Escape-to-close.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Anchors</HeadingMedium>
    <div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:8px">
      <Button @kind="secondary" {{on "click" this.openRight}}>Right (default)</Button>
      <Button @kind="secondary" {{on "click" this.openLeft}}>Left</Button>
      <Button @kind="secondary" {{on "click" this.openTop}}>Top</Button>
      <Button @kind="secondary" {{on "click" this.openBottom}}>Bottom</Button>
    </div>

    <Drawer @isOpen={{this.showRight}} @onClose={{this.close}} @anchor="right">
      <ParagraphSmall>Drawer from the right (default). 500px width.</ParagraphSmall>
    </Drawer>

    <Drawer @isOpen={{this.showLeft}} @onClose={{this.close}} @anchor="left">
      <ParagraphSmall>Drawer from the left. 500px width.</ParagraphSmall>
    </Drawer>

    <Drawer @isOpen={{this.showTop}} @onClose={{this.close}} @anchor="top">
      <ParagraphSmall>Drawer from the top. 500px height.</ParagraphSmall>
    </Drawer>

    <Drawer @isOpen={{this.showBottom}} @onClose={{this.close}} @anchor="bottom">
      <ParagraphSmall>Drawer from the bottom. 500px height.</ParagraphSmall>
    </Drawer>

    <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
    <div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:8px">
      <Button @kind="secondary" {{on "click" this.openRight}}>Default (500px)</Button>
      <Button @kind="secondary" {{on "click" this.openFull}}>Full (100%)</Button>
    </div>

    <Drawer @isOpen={{this.showFull}} @onClose={{this.close}} @size="full">
      <ParagraphSmall>Full-width drawer.</ParagraphSmall>
      <Button @kind="primary" {{on "click" this.close}} style="margin-top:16px">Close</Button>
    </Drawer>

    <HeadingMedium style="margin-top:24px">Options</HeadingMedium>
    <div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:8px">
      <Button @kind="secondary" {{on "click" this.openNoBackdrop}}>No Backdrop</Button>
      <Button @kind="secondary" {{on "click" this.openNoClose}}>No Close Button</Button>
      <Button @kind="secondary" {{on "click" this.openNoAnimate}}>No Animation</Button>
    </div>

    <Drawer @isOpen={{this.showNoBackdrop}} @onClose={{this.close}} @showBackdrop={{false}}>
      <ParagraphSmall>No backdrop overlay. Background remains interactive.</ParagraphSmall>
      <Button @kind="primary" {{on "click" this.close}} style="margin-top:16px">Close</Button>
    </Drawer>

    <Drawer @isOpen={{this.showNoClose}} @onClose={{this.close}} @closeable={{false}}>
      <ParagraphSmall>No close button and not closeable via Escape/backdrop. Must close programmatically.</ParagraphSmall>
      <Button @kind="primary" {{on "click" this.close}} style="margin-top:16px">Close</Button>
    </Drawer>

    <Drawer @isOpen={{this.showNoAnimate}} @onClose={{this.close}} @animate={{false}}>
      <ParagraphSmall>Instant open/close - no CSS transitions.</ParagraphSmall>
    </Drawer>
  </template>
}

export default DrawerDemo;
