/**
 * Input component types.
 *
 * @module basestrom/components/input/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  mini: 'mini',
  compact: 'compact',
  default: 'default',
  large: 'large',
} as const;

export const ADJOINED = {
  none: 'none',
  left: 'left',
  right: 'right',
  both: 'both',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type InputSize = keyof typeof SIZE;
export type InputAdjoined = keyof typeof ADJOINED;

export type InputOverrideKeys =
  | 'root'
  | 'inputContainer'
  | 'input'
  | 'startEnhancer'
  | 'endEnhancer'
  | 'clearIcon'
  | 'clearIconContainer';

export type InputOverrides = Overrides<InputOverrideKeys>;

export interface InputSignature {
  Args: {
    /** Input value. */
    value?: string | number;
    /** Handler for input change events. */
    onChange?: (event: Event) => void;
    /** Handler for focus events. */
    onFocus?: (event: FocusEvent) => void;
    /** Handler for blur events. */
    onBlur?: (event: FocusEvent) => void;
    /** Handler for keydown events. */
    onKeyDown?: (event: KeyboardEvent) => void;
    /** Handler for keyup events. */
    onKeyUp?: (event: KeyboardEvent) => void;
    /** Handler for keypress events. */
    onKeyPress?: (event: KeyboardEvent) => void;
    /** Placeholder text. */
    placeholder?: string;
    /** Input type (text, password, number, email, etc.). */
    type?: string;
    /** Input size variant. */
    size?: InputSize;
    /** Renders component in 'error' state. */
    error?: boolean;
    /** Renders component in 'positive' state. */
    positive?: boolean;
    /** Renders component in 'disabled' state. */
    disabled?: boolean;
    /** Renders component in 'readOnly' state. */
    readOnly?: boolean;
    /** If true, adds a clear value icon button. */
    clearable?: boolean;
    /** If true, clears the input when Escape is pressed. Default: true. */
    clearOnEscape?: boolean;
    /** Defines styles for inputs grouped with other controls. */
    adjoined?: InputAdjoined;
    /** Focus the input on initial render. */
    autoFocus?: boolean;
    /** Determines if browser should provide value suggestions. */
    autoComplete?: string;
    /** Marks the input as required. */
    required?: boolean;
    /** Input element id. */
    id?: string;
    /** Input element name. */
    name?: string;
    /** Input mode hint. */
    inputMode?: string;
    /** Max length of input value. */
    maxLength?: number;
    /** Pattern for validation. */
    pattern?: string;
    /** Min value for number inputs. */
    min?: number;
    /** Max value for number inputs. */
    max?: number;
    /** Step value for number inputs. */
    step?: number | string;
    /** Input role attribute. */
    role?: string;
    /** aria-label attribute. */
    'aria-label'?: string;
    /** aria-describedby attribute. */
    'aria-describedby'?: string;
    /** aria-errormessage attribute. */
    'aria-errormessage'?: string;
    /** aria-labelledby attribute. */
    'aria-labelledby'?: string;
    /** aria-activedescendant attribute. */
    'aria-activedescendant'?: string;
    /** aria-autocomplete attribute. */
    'aria-autocomplete'?: string;
    /** aria-controls attribute. */
    'aria-controls'?: string;
    /** aria-haspopup attribute. */
    'aria-haspopup'?: string;
    /** StyleX style overrides. */
    overrides?: InputOverrides;
  };
  Blocks: {
    startEnhancer: [];
    endEnhancer: [];
  };
  Element: HTMLDivElement;
}
