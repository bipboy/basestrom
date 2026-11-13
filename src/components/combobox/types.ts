/**
 * Combobox component types.
 *
 * @module basestrom/components/combobox/types
 */

import type { ComponentLike } from '@glint/template';
import type { Overrides } from '../../helpers/overrides';

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
  mini: 'mini',
  compact: 'compact',
  default: 'default',
  large: 'large',
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type ComboboxSize = keyof typeof SIZE;

export type ComboboxOverrideKeys =
  | 'Root'
  | 'InputContainer'
  | 'Input'
  | 'Popover'
  | 'ListBox'
  | 'ListItem';

export type ComboboxOverrides = Overrides<ComboboxOverrideKeys>;

export interface ComboboxSignature<Option = unknown> {
  Args: {
    /** Committed input value. */
    value: string;
    /** Options to render in the listbox. Empty/omitted → no items, listbox stays closed. */
    options?: Option[];
    /** REQUIRED. Maps an option to its visible string. Omitted → no items, listbox closed. */
    mapOptionToString: (option: Option) => string;
    /** Optional custom component to render each ListItem. */
    mapOptionToNode?: ComponentLike<{ Args: { option: Option; isSelected: boolean } }>;
    /** value/option change. option is null when the change came from typing. */
    onChange: (value: string, option: Option | null) => void;
    /** Called on Enter when no option highlighted. */
    onSubmit?: (arg: { closeListbox: () => void; value: string }) => void;
    /** Handler for focus events. */
    onFocus?: (event: FocusEvent) => void;
    /** Handler for blur events. */
    onBlur?: (event: FocusEvent) => void;
    /** Update input value while keyboard-navigating. Default true. */
    autocomplete?: boolean;
    /** If true, adds a clear value icon button to the input. */
    clearable?: boolean;
    /** Renders component in 'disabled' state. */
    disabled?: boolean;
    /** Renders component in 'error' state. */
    error?: boolean;
    /** Renders component in 'positive' state. */
    positive?: boolean;
    /** Input size variant. */
    size?: ComboboxSize;
    /** Accessible label for the listbox. */
    listBoxLabel?: string;
    /** Input element id. */
    id?: string;
    /** Input element name. */
    name?: string;
    /** StyleX style overrides. */
    overrides?: ComboboxOverrides;
  };
  Blocks: {
    /** Content rendered before the input (e.g. a search icon). Forwarded to the inner Input. */
    startEnhancer: [];
  };
  Element: HTMLDivElement;
}
