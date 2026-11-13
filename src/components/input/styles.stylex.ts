/**
 * Input styles - complete port from baseweb input styled-components.
 *
 * Maps baseweb's input color tokens to basestrom's semantic color vars:
 * - inputFill → transparent
 * - inputFillDisabled → backgroundStateDisabled
 * - inputFillActive → transparent
 * - inputFillError → transparent
 * - inputFillPositive → transparent
 * - inputBorder → backgroundTertiary (#E8E8E8)
 * - inputBorderError → borderNegative (#DE1135)
 * - inputBorderPositive → borderPositive (#0E8345)
 * - borderSelected → borderSelected (#000000)
 * - inputTextDisabled → contentStateDisabled
 * - inputPlaceholder → contentTertiary
 * - inputPlaceholderDisabled → contentStateDisabled
 * - inputEnhancerTextDisabled → contentStateDisabled
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	radii,
	sizing,
	typography,
} from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root ───────────────────────────────────────────────────────────────────
	root: {
		boxSizing: "border-box",
		display: "flex",
		overflow: "hidden",
		width: "100%",
		borderLeftWidth: "2px",
		borderRightWidth: "2px",
		borderTopWidth: "2px",
		borderBottomWidth: "2px",
		borderLeftStyle: "solid",
		borderRightStyle: "solid",
		borderTopStyle: "solid",
		borderBottomStyle: "solid",
		borderTopLeftRadius: radii.inputBorderRadius,
		borderTopRightRadius: radii.inputBorderRadius,
		borderBottomLeftRadius: radii.inputBorderRadius,
		borderBottomRightRadius: radii.inputBorderRadius,
		transitionProperty: "border, background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
		fontFamily: typography.primaryFontFamily,
	},
	rootDefault: {
		borderLeftColor: colors.borderOpaque,
		borderRightColor: colors.borderOpaque,
		borderTopColor: colors.borderOpaque,
		borderBottomColor: colors.borderOpaque,
		backgroundColor: colors.backgroundSecondary,
	},
	rootMini: {
		borderTopLeftRadius: radii.inputBorderRadiusMini,
		borderTopRightRadius: radii.inputBorderRadiusMini,
		borderBottomLeftRadius: radii.inputBorderRadiusMini,
		borderBottomRightRadius: radii.inputBorderRadiusMini,
	},

	// ─── Adjoined border-radius overrides ───────────────────────────────────────
	// For grouping inputs: strip border-radius on the adjoined side.
	// Border width stays at 2px everywhere so focused state looks uniform.
	adjoinedLeft: {
		borderTopRightRadius: 0,
		borderBottomRightRadius: 0,
	},
	adjoinedRight: {
		borderTopLeftRadius: 0,
		borderBottomLeftRadius: 0,
	},
	adjoinedBoth: {
		borderTopLeftRadius: 0,
		borderTopRightRadius: 0,
		borderBottomLeftRadius: 0,
		borderBottomRightRadius: 0,
	},
	rootFocused: {
		borderLeftColor: colors.borderSelected,
		borderRightColor: colors.borderSelected,
		borderTopColor: colors.borderSelected,
		borderBottomColor: colors.borderSelected,
		backgroundColor: colors.backgroundPrimary,
	},
	rootError: {
		borderLeftColor: colors.negative,
		borderRightColor: colors.negative,
		borderTopColor: colors.negative,
		borderBottomColor: colors.negative,
		backgroundColor: colors.backgroundPrimary,
	},
	rootPositive: {
		borderLeftColor: colors.borderPositive,
		borderRightColor: colors.borderPositive,
		borderTopColor: colors.borderPositive,
		borderBottomColor: colors.borderPositive,
		backgroundColor: colors.backgroundPrimary,
	},
	rootDisabled: {
		borderLeftColor: colors.backgroundStateDisabled,
		borderRightColor: colors.backgroundStateDisabled,
		borderTopColor: colors.backgroundStateDisabled,
		borderBottomColor: colors.backgroundStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
	},

	// Root padding for enhancers / icon trailing
	rootPaddingLeft: {
		paddingLeft: sizing.scale550,
	},
	rootPaddingRight: {
		paddingRight: sizing.scale550,
	},

	// ─── Size fonts (applied to root, propagated) ───────────────────────────────
	// Maps to baseweb typography: font100, font200, font300, font400
	fontMini: {
		fontSize: "12px",
		fontWeight: "normal",
		lineHeight: "20px",
	},
	fontCompact: {
		fontSize: "14px",
		fontWeight: "normal",
		lineHeight: "20px",
	},
	fontDefault: {
		fontSize: "16px",
		fontWeight: "normal",
		lineHeight: "24px",
	},
	fontLarge: {
		fontSize: "18px",
		fontWeight: "normal",
		lineHeight: "28px",
	},

	// ─── InputContainer ─────────────────────────────────────────────────────────
	inputContainer: {
		display: "flex",
		width: "100%",
		transitionProperty: "background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
	},
	inputContainerDefault: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundSecondary,
	},
	inputContainerFocused: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},
	inputContainerError: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},
	inputContainerPositive: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},
	inputContainerDisabled: {
		color: colors.contentStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
	},

	// ─── Input element ──────────────────────────────────────────────────────────
	input: {
		boxSizing: "border-box",
		backgroundColor: "transparent",
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftStyle: "none",
		borderRightStyle: "none",
		borderTopStyle: "none",
		borderBottomStyle: "none",
		outline: "none",
		width: "100%",
		minWidth: 0,
		maxWidth: "100%",
		cursor: "text",
		margin: "0",
		fontFamily: "inherit",
		fontSize: "inherit",
		fontWeight: "inherit",
		lineHeight: "inherit",
		color: colors.contentPrimary,
		caretColor: colors.contentPrimary,
		"::placeholder": {
			color: colors.contentTertiary,
		},
	},
	inputDisabled: {
		cursor: "not-allowed",
		color: colors.contentStateDisabled,
		WebkitTextFillColor: colors.contentStateDisabled,
		caretColor: colors.contentPrimary,
		"::placeholder": {
			color: colors.contentStateDisabled,
		},
	},

	// Input padding by size
	inputPaddingMini: {
		paddingTop: sizing.scale100,
		paddingBottom: sizing.scale100,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	inputPaddingCompact: {
		paddingTop: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	inputPaddingDefault: {
		paddingTop: sizing.scale400,
		paddingBottom: sizing.scale400,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	inputPaddingLarge: {
		paddingTop: sizing.scale550,
		paddingBottom: sizing.scale550,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},

	// ─── Enhancers ──────────────────────────────────────────────────────────────
	startEnhancer: {
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		transitionProperty: "color, background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
	},
	startEnhancerDefault: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundSecondary,
	},
	endEnhancer: {
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		transitionProperty: "color, background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
	},
	endEnhancerDefault: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundSecondary,
	},
	enhancerDisabled: {
		color: colors.contentStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
	},
	enhancerFocused: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},
	enhancerError: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},
	enhancerPositive: {
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundPrimary,
	},

	// Enhancer padding by size
	enhancerPaddingMini: {
		paddingRight: sizing.scale400,
		paddingLeft: sizing.scale400,
	},
	enhancerPaddingCompact: {
		paddingRight: sizing.scale400,
		paddingLeft: sizing.scale400,
	},
	enhancerPaddingDefault: {
		paddingRight: sizing.scale300,
		paddingLeft: sizing.scale300,
	},
	enhancerPaddingLarge: {
		paddingRight: sizing.scale200,
		paddingLeft: sizing.scale200,
	},

	// ─── Clear icon ─────────────────────────────────────────────────────────────
	clearIconContainer: {
		display: "flex",
		alignItems: "center",
		alignSelf: "center",
		color: colors.contentPrimary,
	},
	clearIconContainerPaddingMini: {
		paddingLeft: sizing.scale200,
		paddingRight: sizing.scale200,
	},
	clearIconContainerPaddingCompact: {
		paddingLeft: sizing.scale200,
		paddingRight: sizing.scale200,
	},
	clearIconContainerPaddingDefault: {
		paddingLeft: sizing.scale100,
		paddingRight: sizing.scale100,
	},
	clearIconContainerPaddingLarge: {
		paddingLeft: sizing.scale0,
		paddingRight: sizing.scale0,
	},
	clearIcon: {
		cursor: "pointer",
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		outline: "none",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		backgroundColor: "transparent",
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
		color: "inherit",
		lineHeight: 0,
	},
	clearIconFocusVisible: {
		outline: `solid 3px ${colors.borderAccent}`,
	},

	// ─── Mask toggle button ─────────────────────────────────────────────────────
	maskToggleButton: {
		display: "flex",
		alignItems: "center",
		alignSelf: "center",
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		backgroundColor: "transparent",
		outline: "none",
		color: colors.contentPrimary,
		cursor: "pointer",
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
	},
	maskTogglePaddingMini: {
		paddingLeft: sizing.scale400,
		paddingRight: sizing.scale400,
	},
	maskTogglePaddingCompact: {
		paddingLeft: sizing.scale400,
		paddingRight: sizing.scale400,
	},
	maskTogglePaddingDefault: {
		paddingLeft: sizing.scale300,
		paddingRight: sizing.scale300,
	},
	maskTogglePaddingLarge: {
		paddingLeft: sizing.scale200,
		paddingRight: sizing.scale200,
	},
	maskToggleFocusVisible: {
		outline: `solid 3px ${colors.borderAccent}`,
	},
});
