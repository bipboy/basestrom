/**
 * Textarea component types.
 *
 * @module basestrom/components/textarea/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  mini: 'mini',
  compact: 'compact',
  default: 'default',
  large: 'large',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type TextareaSize = keyof typeof SIZE;
export type TextareaResize = 'none' | 'vertical' | 'horizontal' | 'both';

export type TextareaOverrideKeys = 'root' | 'inputContainer' | 'textarea' | 'counter';
export type TextareaOverrides = Overrides<TextareaOverrideKeys>;

export interface TextareaSignature {
  Args: {
    /** Current value of the textarea. */
    value?: string;
    /** Handler called when the textarea value changes. */
    onChange?: (event: Event) => void;
    /** Placeholder text displayed when textarea is empty. */
    placeholder?: string;
    /** Size variant: mini, compact, default, large. */
    size?: TextareaSize;
    /** Number of visible text rows. Defaults to 3. */
    rows?: number;
    /** Maximum character count. When set, enables character counter display. */
    maxLength?: number;
    /** CSS resize property. Defaults to 'none'. */
    resize?: TextareaResize;
    /** Focus the textarea on initial render. */
    autoFocus?: boolean;
    /** Renders component in disabled state. */
    disabled?: boolean;
    /** Renders component in error state. */
    error?: boolean;
    /** Renders component in positive/success state. */
    positive?: boolean;
    /** Renders component in read-only state. */
    readOnly?: boolean;
    /** Marks the textarea as required. */
    required?: boolean;
    /** Input element id attribute. */
    id?: string;
    /** Input element name attribute. */
    name?: string;
    /** Accessible label for the textarea. */
    'aria-label'?: string;
    /** Id of element which contains a related description. */
    'aria-describedby'?: string;
    /** Id of element which contains a related error message. */
    'aria-errormessage'?: string;
    /** StyleX style overrides. */
    overrides?: TextareaOverrides;
  };
  Element: HTMLTextAreaElement;
}
