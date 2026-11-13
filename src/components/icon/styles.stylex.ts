/**
 * Icon styles - port from baseweb icon.
 *
 * Default visuals:
 * - Inline-block, square box (width = height = scale600 = 16px)
 * - fill = currentColor (so the icon inherits text color)
 *
 * Custom dimensions (`@size` as CSS length) and colors (`@color` as CSS color)
 * are applied as inline styles on top of these classes.
 */
import * as stylex from "@stylexjs/stylex";
import { sizing } from "../../themes/vars.stylex";

export const styles = stylex.create({
	base: {
		display: "inline-block",
		fill: "currentColor",
		color: "currentColor",
		width: sizing.scale600,
		height: sizing.scale600,
		flexShrink: 0,
	},
});
