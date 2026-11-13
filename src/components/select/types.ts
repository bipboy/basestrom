/**
 * Select component types.
 *
 * Split into Base (bare styled <select>) and Field (FormControl wrapper),
 * following the HDS Form::Select pattern.
 *
 * @module basestrom/components/select/types
 */

import type { Overrides } from "../../helpers/overrides";
import type { FormControlSignature } from "../form-control/types";

// ─── Constants ──────────────────────────────────────────────────────────────────

export const SIZE = {
	mini: "mini",
	compact: "compact",
	default: "default",
	large: "large",
} as const;

// ─── Types ──────────────────────────────────────────────────────────────────────

export type SelectSize = keyof typeof SIZE;

export type SelectOverrideKeys = "root";

export type SelectOverrides = Overrides<SelectOverrideKeys>;

// ─── Base Signature ─────────────────────────────────────────────────────────────

export interface SelectBaseSignature {
	Args: {
		/** Renders component in 'invalid' / error state. */
		isInvalid?: boolean;
		/** Select size variant. */
		size?: SelectSize;
		/** Explicit width (e.g. "200px", "100%"). */
		width?: string;
		/** StyleX style overrides. */
		overrides?: SelectOverrides;
	};
	Blocks: {
		/** Default block for <option> / <optgroup> content. */
		default: [];
	};
	Element: HTMLSelectElement;
}

// ─── Field Signature ────────────────────────────────────────────────────────────

export interface SelectFieldSignature {
	Args: Pick<
		FormControlSignature["Args"],
		| "label"
		| "caption"
		| "error"
		| "positive"
		| "disabled"
		| "counter"
		| "labelEndEnhancer"
	> &
		SelectBaseSignature["Args"] & {
			/** Marks the select as required (adds required attribute + label indicator). */
			isRequired?: boolean;
			/** Marks the select as optional (adds label indicator). */
			isOptional?: boolean;
		};
	Blocks: {
		/** Default block for <option> / <optgroup> content. */
		default: [];
	};
	Element: HTMLSelectElement;
}
