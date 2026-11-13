/**
 * Dark theme - StyleX theme override.
 *
 * Apply this to a container element to switch all descendant components to dark mode:
 *
 * ```ts
 * import { darkColorTheme } from 'basestrom/themes/dark.stylex';
 * import * as stylex from '@stylexjs/stylex';
 *
 * // Apply to root:
 * <div {{stylex darkColorTheme}}>...</div>
 * ```
 */
import * as stylex from "@stylexjs/stylex";
import { colors } from "./vars.stylex";

export const darkColorTheme = stylex.createTheme(colors, {
	// Foundation
	primaryA: "#DEDEDE",
	primaryB: "#161616",
	accent: "#335BA3",
	negative: "#A32C34",
	warning: "#7A5616",
	positive: "#306C44",

	// Background
	backgroundPrimary: "#161616",
	backgroundSecondary: "#292929",
	backgroundTertiary: "#383838",
	backgroundInversePrimary: "#C4C4C4",
	backgroundInverseSecondary: "#ABABAB",
	backgroundStateDisabled: "#292929",
	backgroundOverlay: "rgba(0, 0, 0, 0.7)",
	backgroundAccent: "#335BA3",
	backgroundNegative: "#A32C34",
	backgroundWarning: "#7A5616",
	backgroundPositive: "#306C44",
	backgroundAccentLight: "#182946",
	backgroundNegativeLight: "#4A1216",
	backgroundWarningLight: "#39240A",
	backgroundPositiveLight: "#162F1E",
	backgroundAlwaysDark: "#292929",
	backgroundAlwaysLight: "#DEDEDE",

	// Content
	contentPrimary: "#DEDEDE",
	contentSecondary: "#C4C4C4",
	contentTertiary: "#ABABAB",
	contentInversePrimary: "#000000",
	contentInverseSecondary: "#383838",
	contentInverseTertiary: "#484848",
	contentStateDisabled: "#5D5D5D",
	contentAccent: "#5E8BDB",
	contentNegative: "#DE5B5D",
	contentWarning: "#AE8523",
	contentPositive: "#5C9D70",
	contentOnColor: "#DEDEDE",
	contentOnColorInverse: "#000000",

	// Border
	borderOpaque: "#292929",
	borderTransparent: "rgba(222, 222, 222, 0.08)",
	borderSelected: "#DEDEDE",
	borderInverseOpaque: "#484848",
	borderInverseTransparent: "rgba(22, 22, 22, 0.2)",
	borderInverseSelected: "#161616",
	borderStateDisabled: "#292929",
	borderAccent: "#3F6EC5",
	borderAccentLight: "#335BA3",
	borderNegative: "#C33840",
	borderNegativeLight: "#A32C34",
	borderWarning: "#916C1A",
	borderWarningLight: "#7A5616",
	borderPositive: "#3D8351",
	borderPositiveLight: "#306C44",

	// Brand
	brandBackgroundPrimary: "#3F6EC5",
	brandContentPrimary: "#5E8BDB",
	brandBorderAccessible: "#5E8BDB",

	// Hover/Pressed
	hoverOverlayAlpha: "rgba(255, 255, 255, 0.1)",
	pressedOverlayAlpha: "rgba(255, 255, 255, 0.15)",
	hoverOverlayInverseAlpha: "rgba(0, 0, 0, 0.04)",
	pressedOverlayInverseAlpha: "rgba(0, 0, 0, 0.08)",
});
