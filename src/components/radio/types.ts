/**
 * Radio component types.
 *
 * @module basestrom/components/radio/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const ALIGN = {
  horizontal: 'horizontal',
  vertical: 'vertical',
} as const;

export const LABEL_PLACEMENT = {
  right: 'right',
  left: 'left',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type RadioAlign = keyof typeof ALIGN;
export type RadioLabelPlacement = keyof typeof LABEL_PLACEMENT;

// --- RadioGroup Context (yielded to children) ---

export interface RadioGroupContext {
  name?: string;
  selectedValue?: string;
  disabled?: boolean;
  error?: boolean;
  required?: boolean;
  autoFocus?: boolean;
  labelPlacement?: RadioLabelPlacement;
  isFocusVisible: boolean;
  focusedIndex: number;
  registerRadio: () => number;
  onChange?: (event: Event) => void;
  onRadioFocus: (index: number, event: FocusEvent) => void;
  onRadioBlur: (index: number) => void;
}

// --- RadioGroup ---

export type RadioGroupOverrideKeys = 'root';
export type RadioGroupOverrides = Overrides<RadioGroupOverrideKeys>;

export interface RadioGroupSignature {
  Args: {
    value?: string;
    name?: string;
    disabled?: boolean;
    error?: boolean;
    required?: boolean;
    /** Focus the selected/first radio on initial render. */
    autoFocus?: boolean;
    align?: RadioAlign;
    labelPlacement?: RadioLabelPlacement;
    /** Id of element which contains a related caption. */
    'aria-describedby'?: string;
    /** Id of element which contains a related error message. */
    'aria-errormessage'?: string;
    /** Accessible label for the radio group. */
    'aria-label'?: string;
    /** Id of element that labels the radio group. */
    'aria-labelledby'?: string;
    onChange?: (event: Event) => void;
    overrides?: RadioGroupOverrides;
  };
  Blocks: { default: [RadioGroupContext] };
  Element: HTMLDivElement;
}

// --- Radio ---

export type RadioOverrideKeys = 'root' | 'backplate' | 'markOuter' | 'markInner' | 'label' | 'input';
export type RadioOverrides = Overrides<RadioOverrideKeys>;

export interface RadioSignature {
  Args: {
    /** Context from RadioGroup (pass via `as |group|`). */
    group?: RadioGroupContext;
    value?: string;
    checked?: boolean;
    disabled?: boolean;
    error?: boolean;
    required?: boolean;
    /** Focus the radio on initial render. */
    autoFocus?: boolean;
    name?: string;
    labelPlacement?: RadioLabelPlacement;
    description?: string;
    /** Id of element which contains a related caption. */
    'aria-describedby'?: string;
    /** Id of element which contains a related error message. */
    'aria-errormessage'?: string;
    /** Indicates if children contain an interactive element. */
    containsInteractiveElement?: boolean;
    onChange?: (event: Event) => void;
    overrides?: RadioOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLLabelElement;
}
