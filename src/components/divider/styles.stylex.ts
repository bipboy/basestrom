/**
 * Divider styles - matches baseweb original.
 * Uses border-top (not background) for the line.
 * SIZE.module uses a thicker border (scale100 = 4px).
 */
import * as stylex from "@stylexjs/stylex";
import { colors, sizing } from "../../themes/vars.stylex";

export const styles = stylex.create({
	base: {
		borderRightWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderTopColor: colors.borderOpaque,
		borderTopStyle: "solid",
		margin: 0,
		padding: 0,
		width: "100%",
	},
	cell: {
		borderTopWidth: "1px",
	},
	section: {
		borderTopWidth: "1px",
	},
	module: {
		borderTopWidth: sizing.scale100,
	},
});
