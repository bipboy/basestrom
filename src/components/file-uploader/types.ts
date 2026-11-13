import type { Overrides } from '../../helpers/overrides';

// --- Locale -----------------------------------------------------------------

export interface FileUploaderLocale {
  dropFilesToUpload: string;
  or: string;
  browseFiles: string;
  retry: string;
  cancel: string;
}

export const DEFAULT_LOCALE: FileUploaderLocale = {
  dropFilesToUpload: 'Drop files here to upload',
  or: '',
  browseFiles: 'Browse files',
  retry: 'Retry upload',
  cancel: 'Cancel',
};

// --- Override keys ----------------------------------------------------------

export type FileUploaderOverrideKeys =
  | 'root'
  | 'fileDragAndDrop'
  | 'contentMessage'
  | 'contentSeparator'
  | 'errorMessage'
  | 'hiddenInput'
  | 'progressBar';

export type FileUploaderOverrides = Overrides<FileUploaderOverrideKeys>;

// --- Public API -------------------------------------------------------------

export interface FileUploaderSignature {
  Args: {
    /** MIME type filter for accepted files. Comma-separated string or array. */
    accept?: string | string[];
    /** Allow selecting multiple files. */
    multiple?: boolean;
    /** Disable the uploader. */
    disabled?: boolean;
    /** Visible button label. Defaults to locale.browseFiles. */
    buttonText?: string;
    /** Visible drop-zone message. Defaults to locale.dropFilesToUpload. */
    contentMessage?: string;
    /** Render the button before the drop message. */
    swapButtonAndMessage?: boolean;
    /**
     * Determinate progress 0-100. When provided, a progress bar is shown.
     * If both `progressAmount` and `progressMessage` are absent and
     * `errorMessage` is absent, the dropzone is in idle state.
     */
    progressAmount?: number;
    /** Indeterminate progress message. Shown alongside spinner. */
    progressMessage?: string;
    /** Error message; switches the uploader into error state. */
    errorMessage?: string;
    /**
     * Disables clicking on the drop area to open the file picker
     * (the explicit Browse button still works). Default: true.
     */
    disableClick?: boolean;
    'aria-describedby'?: string;
    /** Called when files are dropped or selected via the picker. */
    onDrop?: (accepted: File[], rejected: File[]) => void;
    /** Called when the user clicks Cancel after an upload attempt. */
    onCancel?: () => void;
    /** Called when the user clicks Retry after an error. */
    onRetry?: () => void;
    /** Override locale strings. */
    locale?: Partial<FileUploaderLocale>;
    /** StyleX overrides. */
    overrides?: FileUploaderOverrides;
  };
  Element: HTMLDivElement;
}
