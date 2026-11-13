/**
 * FileUploader component - port from baseweb file-uploader-basic.
 *
 * A drag-and-drop file uploader with click-to-browse fallback. Supports
 * accept filters, multiple-file mode, file size limits, progress reporting
 * (indeterminate spinner or determinate bar), error messaging, and
 * retry/cancel controls.
 *
 * Drag-and-drop is implemented via native HTML5 drag events; no
 * `react-dropzone` equivalent is required.
 *
 * Usage:
 * ```hbs
 * <Bst::FileUploader
 *   @accept="image/*"
 *   @onDrop={{this.handleDrop}}
 *   @progressAmount={{this.progress}}
 *   @progressMessage={{this.message}}
 *   @errorMessage={{this.error}}
 *   @onRetry={{this.retry}}
 *   @onCancel={{this.cancel}}
 * />
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { bstRef } from '../../modifiers';
import Button from '../button/index.gts';
import Spinner from '../spinner/index.gts';
import {
  buttonRowStyles,
  contentMessageStyles,
  dropzoneStyles,
  errorMessageStyles,
  hiddenInputStyles,
  progressBarStyles,
  rootStyles,
} from './styles.stylex';
import {
  DEFAULT_LOCALE,
  type FileUploaderLocale,
  type FileUploaderOverrides,
  type FileUploaderSignature,
} from './types';

// Re-export types and constants
export {
  DEFAULT_LOCALE,
  type FileUploaderLocale,
  type FileUploaderOverrides,
  type FileUploaderSignature
};

// Make modifier available in strict-mode template with original name
const ref = bstRef;

// --- Component --------------------------------------------------------------

export default class FileUploader extends Component<FileUploaderSignature> {
  @tracked private isDragActive = false;

  private inputElement: HTMLInputElement | null = null;
  private dragEnterCount = 0;

  // -- Computed --------------------------------------------------------------

  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get disableClick(): boolean { return this.args.disableClick ?? true; }

  get acceptString(): string | undefined {
    const accept = this.args.accept;
    if (Array.isArray(accept)) return accept.join(',');
    return accept;
  }

  get hasError(): boolean { return !!this.args.errorMessage; }
  get hasIndeterminateProgress(): boolean {
    return !this.hasError
      && typeof this.args.progressAmount !== 'number'
      && !!this.args.progressMessage;
  }
  get hasDeterminateProgress(): boolean {
    return typeof this.args.progressAmount === 'number';
  }

  get afterFileDrop(): boolean {
    return this.hasError
      || this.hasIndeterminateProgress
      || this.hasDeterminateProgress;
  }

  get locale(): FileUploaderLocale {
    return { ...DEFAULT_LOCALE, ...(this.args.locale ?? {}) };
  }

  get displayContentMessage(): string {
    if (this.hasError) return ''; // error message replaces content
    if (this.hasIndeterminateProgress) return this.args.progressMessage ?? '';
    return this.args.contentMessage ?? this.locale.dropFilesToUpload;
  }

  // -- Styles ---------------------------------------------------------------

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(rootStyles.base, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get dropzoneClassName(): string | undefined {
    const resolved = resolveOverride(dropzoneStyles.base, this.args.overrides, 'fileDragAndDrop');
    const { className } = stylex.props(
      ...resolved,
      this.afterFileDrop && dropzoneStyles.afterFileDrop,
      this.isDragActive && dropzoneStyles.dragActive,
      this.isDisabled && dropzoneStyles.disabled,
    );
    return className || undefined;
  }

  get contentMessageClassName(): string | undefined {
    const resolved = resolveOverride(
      contentMessageStyles.base,
      this.args.overrides,
      'contentMessage',
    );
    const { className } = stylex.props(
      ...resolved,
      this.isDragActive && !this.afterFileDrop && contentMessageStyles.dragActive,
      this.afterFileDrop && contentMessageStyles.afterFileDrop,
    );
    return className || undefined;
  }

  get errorMessageClassName(): string | undefined {
    const resolved = resolveOverride(
      errorMessageStyles.base,
      this.args.overrides,
      'errorMessage',
    );
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get hiddenInputClassName(): string | undefined {
    const resolved = resolveOverride(
      hiddenInputStyles.base,
      this.args.overrides,
      'hiddenInput',
    );
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get buttonRowClassName(): string | undefined {
    const { className } = stylex.props(buttonRowStyles.base);
    return className || undefined;
  }

  get progressTrackClassName(): string | undefined {
    const resolved = resolveOverride(
      progressBarStyles.track,
      this.args.overrides,
      'progressBar',
    );
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get progressFillClassName(): string | undefined {
    const { className } = stylex.props(
      progressBarStyles.fill,
      this.hasError && progressBarStyles.fillError,
    );
    return className || undefined;
  }

  get progressFillStyle(): string {
    const value = Math.max(0, Math.min(100, this.args.progressAmount ?? 0));
    return htmlSafe(`width:${value}%`).toString();
  }

  // -- Drag handlers --------------------------------------------------------

  handleDragEnter = (event: DragEvent) => {
    if (this.isDisabled || this.afterFileDrop) return;
    event.preventDefault();
    this.dragEnterCount += 1;
    this.isDragActive = true;
  };

  handleDragOver = (event: DragEvent) => {
    if (this.isDisabled || this.afterFileDrop) return;
    event.preventDefault();
    if (event.dataTransfer) event.dataTransfer.dropEffect = 'copy';
  };

  handleDragLeave = (event: DragEvent) => {
    if (this.isDisabled || this.afterFileDrop) return;
    event.preventDefault();
    this.dragEnterCount = Math.max(0, this.dragEnterCount - 1);
    if (this.dragEnterCount === 0) this.isDragActive = false;
  };

  handleDrop = (event: DragEvent) => {
    if (this.isDisabled || this.afterFileDrop) return;
    event.preventDefault();
    this.isDragActive = false;
    this.dragEnterCount = 0;
    const files = event.dataTransfer?.files;
    if (files) this.dispatchFiles(files);
  };

  handleZoneClick = (event: Event) => {
    // Only intercept clicks on the dropzone itself, not on inner interactive
    // elements (Browse button, hidden file input). Otherwise calling
    // preventDefault on the bubbled click would cancel the file picker that
    // was just opened by the input's click.
    if (event.target !== event.currentTarget) return;
    if (this.disableClick) {
      event.preventDefault();
      return;
    }
    this.openPicker();
  };

  /** Stop the hidden input's click from bubbling to the dropzone handler. */
  handleInputClick = (event: Event) => {
    event.stopPropagation();
  };

  handleBrowseClick = (event: Event) => {
    // Stop the button click from bubbling to the dropzone for the same reason.
    event.stopPropagation();
    this.openPicker();
  };

  handleInputChange = (event: Event) => {
    const target = event.target as HTMLInputElement;
    if (target.files) this.dispatchFiles(target.files);
    // Reset value so selecting the same file twice fires change.
    target.value = '';
  };

  captureInput = (el: Element | null) => {
    this.inputElement = (el as HTMLInputElement | null);
  };

  openPicker(): void {
    if (this.isDisabled) return;
    this.inputElement?.click();
  }

  // -- File dispatch (filters by `accept`) ----------------------------------

  private dispatchFiles(fileList: FileList): void {
    const accepted: File[] = [];
    const rejected: File[] = [];
    const filter = this.acceptString;
    const matchers = filter ? buildAcceptMatchers(filter) : null;

    for (const file of Array.from(fileList)) {
      if (!matchers || matchers.some((m) => m(file))) {
        accepted.push(file);
      } else {
        rejected.push(file);
      }
    }

    this.args.onDrop?.(accepted, rejected);
  }

  <template>
    <div
      class={{this.rootClassName}}
      ...attributes
      data-basestrom="file-uploader"
    >
      <div
        class={{this.dropzoneClassName}}
        tabindex="-1"
        {{on "dragenter" this.handleDragEnter}}
        {{on "dragover" this.handleDragOver}}
        {{on "dragleave" this.handleDragLeave}}
        {{on "drop" this.handleDrop}}
        {{on "click" this.handleZoneClick}}
      >
        {{#unless this.afterFileDrop}}
          {{#if @swapButtonAndMessage}}
            <div class={{this.buttonRowClassName}}>
              <Button
                @kind="secondary"
                @shape="pill"
                @size="small"
                @disabled={{this.isDisabled}}
                {{on "click" this.handleBrowseClick}}
              >
                {{if @buttonText @buttonText this.locale.browseFiles}}
              </Button>
            </div>
            {{#if this.locale.or}}
              <div class={{this.contentMessageClassName}}>
                {{this.locale.or}}
              </div>
            {{/if}}
            <div class={{this.contentMessageClassName}}>
              {{this.displayContentMessage}}
            </div>
          {{else}}
            <div class={{this.contentMessageClassName}}>
              {{this.displayContentMessage}}
            </div>
            {{#if this.locale.or}}
              <div class={{this.contentMessageClassName}}>
                {{this.locale.or}}
              </div>
            {{/if}}
            <div class={{this.buttonRowClassName}}>
              <Button
                @kind="secondary"
                @shape="pill"
                @size="small"
                @disabled={{this.isDisabled}}
                {{on "click" this.handleBrowseClick}}
              >
                {{if @buttonText @buttonText this.locale.browseFiles}}
              </Button>
            </div>
          {{/if}}
        {{/unless}}

        {{#if this.afterFileDrop}}
          {{#if this.hasDeterminateProgress}}
            <div class={{this.progressTrackClassName}} role="progressbar">
              <div class={{this.progressFillClassName}} style={{this.progressFillStyle}}></div>
            </div>
          {{else if this.hasIndeterminateProgress}}
            <Spinner @size="medium" />
          {{/if}}

          {{#if this.hasError}}
            <div
              class={{this.errorMessageClassName}}
              role="alert"
            >
              {{@errorMessage}}
            </div>
          {{else if @progressMessage}}
            <div class={{this.contentMessageClassName}}>
              {{@progressMessage}}
            </div>
          {{/if}}

          <div class={{this.buttonRowClassName}}>
            {{#if this.hasError}}
              <Button
                @kind="tertiary"
                @size="small"
                {{on "click" this.handleRetry}}
              >
                {{this.locale.retry}}
              </Button>
            {{else}}
              <Button
                @kind="tertiary"
                @size="small"
                {{on "click" this.handleCancel}}
              >
                {{this.locale.cancel}}
              </Button>
            {{/if}}
          </div>
        {{/if}}

        <input
          class={{this.hiddenInputClassName}}
          type="file"
          accept={{this.acceptString}}
          multiple={{@multiple}}
          disabled={{this.isDisabled}}
          aria-label={{this.locale.browseFiles}}
          aria-describedby={{@aria-describedby}}
          {{bstRef this.captureInput}}
          {{on "click" this.handleInputClick}}
          {{on "change" this.handleInputChange}}
        />
      </div>
    </div>
  </template>

  // -- Cancel / retry handlers (referenced from template) ------------------

  handleCancel = () => {
    this.args.onCancel?.();
  };

  handleRetry = () => {
    this.args.onRetry?.();
  };
}

// ---------------------------------------------------------------------------
// `accept` matcher helpers
// ---------------------------------------------------------------------------

type AcceptMatcher = (file: File) => boolean;

function buildAcceptMatchers(accept: string): AcceptMatcher[] {
  return accept
    .split(',')
    .map((token) => token.trim())
    .filter((token) => token.length > 0)
    .map(buildSingleMatcher);
}

function buildSingleMatcher(token: string): AcceptMatcher {
  // Extension match: .png
  if (token.startsWith('.')) {
    const ext = token.toLowerCase();
    return (file) => file.name.toLowerCase().endsWith(ext);
  }
  // Wildcard MIME match: image/*
  if (token.endsWith('/*')) {
    const prefix = token.slice(0, -1).toLowerCase(); // 'image/'
    return (file) => file.type.toLowerCase().startsWith(prefix);
  }
  // Exact MIME match.
  const exact = token.toLowerCase();
  return (file) => file.type.toLowerCase() === exact;
}
