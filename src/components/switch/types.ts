/**
 * Switch component types.
 *
 * @module basestrom/components/switch/types
 */

import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  default: 'default',
  small: 'small',
} as const;

export const LABEL_PLACEMENT = {
  right: 'right',
  left: 'left',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type SwitchSize = keyof typeof SIZE;
export type SwitchLabelPlacement = keyof typeof LABEL_PLACEMENT;

export type SwitchOverrideKeys =
  | 'root'
  | 'toggle'
  | 'toggleTrack'
  | 'label'
  | 'input';

export type SwitchOverrides = Overrides<SwitchOverrideKeys>;

export interface SwitchSignature {
  Args: {
    /** Check or uncheck the control. */
    checked?: boolean;
    /** Disable the switch from being changed. */
    disabled?: boolean;
    /** Marks the switch as required. */
    required?: boolean;
    /** Focus the switch on initial render. */
    autoFocus?: boolean;
    /** Size of the switch. Default: 'default'. */
    size?: SwitchSize;
    /** How to position the label relative to the switch. Default: 'right'. */
    labelPlacement?: SwitchLabelPlacement;
    /** Whether to show a checkmark icon when on. */
    showIcon?: boolean;
    /** Indicates this label children contain an interactive element. */
    containsInteractiveElement?: boolean;
    /** Passed to the input element id attribute. */
    id?: string;
    /** Passed to the input element name attribute. */
    name?: string;
    /** Passed to the input element value attribute. */
    value?: string;
    /** Native title attribute. */
    title?: string | null;
    'aria-label'?: string;
    'aria-describedby'?: string;
    'aria-errormessage'?: string;
    'aria-invalid'?: boolean;
    /** Handler for change events on the input. */
    onChange?: (event: Event) => void;
    /** StyleX overrides. */
    overrides?: SwitchOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLLabelElement;
}
