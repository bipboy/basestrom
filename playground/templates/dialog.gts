import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import ButtonDock from '../../src/components/button-dock/index.gts';
import Button from '../../src/components/button/index.gts';
import Dialog from '../../src/components/dialog/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class DialogDemo extends Component {
  @tracked showBasic = false;
  @tracked showArtwork = false;
  @tracked showButtonDock = false;
  @tracked showSmall = false;
  @tracked showMedium = false;
  @tracked showLarge = false;
  @tracked showTopLeft = false;
  @tracked showTopCenter = false;
  @tracked showTopRight = false;
  @tracked showBottomLeft = false;
  @tracked showBottomRight = false;
  @tracked showNoOverlay = false;
  @tracked showNoDismiss = false;

  toggleBasic = () => { this.showBasic = !this.showBasic; };
  toggleArtwork = () => { this.showArtwork = !this.showArtwork; };
  toggleButtonDock = () => { this.showButtonDock = !this.showButtonDock; };
  toggleSmall = () => { this.showSmall = !this.showSmall; };
  toggleMedium = () => { this.showMedium = !this.showMedium; };
  toggleLarge = () => { this.showLarge = !this.showLarge; };
  toggleTopLeft = () => { this.showTopLeft = !this.showTopLeft; };
  toggleTopCenter = () => { this.showTopCenter = !this.showTopCenter; };
  toggleTopRight = () => { this.showTopRight = !this.showTopRight; };
  toggleBottomLeft = () => { this.showBottomLeft = !this.showBottomLeft; };
  toggleBottomRight = () => { this.showBottomRight = !this.showBottomRight; };
  toggleNoOverlay = () => { this.showNoOverlay = !this.showNoOverlay; };
  toggleNoDismiss = () => { this.showNoDismiss = !this.showNoDismiss; };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Dialog</HeadingXLarge>
      <ParagraphSmall>A fixed-position overlay panel for focused tasks and confirmations.</ParagraphSmall>
    </div>

    {{! Basic (center) }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Basic (center)</HeadingMedium>
      <div style="margin-top:16px">
        <Button @kind="primary" {{on "click" this.toggleBasic}}>Open Basic Dialog</Button>
      </div>
      <Dialog
        @isOpen={{this.showBasic}}
        @heading="Basic Dialog"
        @onDismiss={{this.toggleBasic}}
      >
        This is a basic dialog with default settings. It uses center placement and xSmall size.
      </Dialog>
    </div>

    {{! With Artwork }}
    <div style="margin-bottom:32px">
      <HeadingMedium>With Artwork</HeadingMedium>
      <div style="margin-top:16px">
        <Button @kind="primary" {{on "click" this.toggleArtwork}}>Open with Artwork</Button>
      </div>
      <Dialog
        @isOpen={{this.showArtwork}}
        @heading="Upload Complete"
        @onDismiss={{this.toggleArtwork}}
      >
        <:artwork>
          <svg width="80" height="80" viewBox="0 0 80 80" fill="none">
            <circle cx="40" cy="40" r="40" fill="#EAF6ED"/>
            <path d="M35 42l5 5 10-10" stroke="#0E8345" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </:artwork>
        <:default>
          Your file has been uploaded successfully. You can find it in the documents folder.
        </:default>
      </Dialog>
    </div>

    {{! With ButtonDock }}
    <div style="margin-bottom:32px">
      <HeadingMedium>With ButtonDock</HeadingMedium>
      <div style="margin-top:16px">
        <Button @kind="primary" {{on "click" this.toggleButtonDock}}>Open with ButtonDock</Button>
      </div>
      <Dialog
        @isOpen={{this.showButtonDock}}
        @heading="Delete Item?"
        @onDismiss={{this.toggleButtonDock}}
      >
        <:default>
          Are you sure you want to delete this item? This action cannot be undone.
        </:default>
        <:buttonDock>
          <ButtonDock>
            <:primaryAction>
              <Button @kind="dangerPrimary" {{on "click" this.toggleButtonDock}}>Delete</Button>
            </:primaryAction>
            <:dismissiveAction>
              <Button @kind="secondary" {{on "click" this.toggleButtonDock}}>Cancel</Button>
            </:dismissiveAction>
          </ButtonDock>
        </:buttonDock>
      </Dialog>
    </div>

    {{! Sizes }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Sizes</HeadingMedium>
      <div style="margin-top:16px;display:flex;gap:8px;flex-wrap:wrap">
        <Button @kind="secondary" {{on "click" this.toggleSmall}}>Small (640px)</Button>
        <Button @kind="secondary" {{on "click" this.toggleMedium}}>Medium (800px)</Button>
        <Button @kind="secondary" {{on "click" this.toggleLarge}}>Large (100%)</Button>
      </div>
      <Dialog @isOpen={{this.showSmall}} @heading="Small Dialog" @size="small" @onDismiss={{this.toggleSmall}}>
        This dialog has a small (640px) width.
      </Dialog>
      <Dialog @isOpen={{this.showMedium}} @heading="Medium Dialog" @size="medium" @onDismiss={{this.toggleMedium}}>
        This dialog has a medium (800px) width.
      </Dialog>
      <Dialog @isOpen={{this.showLarge}} @heading="Large Dialog" @size="large" @onDismiss={{this.toggleLarge}}>
        This dialog has a large (100%) width.
      </Dialog>
    </div>

    {{! Placements }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Placements</HeadingMedium>
      <div style="margin-top:16px;display:flex;gap:8px;flex-wrap:wrap">
        <Button @kind="secondary" {{on "click" this.toggleTopLeft}}>Top Left</Button>
        <Button @kind="secondary" {{on "click" this.toggleTopCenter}}>Top Center</Button>
        <Button @kind="secondary" {{on "click" this.toggleTopRight}}>Top Right</Button>
        <Button @kind="secondary" {{on "click" this.toggleBottomLeft}}>Bottom Left</Button>
        <Button @kind="secondary" {{on "click" this.toggleBottomRight}}>Bottom Right</Button>
      </div>
      <Dialog @isOpen={{this.showTopLeft}} @heading="Top Left" @placement="topLeft" @onDismiss={{this.toggleTopLeft}}>
        Placed at topLeft.
      </Dialog>
      <Dialog @isOpen={{this.showTopCenter}} @heading="Top Center" @placement="topCenter" @onDismiss={{this.toggleTopCenter}}>
        Placed at topCenter.
      </Dialog>
      <Dialog @isOpen={{this.showTopRight}} @heading="Top Right" @placement="topRight" @onDismiss={{this.toggleTopRight}}>
        Placed at topRight.
      </Dialog>
      <Dialog @isOpen={{this.showBottomLeft}} @heading="Bottom Left" @placement="bottomLeft" @onDismiss={{this.toggleBottomLeft}}>
        Placed at bottomLeft.
      </Dialog>
      <Dialog @isOpen={{this.showBottomRight}} @heading="Bottom Right" @placement="bottomRight" @onDismiss={{this.toggleBottomRight}}>
        Placed at bottomRight.
      </Dialog>
    </div>

    {{! Without Overlay }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Without Overlay</HeadingMedium>
      <div style="margin-top:16px">
        <Button @kind="secondary" {{on "click" this.toggleNoOverlay}}>Open without Overlay</Button>
      </div>
      <Dialog
        @isOpen={{this.showNoOverlay}}
        @heading="No Overlay"
        @hasOverlay={{false}}
        @onDismiss={{this.toggleNoOverlay}}
      >
        This dialog has no overlay backdrop. The background is still interactive.
      </Dialog>
    </div>

    {{! Without Dismiss Button }}
    <div style="margin-bottom:32px">
      <HeadingMedium>Without Dismiss Button</HeadingMedium>
      <div style="margin-top:16px">
        <Button @kind="secondary" {{on "click" this.toggleNoDismiss}}>Open without Dismiss</Button>
      </div>
      <Dialog
        @isOpen={{this.showNoDismiss}}
        @heading="No Dismiss Button"
        @showDismissButton={{false}}
        @onDismiss={{this.toggleNoDismiss}}
      >
        <:default>
          This dialog has no X button. Use the button below or press Escape to close.
        </:default>
        <:buttonDock>
          <ButtonDock>
            <:primaryAction>
              <Button @kind="primary" {{on "click" this.toggleNoDismiss}}>Got it</Button>
            </:primaryAction>
          </ButtonDock>
        </:buttonDock>
      </Dialog>
    </div>
  </template>
}

export default DialogDemo;
