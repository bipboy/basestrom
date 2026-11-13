/**
 * Combobox styles - port from baseweb combobox styled-components.
 * All declarations use longhand CSS properties only.
 */
import * as stylex from "@stylexjs/stylex";
import {
	colors,
	lighting,
	radii,
	sizing,
	typography,
} from "../../themes/vars.stylex";

export const styles = stylex.create({
	// --- Root wrapper ---
	root: {
		display: "flex",
		flexDirection: "column",
		position: "relative",
	},

	// --- ListBox (ul) ---
	listBox: {
		backgroundColor: colors.backgroundPrimary,
		marginBlockStart: "unset",
		marginBlockEnd: "unset",
		marginTop: 0,
		marginBottom: 0,
		marginLeft: 0,
		marginRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
		maxHeight: "200px",
		overflowX: "hidden",
		overflowY: "auto",
		outlineStyle: "none",
		boxShadow: lighting.shadow500,
		borderTopLeftRadius: radii.radius300,
		borderTopRightRadius: radii.radius300,
		borderBottomLeftRadius: radii.radius300,
		borderBottomRightRadius: radii.radius300,
		listStyleType: "none",
	},

	// --- ListItem (li) base ---
	listItem: {
		display: "flex",
		alignItems: "center",
		cursor: "default",
		listStyleType: "none",
		fontFamily: typography.primaryFontFamily,
		color: colors.contentPrimary,
		backgroundColor: {
			default: "transparent",
			":hover": colors.hoverOverlayAlpha,
		},
	},

	// --- Size variants ---
	listItemMini: {
		height: "30px",
		paddingLeft: sizing.scale200,
		paddingRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		fontSize: "12px",
		lineHeight: "20px",
	},

	listItemCompact: {
		height: "36px",
		paddingLeft: sizing.scale400,
		paddingRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		fontSize: "14px",
		lineHeight: "20px",
	},

	listItemDefault: {
		height: "48px",
		paddingLeft: sizing.scale550,
		paddingRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		fontSize: "16px",
		lineHeight: "24px",
	},

	listItemLarge: {
		height: "56px",
		paddingLeft: sizing.scale650,
		paddingRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		fontSize: "18px",
		lineHeight: "28px",
	},

	// --- Selected state ---
	listItemSelected: {
		backgroundColor: {
			default: colors.backgroundTertiary,
			":hover": colors.backgroundTertiary,
		},
	},

	// --- Disabled state ---
	listItemDisabled: {
		color: colors.contentStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
		cursor: "not-allowed",
	},
});
