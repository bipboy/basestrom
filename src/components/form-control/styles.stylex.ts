/**
 * FormControl styles - port from baseweb form-control.
 *
 * Visual structure (top → bottom):
 *
 *   labelContainer       (flex row)
 *     ├── label          (font250)
 *     └── labelEndEnhancer (font100, optional)
 *   controlContainer
 *     ├── <yielded child>
 *     └── caption        (font100, with optional icon + message)
 */
import * as stylex from "@stylexjs/stylex";
import { colors, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Label container (row with label + end enhancer) ────────────────────────
	labelContainer: {
		display: "flex",
		width: "100%",
		alignItems: "flex-start",
		justifyContent: "space-between",
		marginTop: sizing.scale300,
		marginRight: 0,
		marginBottom: sizing.scale300,
		marginLeft: 0,
	},

	// ─── Label ──────────────────────────────────────────────────────────────────
	// baseweb uses font250: 14px / 500 / 16px line-height
	label: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "16px",
		flex: 1,
		color: colors.contentPrimary,
		display: "block",
		paddingTop: 0,
		paddingRight: 0,
		paddingBottom: 0,
		paddingLeft: 0,
	},
	labelDisabled: {
		color: colors.contentSecondary,
	},

	// ─── Label end enhancer ─────────────────────────────────────────────────────
	// baseweb uses font100: 12px / normal (400) / 20px
	labelEndEnhancer: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "12px",
		fontWeight: 400,
		lineHeight: "20px",
		flex: "unset",
		width: "auto",
		color: colors.contentPrimary,
		whiteSpace: "nowrap",
		textAlign: "end",
		marginLeft: sizing.scale200,
	},
	labelEndEnhancerDisabled: {
		color: colors.contentStateDisabled,
	},
	labelEndEnhancerError: {
		color: colors.contentNegative,
	},

	// ─── Caption (under the input) ──────────────────────────────────────────────
	// baseweb uses font100: 12px / normal (400) / 20px
	caption: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "12px",
		fontWeight: 400,
		lineHeight: "20px",
		color: colors.contentTertiary,
		paddingTop: 0,
		paddingRight: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		marginTop: sizing.scale300,
		marginRight: 0,
		marginBottom: sizing.scale300,
		marginLeft: 0,
		display: "flex",
	},
	captionError: {
		color: colors.contentNegative,
	},
	captionPositive: {
		color: colors.contentPositive,
	},

	// ─── Caption inner ──────────────────────────────────────────────────────────
	captionIcon: {
		display: "flex",
		paddingTop: sizing.scale100,
		paddingRight: sizing.scale100,
		flexShrink: 0,
	},
	captionMessage: {
		fontFamily: "inherit",
		fontSize: "inherit",
		fontWeight: "inherit",
		lineHeight: "inherit",
		flexGrow: 1,
	},

	// ─── Control container (wraps the yielded input + caption) ──────────────────
	controlContainer: {
		width: "100%",
		marginBottom: sizing.scale600,
	},
});
