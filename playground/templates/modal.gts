import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '../../src/components/button/index.gts';
import Modal, { type ModalCloseSource } from '../../src/components/modal/index.gts';
import {
    HeadingMedium,
    HeadingXLarge,
    ParagraphSmall,
    ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class ModalDemo extends Component {
  @tracked basicOpen = false;
  @tracked sizeDefaultOpen = false;
  @tracked sizeAutoOpen = false;
  @tracked sizeFullOpen = false;
  @tracked sizeCustomOpen = false;
  @tracked alertOpen = false;
  @tracked nonCloseableOpen = false;
  @tracked noAnimateOpen = false;
  @tracked lastCloseSource: ModalCloseSource | null = null;

  openBasic = () => { this.basicOpen = true; };
  openSizeDefault = () => { this.sizeDefaultOpen = true; };
  openSizeAuto = () => { this.sizeAutoOpen = true; };
  openSizeFull = () => { this.sizeFullOpen = true; };
  openSizeCustom = () => { this.sizeCustomOpen = true; };
  openAlert = () => { this.alertOpen = true; };
  openNonCloseable = () => { this.nonCloseableOpen = true; };
  openNoAnimate = () => { this.noAnimateOpen = true; };

  closeBasic = ({ closeSource }: { closeSource: ModalCloseSource }) => {
    this.basicOpen = false;
    this.lastCloseSource = closeSource;
  };
  closeBasicAction = () => {
    this.basicOpen = false;
    this.lastCloseSource = 'closeButton';
  };
  closeSizeDefault = () => { this.sizeDefaultOpen = false; };
  closeSizeAuto = () => { this.sizeAutoOpen = false; };
  closeSizeFull = () => { this.sizeFullOpen = false; };
  closeSizeCustom = () => { this.sizeCustomOpen = false; };
  closeAlert = () => { this.alertOpen = false; };
  closeNonCloseable = () => { this.nonCloseableOpen = false; };
  closeNoAnimate = () => { this.noAnimateOpen = false; };

  <template>
    <HeadingXLarge>Modal</HeadingXLarge>
    <ParagraphSmall>A controlled overlay panel with backdrop, focus trap, scroll lock, and named blocks for header, body, footer.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic</HeadingMedium>
    <Button @kind="primary" {{on "click" this.openBasic}}>Open modal</Button>
    {{#if this.lastCloseSource}}
      <ParagraphXSmall style="margin-top:8px;color:#727272">Last close source: <code>{{this.lastCloseSource}}</code></ParagraphXSmall>
    {{/if}}
    <Modal @isOpen={{this.basicOpen}} @onClose={{this.closeBasic}}>
      <:header>Confirm action</:header>
      <:body>
        <ParagraphSmall>Are you sure you want to proceed? This action cannot be undone.</ParagraphSmall>
      </:body>
      <:footer>
        <div style="display:flex;gap:8px;justify-content:flex-end">
          <Button @kind="tertiary" {{on "click" this.closeBasicAction}}>Cancel</Button>
          <Button @kind="primary" {{on "click" this.closeBasicAction}}>Confirm</Button>
        </div>
      </:footer>
    </Modal>

    <HeadingMedium style="margin-top:32px">Sizes</HeadingMedium>
    <ParagraphSmall>Three named sizes plus arbitrary CSS width.</ParagraphSmall>
    <div style="display:flex;gap:8px;flex-wrap:wrap;margin-top:8px">
      <Button @kind="secondary" {{on "click" this.openSizeDefault}}>default (500px)</Button>
      <Button @kind="secondary" {{on "click" this.openSizeAuto}}>auto</Button>
      <Button @kind="secondary" {{on "click" this.openSizeFull}}>full</Button>
      <Button @kind="secondary" {{on "click" this.openSizeCustom}}>custom 720px</Button>
    </div>

    <Modal @isOpen={{this.sizeDefaultOpen}} @onClose={{this.closeSizeDefault}} @size="default">
      <:header>Default size</:header>
      <:body><ParagraphSmall>Width: 500px (the default).</ParagraphSmall></:body>
      <:footer>
        <Button @kind="primary" {{on "click" this.closeSizeDefault}}>Close</Button>
      </:footer>
    </Modal>

    <Modal @isOpen={{this.sizeAutoOpen}} @onClose={{this.closeSizeAuto}} @size="auto">
      <:header>Auto size</:header>
      <:body><ParagraphSmall>Width: auto - sized to content.</ParagraphSmall></:body>
      <:footer>
        <Button @kind="primary" {{on "click" this.closeSizeAuto}}>Close</Button>
      </:footer>
    </Modal>

    <Modal @isOpen={{this.sizeFullOpen}} @onClose={{this.closeSizeFull}} @size="full">
      <:header>Full size</:header>
      <:body><ParagraphSmall>Width: 100% (full width with viewport gutter).</ParagraphSmall></:body>
      <:footer>
        <Button @kind="primary" {{on "click" this.closeSizeFull}}>Close</Button>
      </:footer>
    </Modal>

    <Modal @isOpen={{this.sizeCustomOpen}} @onClose={{this.closeSizeCustom}} @size="720px">
      <:header>Custom 720px</:header>
      <:body><ParagraphSmall>Any CSS width works (e.g. <code>720px</code>, <code>60%</code>, <code>40rem</code>).</ParagraphSmall></:body>
      <:footer>
        <Button @kind="primary" {{on "click" this.closeSizeCustom}}>Close</Button>
      </:footer>
    </Modal>

    <HeadingMedium style="margin-top:32px">Alert dialog</HeadingMedium>
    <ParagraphSmall>Use <code>@role="alertdialog"</code> for blocking confirmations that require user attention.</ParagraphSmall>
    <Button @kind="dangerPrimary" {{on "click" this.openAlert}} style="margin-top:8px">Show alert</Button>
    <Modal @isOpen={{this.alertOpen}} @onClose={{this.closeAlert}} @role="alertdialog" @aria-label="Delete confirmation">
      <:header>Delete project?</:header>
      <:body><ParagraphSmall>This will permanently delete the project and all of its data.</ParagraphSmall></:body>
      <:footer>
        <div style="display:flex;gap:8px;justify-content:flex-end">
          <Button @kind="tertiary" {{on "click" this.closeAlert}}>Cancel</Button>
          <Button @kind="dangerPrimary" {{on "click" this.closeAlert}}>Delete</Button>
        </div>
      </:footer>
    </Modal>

    <HeadingMedium style="margin-top:32px">Non-closeable</HeadingMedium>
    <ParagraphSmall>With <code>@closeable={{false}}</code> Escape and backdrop click are disabled, and there is no X button. The user must take an explicit action.</ParagraphSmall>
    <Button @kind="secondary" {{on "click" this.openNonCloseable}} style="margin-top:8px">Open non-closeable</Button>
    <Modal @isOpen={{this.nonCloseableOpen}} @onClose={{this.closeNonCloseable}} @closeable={{false}}>
      <:header>Action required</:header>
      <:body><ParagraphSmall>Please choose an option below to proceed.</ParagraphSmall></:body>
      <:footer>
        <div style="display:flex;gap:8px;justify-content:flex-end">
          <Button @kind="primary" {{on "click" this.closeNonCloseable}}>Continue</Button>
        </div>
      </:footer>
    </Modal>

    <HeadingMedium style="margin-top:32px">No animation</HeadingMedium>
    <ParagraphSmall>Disable enter animation with <code>@animate={{false}}</code>.</ParagraphSmall>
    <Button @kind="secondary" {{on "click" this.openNoAnimate}} style="margin-top:8px">Open without animation</Button>
    <Modal @isOpen={{this.noAnimateOpen}} @onClose={{this.closeNoAnimate}} @animate={{false}}>
      <:header>No animation</:header>
      <:body><ParagraphSmall>Appears instantly.</ParagraphSmall></:body>
      <:footer>
        <Button @kind="primary" {{on "click" this.closeNoAnimate}}>Close</Button>
      </:footer>
    </Modal>

    <ParagraphXSmall style="margin-top:32px;color:#727272">Press <kbd>Esc</kbd> or click the backdrop to dismiss (when closeable). Tab cycles focus inside the modal.</ParagraphXSmall>
  </template>
}

export default ModalDemo;
