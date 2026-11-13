import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import FileUploader from '../../src/components/file-uploader/index.gts';
import {
    HeadingMedium,
    HeadingXLarge,
    ParagraphSmall,
    ParagraphXSmall,
} from '../../src/components/typography/index.gts';

class FileUploaderDemo extends Component {
  @tracked progress: number | undefined = undefined;
  @tracked progressMessage: string | undefined = undefined;
  @tracked errorMessage: string | undefined = undefined;
  @tracked lastDrop = '';
  private timer: ReturnType<typeof setInterval> | null = null;

  handleDrop = (accepted: File[], rejected: File[]) => {
    this.lastDrop = `accepted: ${accepted.map((f) => f.name).join(', ') || '-'}; rejected: ${rejected.map((f) => f.name).join(', ') || '-'}`;
    this.startFakeUpload();
  };

  handleCancel = () => {
    this.cleanup();
    this.progress = undefined;
    this.progressMessage = undefined;
    this.errorMessage = undefined;
  };

  handleRetry = () => {
    this.errorMessage = undefined;
    this.startFakeUpload();
  };

  private startFakeUpload(): void {
    this.cleanup();
    this.errorMessage = undefined;
    this.progress = 0;
    this.progressMessage = 'Uploading...';
    this.timer = setInterval(() => {
      const next = (this.progress ?? 0) + 10;
      if (next >= 100) {
        this.progress = 100;
        this.progressMessage = 'Done';
        this.cleanup();
      } else {
        this.progress = next;
      }
    }, 250);
  }

  private cleanup(): void {
    if (this.timer !== null) {
      clearInterval(this.timer);
      this.timer = null;
    }
  }

  willDestroy(): void {
    super.willDestroy();
    this.cleanup();
  }

  triggerError = () => {
    this.cleanup();
    this.errorMessage = 'Upload failed: network error';
    this.progress = undefined;
    this.progressMessage = undefined;
  };

  <template>
    <HeadingXLarge>FileUploader</HeadingXLarge>
    <ParagraphSmall>Drag-and-drop file uploader with click-to-browse fallback. Supports MIME filters, multiple files, progress reporting, error states with retry, and cancellation.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Idle</HeadingMedium>
    <FileUploader @onDrop={{this.handleDrop}} />

    <HeadingMedium style="margin-top:24px">With accept filter (images only) and multiple</HeadingMedium>
    <FileUploader
      @accept="image/*"
      @multiple={{true}}
      @onDrop={{this.handleDrop}}
    />

    <HeadingMedium style="margin-top:24px">With progress + cancel/retry</HeadingMedium>
    <FileUploader
      @onDrop={{this.handleDrop}}
      @progressAmount={{this.progress}}
      @progressMessage={{this.progressMessage}}
      @errorMessage={{this.errorMessage}}
      @onCancel={{this.handleCancel}}
      @onRetry={{this.handleRetry}}
    />
    <div style="margin-top:8px;display:flex;gap:8px">
      <button type="button" {{on "click" this.triggerError}}>Simulate error</button>
    </div>

    <HeadingMedium style="margin-top:24px">Disabled</HeadingMedium>
    <FileUploader @disabled={{true}} />

    <ParagraphXSmall style="margin-top:16px;color:#727272">Last drop event: {{this.lastDrop}}</ParagraphXSmall>
  </template>
}


export default FileUploaderDemo;
