import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { SnackbarContainer, SnackbarElement, type SnackbarItem } from '../../src/components/snackbar/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

class SnackbarDemo extends Component {
  @tracked lastAction = '';

  handleUndo = () => { this.lastAction = 'Undo clicked'; };
  handleRetry = () => { this.lastAction = 'Retry clicked'; };

  enqueueBasic = (enqueue: (item: SnackbarItem) => void) => {
    enqueue({ message: 'Item has been saved.' });
  };

  enqueueWithAction = (enqueue: (item: SnackbarItem) => void) => {
    enqueue({ message: 'Item deleted.', actionMessage: 'Undo', actionOnClick: this.handleUndo });
  };

  enqueueWithProgress = (enqueue: (item: SnackbarItem) => void) => {
    enqueue({ message: 'Uploading file...', progress: true, duration: 5000 });
  };

  enqueueLong = (enqueue: (item: SnackbarItem) => void) => {
    enqueue({ message: 'This is a longer message that demonstrates how the snackbar handles multi-line text content gracefully.', actionMessage: 'Dismiss', duration: 7000 });
  };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Snackbar</HeadingXLarge>
      <ParagraphSmall>Brief messages about app processes at the bottom/top of the screen.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>SnackbarElement (standalone)</HeadingMedium>
      <div style="margin-top:16px;display:flex;flex-direction:column;gap:16px;max-width:540px">
        <SnackbarElement @message="Your changes have been saved." />
        <SnackbarElement @message="Item removed from cart." @actionMessage="Undo" @actionOnClick={{this.handleUndo}} />
        <SnackbarElement @message="Uploading document..." @progress={{true}} />
        <SnackbarElement @message="Connection lost. Please check your network." @actionMessage="Retry" @actionOnClick={{this.handleRetry}}>
          <:startEnhancer>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M1 21h22L12 2 1 21zm12-3h-2v-2h2v2zm0-4h-2v-4h2v4z"/></svg>
          </:startEnhancer>
        </SnackbarElement>
      </div>
      {{#if this.lastAction}}
        <ParagraphXSmall style="margin-top:8px">Last action: {{this.lastAction}}</ParagraphXSmall>
      {{/if}}
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>SnackbarContainer (queued, animated)</HeadingMedium>
      <ParagraphSmall>Click buttons to enqueue snackbars. They appear at the top and auto-dismiss.</ParagraphSmall>

      <SnackbarContainer @placement="top" @defaultDuration={{3000}} as |snackbar|>
        <div style="margin-top:16px;display:flex;gap:8px;flex-wrap:wrap">
          <button type="button" style="padding:8px 16px;border-radius:8px;border:1px solid #e8e8e8;background:#fff;cursor:pointer;font-size:14px;font-weight:500" {{on "click" (fn this.enqueueBasic snackbar.enqueue)}}>Basic</button>
          <button type="button" style="padding:8px 16px;border-radius:8px;border:1px solid #e8e8e8;background:#fff;cursor:pointer;font-size:14px;font-weight:500" {{on "click" (fn this.enqueueWithAction snackbar.enqueue)}}>With Action</button>
          <button type="button" style="padding:8px 16px;border-radius:8px;border:1px solid #e8e8e8;background:#fff;cursor:pointer;font-size:14px;font-weight:500" {{on "click" (fn this.enqueueWithProgress snackbar.enqueue)}}>With Progress</button>
          <button type="button" style="padding:8px 16px;border-radius:8px;border:1px solid #e8e8e8;background:#fff;cursor:pointer;font-size:14px;font-weight:500" {{on "click" (fn this.enqueueLong snackbar.enqueue)}}>Long Message</button>
        </div>
      </SnackbarContainer>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Bottom Placement</HeadingMedium>
      <SnackbarContainer @placement="bottom" @defaultDuration={{3000}} as |snackbar|>
        <div style="margin-top:16px">
          <button type="button" style="padding:8px 16px;border-radius:8px;border:1px solid #e8e8e8;background:#fff;cursor:pointer;font-size:14px;font-weight:500" {{on "click" (fn this.enqueueBasic snackbar.enqueue)}}>Show at bottom</button>
        </div>
      </SnackbarContainer>
    </div>
  </template>
}

export default SnackbarDemo;
