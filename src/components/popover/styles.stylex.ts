/**
 * Popover styles - port from baseweb popover styled-components.
 * All declarations use longhand CSS properties only.
 */
import * as stylex from "@stylexjs/stylex";
import { colors, lighting, radii } from "../../themes/vars.stylex";

/**
 * Arrow size constant from Base Web.
 * ARROW_SIZE = 6; ARROW_WIDTH = ceil(sqrt((6*2)^2 / 2)) = 9
 */
const ARROW_WIDTH = 9;

export const styles = stylex.create({
	// --- Body: main popover surface ---
	body: {
		position: "relative",
		backgroundColor: colors.backgroundTertiary,
		boxShadow: lighting.shadow500,
		borderTopLeftRadius: radii.radius300,
		borderTopRightRadius: radii.radius300,
		borderBottomLeftRadius: radii.radius300,
		borderBottomRightRadius: radii.radius300,
		transitionProperty: "opacity,transform",
		transitionDuration: "0.1s",
		transitionTimingFunction: "ease-out",
	},

	// --- Inner: content holder clipping arrow overlap ---
	inner: {
		backgroundColor: colors.backgroundTertiary,
		borderTopLeftRadius: radii.radius300,
		borderTopRightRadius: radii.radius300,
		borderBottomLeftRadius: radii.radius300,
		borderBottomRightRadius: radii.radius300,
		color: colors.contentPrimary,
		position: "relative",
	},

	// --- Arrow: 45°-rotated square ---
	arrow: {
		backgroundColor: colors.backgroundTertiary,
		boxShadow: lighting.shadow500,
		width: `${ARROW_WIDTH}px`,
		height: `${ARROW_WIDTH}px`,
		transform: "rotate(45deg)",
		position: "absolute",
	},

	// --- Per-side margin styles for popoverMargin ---
	bodyMarginTop: {
		marginTop: "8px",
	},

	bodyMarginBottom: {
		marginBottom: "8px",
	},

	bodyMarginLeft: {
		marginLeft: "8px",
	},

	bodyMarginRight: {
		marginRight: "8px",
	},
});
