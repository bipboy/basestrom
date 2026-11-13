import * as stylex from "@stylexjs/stylex";
import { colors, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	root: {
		display: "flex",
		alignItems: "center",
		color: colors.contentPrimary,
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "20px",
	},
	maxLabel: {
		marginLeft: sizing.scale300,
		marginRight: sizing.scale600,
	},
	dropdownContainer: {
		position: "relative",
		marginLeft: sizing.scale600,
		marginRight: sizing.scale300,
	},
});
