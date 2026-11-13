/**
 * Button component types.
 *
 * @module basestrom/components/button/types
 */

import type { Overrides } from "../../helpers/overrides";
import type { SpinnerOverrides } from "../spinner/types";

export const KIND = {
	primary: "primary",
	secondary: "secondary",
	tertiary: "tertiary",
	dangerPrimary: "dangerPrimary",
	dangerSecondary: "dangerSecondary",
	dangerTertiary: "dangerTertiary",
} as const;

export const SIZE = {
	xSmall: "xSmall",
	small: "small",
	medium: "medium",
	large: "large",
} as const;

export const SHAPE = {
	default: "default",
	pill: "pill",
	circle: "circle",
	square: "square",
} as const;

export type ButtonKind = keyof typeof KIND;
export type ButtonSize = keyof typeof SIZE;
export type ButtonShape = keyof typeof SHAPE;

export type ButtonOverrideKeys =
	| "root"
	| "startEnhancer"
	| "endEnhancer"
	| "spinner";
export type ButtonOverrides = Overrides<ButtonOverrideKeys>;

export interface ButtonSignature {
	Args: {
		kind?: ButtonKind;
		size?: ButtonSize;
		shape?: ButtonShape;
		isLoading?: boolean;
		isSelected?: boolean;
		disabled?: boolean;
		fullWidth?: boolean;
		/** Adds shadow for visibility on any background (FAB). */
		backgroundSafe?: boolean;
		/** Increases touch target to 48px without changing visual size. */
		minHitArea?: "tap" | "click";
		/** Renders as <a> with this href. */
		href?: string;
		/** Link target (when href is set). */
		target?: string;
		/** Rel attribute for anchor. */
		rel?: string;
		/** Ember route name. When provided, renders via <LinkTo>. */
		route?: string;
		/** Single dynamic segment model for the route. */
		model?: unknown;
		/** Multiple dynamic segment models for the route. */
		models?: unknown[];
		/** Query params hash for the route. */
		query?: Record<string, unknown>;
		/** Custom colors override (backgroundColor + color). */
		colors?: { backgroundColor: string; color: string };
		type?: "button" | "submit" | "reset";
		overrides?: ButtonOverrides;
	};
	Blocks: {
		default: [];
		startEnhancer: [];
		endEnhancer: [];
	};
	Element: HTMLButtonElement | HTMLAnchorElement;
}

export type { SpinnerOverrides };

