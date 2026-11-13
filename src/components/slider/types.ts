/**
 * Slider component types.
 *
 * @module basestrom/components/slider/types
 */

import type { Overrides } from "../../helpers/overrides";

// ─── Types ──────────────────────────────────────────────────────────────────────

export type SliderOverrideKeys =
	| "root"
	| "track"
	| "innerTrack"
	| "thumb"
	| "innerThumb"
	| "thumbValue"
	| "mark"
	| "tickBar"
	| "tick";

export type SliderOverrides = Overrides<SliderOverrideKeys>;

export interface SliderSignature {
	Args: {
		/** Position of the thumbs. Single number array = one thumb, two = range. */
		value: number[];
		/** Minimum allowed value. Default: 0. */
		min?: number;
		/** Maximum allowed value. Default: 100. */
		max?: number;
		/** Step granularity. Default: 1. */
		step?: number;
		/** Disable the slider. */
		disabled?: boolean;
		/** Display a mark at each step. */
		marks?: boolean;
		/** Always display the thumb value label. */
		persistentThumb?: boolean;
		/** Format the numeric value for display. */
		valueToLabel?: (value: number) => string;
		/** Called on every value change (during drag). */
		onChange?: (params: { value: number[] }) => void;
		/** Called when drag ends (final value). */
		onFinalChange?: (params: { value: number[] }) => void;
		/** StyleX overrides. */
		overrides?: SliderOverrides;
	};
	Element: HTMLDivElement;
}

export interface StatefulSliderSignature {
	Args: {
		/** Initial value. Defaults to midpoint. */
		initialValue?: number[];
		/** Minimum allowed value. Default: 0. */
		min?: number;
		/** Maximum allowed value. Default: 100. */
		max?: number;
		/** Step granularity. Default: 1. */
		step?: number;
		/** Disable the slider. */
		disabled?: boolean;
		/** Display a mark at each step. */
		marks?: boolean;
		/** Always display the thumb value label. */
		persistentThumb?: boolean;
		/** Format the numeric value for display. */
		valueToLabel?: (value: number) => string;
		/** Called on every value change. */
		onChange?: (params: { value: number[] }) => void;
		/** Called when drag ends. */
		onFinalChange?: (params: { value: number[] }) => void;
		/** StyleX overrides. */
		overrides?: SliderOverrides;
	};
	Element: HTMLDivElement;
}
