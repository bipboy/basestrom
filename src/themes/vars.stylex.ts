/**
 * StyleX theme variables.
 *
 * These are the compile-time CSS custom properties that components reference.
 * The default values here correspond to the light theme.
 * Use `stylex.createTheme(colors, {...})` to create dark/custom theme overrides.
 *
 * Components import these vars and use them in stylex.create():
 *
 * ```ts
 * import { colors, sizing, typography } from 'basestrom/themes/vars.stylex';
 *
 * const styles = stylex.create({
 *   root: {
 *     backgroundColor: colors.backgroundPrimary,
 *     padding: sizing.scale300,
 *   }
 * });
 * ```
 */
import * as stylex from "@stylexjs/stylex";

/**
 * Color tokens - semantic colors used by components.
 * Default values = light theme.
 */
export const colors = stylex.defineVars({
	// Foundation
	primaryA: "#000000",
	primaryB: "#FFFFFF",
	accent: "#276EF1",
	negative: "#DE1135",
	warning: "#F6BC2F",
	positive: "#0E8345",

	// Background
	backgroundPrimary: "#FFFFFF",
	backgroundSecondary: "#F3F3F3",
	backgroundTertiary: "#E8E8E8",
	backgroundInversePrimary: "#000000",
	backgroundInverseSecondary: "#282828",
	backgroundStateDisabled: "#F3F3F3",
	backgroundOverlay: "rgba(0, 0, 0, 0.5)",
	backgroundAccent: "#276EF1",
	backgroundNegative: "#DE1135",
	backgroundWarning: "#F6BC2F",
	backgroundPositive: "#0E8345",
	backgroundAccentLight: "#EFF4FE",
	backgroundNegativeLight: "#FFF0EE",
	backgroundWarningLight: "#FDF2DC",
	backgroundPositiveLight: "#EAF6ED",
	backgroundAlwaysDark: "#000000",
	backgroundAlwaysLight: "#FFFFFF",

	// Content
	contentPrimary: "#000000",
	contentSecondary: "#4B4B4B",
	contentTertiary: "#5E5E5E",
	contentInversePrimary: "#FFFFFF",
	contentInverseSecondary: "#DDDDDD",
	contentInverseTertiary: "#A6A6A6",
	contentStateDisabled: "#A6A6A6",
	contentAccent: "#276EF1",
	contentNegative: "#DE1135",
	contentWarning: "#9F6402",
	contentPositive: "#0E8345",
	contentOnColor: "#FFFFFF",
	contentOnColorInverse: "#000000",

	// Border
	borderOpaque: "#F3F3F3",
	borderTransparent: "rgba(0, 0, 0, 0.08)",
	borderSelected: "#000000",
	borderInverseOpaque: "#4B4B4B",
	borderInverseTransparent: "rgba(255, 255, 255, 0.2)",
	borderInverseSelected: "#FFFFFF",
	borderStateDisabled: "#F3F3F3",
	borderAccent: "#276EF1",
	borderAccentLight: "#A9C9FF",
	borderNegative: "#DE1135",
	borderNegativeLight: "#FFB2AB",
	borderWarning: "#9F6402",
	borderWarningLight: "#FFD688",
	borderPositive: "#0E8345",
	borderPositiveLight: "#7FD99A",

	// Brand
	brandBackgroundPrimary: "#276EF1",
	brandContentPrimary: "#276EF1",
	brandBorderAccessible: "#276EF1",

	// Hover/Pressed
	hoverOverlayAlpha: "rgba(0, 0, 0, 0.04)",
	pressedOverlayAlpha: "rgba(0, 0, 0, 0.08)",
	hoverOverlayInverseAlpha: "rgba(255, 255, 255, 0.1)",
	pressedOverlayInverseAlpha: "rgba(255, 255, 255, 0.2)",
	hoverNegativeAlpha: "rgba(222, 17, 53, 0.1)",
	pressedNegativeAlpha: "rgba(222, 17, 53, 0.15)",

	// Link
	linkText: "#000000",
	linkVisited: "#727272",
	linkHover: "#4B4B4B",
	linkActive: "#000000",
});

/**
 * Sizing tokens.
 */
export const sizing = stylex.defineVars({
	scale0: "2px",
	scale100: "4px",
	scale200: "6px",
	scale300: "8px",
	scale400: "10px",
	scale500: "12px",
	scale550: "14px",
	scale600: "16px",
	scale650: "18px",
	scale700: "20px",
	scale750: "22px",
	scale800: "24px",
	scale850: "28px",
	scale900: "32px",
	scale950: "36px",
	scale1000: "40px",
	scale1200: "48px",
	scale1400: "56px",
	scale1600: "64px",
	scale2400: "96px",
	scale3200: "128px",
	scale4800: "192px",
});

/**
 * Typography tokens - font families.
 */
export const typography = stylex.defineVars({
	primaryFontFamily:
		'IBM Plex Sans, system-ui, "Helvetica Neue", Helvetica, Arial, sans-serif',
	secondaryFontFamily:
		'IBM Plex Sans, system-ui, "Helvetica Neue", Helvetica, Arial, sans-serif',
	monoFontFamily: 'IBM Plex Mono, "Lucida Console", Monaco, monospace',
});

/**
 * Border radius tokens.
 */
export const radii = stylex.defineVars({
	radius100: "2px",
	radius200: "4px",
	radius300: "8px",
	radius400: "12px",
	radius500: "16px",
	buttonBorderRadius: "8px",
	buttonBorderRadiusMini: "4px",
	inputBorderRadius: "8px",
	inputBorderRadiusMini: "4px",
	popoverBorderRadius: "8px",
	surfaceBorderRadius: "0px",
	tagBorderRadius: "24px",
});

/**
 * Lighting tokens - shadows and overlays.
 */
export const lighting = stylex.defineVars({
	shadow400: "0 1px 4px hsla(0, 0%, 0%, 0.16)",
	shadow500: "0 2px 8px hsla(0, 0%, 0%, 0.16)",
	shadow600: "0 4px 16px hsla(0, 0%, 0%, 0.16)",
	shadow700: "0 8px 24px hsla(0, 0%, 0%, 0.16)",
	overlay0: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0)",
	overlay100: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.04)",
	overlay200: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.08)",
	overlay300: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.12)",
	overlay400: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.16)",
	overlay500: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.2)",
	overlay600: "inset 0 0 0 1000px hsla(0, 0%, 0%, 0.24)",
	shallowAbove: "0px -4px 16px rgba(0, 0, 0, 0.12)",
	shallowBelow: "0px 4px 16px rgba(0, 0, 0, 0.12)",
	deepAbove: "0px -16px 48px rgba(0, 0, 0, 0.22)",
	deepBelow: "0px 16px 48px rgba(0, 0, 0, 0.22)",
});

/**
 * Animation tokens - durations and easing.
 */
export const animation = stylex.defineVars({
	timing100: "100ms",
	timing200: "200ms",
	timing300: "300ms",
	timing400: "400ms",
	timing500: "500ms",
	easeOutCurve: "cubic-bezier(0.2, 0.8, 0.4, 1)",
	easeDecelerate: "cubic-bezier(0.22, 1, 0.36, 1)",
	easeAccelerate: "cubic-bezier(0.64, 0, 0.78, 0)",
	easeAccelerateDecelerate: "cubic-bezier(0.83, 0, 0.17, 1)",
	easeInOutQuinticCurve: "cubic-bezier(0.86, 0, 0.07, 1)",
	easeLinear: "cubic-bezier(0, 0, 1, 1)",
	linearCurve: "cubic-bezier(0, 0, 1, 1)",
});
