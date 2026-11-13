import type { Overrides } from '../../helpers/overrides';

export type FormControlOverrideKeys =
  | 'labelContainer'
  | 'label'
  | 'labelEndEnhancer'
  | 'controlContainer'
  | 'caption'
  | 'captionMessage'
  | 'captionIcon';

export type FormControlOverrides = Overrides<FormControlOverrideKeys>;

/**
 * Counter spec. Pass `true` to derive length from the consumer-supplied
 * length/max props. We can't read the child input's value in Ember, so the
 * consumer is responsible for computing length.
 */
export type FormControlCounter =
  | boolean
  | {
      length?: number;
      maxLength?: number;
      error?: boolean;
    };

export interface FormControlYieldedState {
  controlId: string;
  disabled: boolean;
  isError: boolean;
  isPositive: boolean;
  captionId: string;
  errorMessageId: string | undefined;
}

export interface FormControlSignature {
  Args: {
    /** Label text rendered above the control. */
    label?: string;
    /** Caption text rendered below the control. */
    caption?: string;
    /** Error state. Strings render as text in place of caption. */
    error?: string | boolean;
    /** Positive state. `@error` wins if both set. */
    positive?: string | boolean;
    /** Disabled state. Tones down the label and forwarded via yield. */
    disabled?: boolean;
    /** Explicit `for` attribute. Defaults to a generated id. */
    htmlFor?: string;
    /** Optional label end enhancer (typically a counter). */
    labelEndEnhancer?: string;
    /** Counter spec. */
    counter?: FormControlCounter;
    /** StyleX overrides. */
    overrides?: FormControlOverrides;
  };
  Blocks: {
    default: [FormControlYieldedState];
    /** Optional richer label (replaces `@label`). */
    label: [];
    /** Optional richer caption (replaces `@caption`/`@error`/`@positive` text). */
    caption: [];
    /** Optional icon next to the caption (replaces the default error/check icon). */
    captionIcon: [];
  };
  Element: HTMLDivElement;
}
