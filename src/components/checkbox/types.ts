/**
 * Checkbox component types.
 *
 * @module basestrom/components/checkbox/types
 */

import type { Overrides } from "../../helpers/overrides";

// ─── Constants ──────────────────────────────────────────────────────────────────

export const LABEL_PLACEMENT = {
	right: "right",
	left: "left",
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type CheckboxLabelPlacement = keyof typeof LABEL_PLACEMENT;

export type CheckboxOverrideKeys =
	| "root"
	| "checkmarkContainer"
	| "checkmark"
	| "label"
	| "input";
export type CheckboxOverrides = Overrides<CheckboxOverrideKeys>;

export interface CheckboxSignature {
	Args: {
		/** Check or uncheck the control. */
		checked?: boolean;
		/** Indicates a 'half' state for the checkmark. */
		isIndeterminate?: boolean;
		/** Disable the checkbox from being changed. */
		disabled?: boolean;
		/** Renders checkbox in errored state. */
		error?: boolean;
		/** Marks the checkbox as required. */
		required?: boolean;
		/** Focus the checkbox on initial render. */
		autoFocus?: boolean;
		/** How to position the label relative to the checkbox. */
		labelPlacement?: CheckboxLabelPlacement;
		/** Passed to the input element id attribute. */
		id?: string;
		/** Passed to the input element name attribute. */
		name?: string;
		/** Passed to the input element value attribute. */
		value?: string;
		/** Id of element which contains a related caption. */
		"aria-describedby"?: string;
		/** Id of element which contains a related error message. */
		"aria-errormessage"?: string;
		/** Identifies the element(s) whose contents are controlled by this checkbox. */
		"aria-controls"?: string;
		/** Passed to the input element aria-label attribute. */
		"aria-label"?: string;
		/** Indicates if children contain an interactive element. */
		containsInteractiveElement?: boolean;
		/** Handler for change events on trigger element. */
		onChange?: (event: Event) => void;
		/** StyleX style overrides. */
		overrides?: CheckboxOverrides;
	};
	Blocks: { default: [] };
	Element: HTMLLabelElement;
}
