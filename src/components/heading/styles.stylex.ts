/**
 * Heading styles - port from baseweb heading.
 *
 * The Heading component renders h1-h6 based on HeadingLevel context,
 * with font styles mapped to the level:
 *   Level 1: font1050 = 40px/700/52px (secondaryFontFamily)
 *   Level 2: font950  = 36px/700/44px
 *   Level 3: font850  = 32px/700/40px
 *   Level 4: font750  = 28px/700/36px
 *   Level 5: font650  = 24px/700/32px
 *   Level 6: font550  = 20px/700/28px
 *
 * The styleLevel prop can override the visual style independently of the semantic level.
 */
import * as stylex from "@stylexjs/stylex";
import { colors, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	base: {
		color: colors.contentPrimary,
		marginTop: 0,
		marginBottom: 0,
		marginLeft: 0,
		marginRight: 0,
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
	},

	// Level 1: font1050
	level1: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "40px",
		fontWeight: 700,
		lineHeight: "52px",
	},

	// Level 2: font950
	level2: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "36px",
		fontWeight: 700,
		lineHeight: "44px",
	},

	// Level 3: font850
	level3: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "32px",
		fontWeight: 700,
		lineHeight: "40px",
	},

	// Level 4: font750
	level4: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "28px",
		fontWeight: 700,
		lineHeight: "36px",
	},

	// Level 5: font650
	level5: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "24px",
		fontWeight: 700,
		lineHeight: "32px",
	},

	// Level 6: font550
	level6: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "20px",
		fontWeight: 700,
		lineHeight: "28px",
	},
});
