/**
 * Textarea styles - full port from baseweb textarea styled-components.
 *
 * Maps baseweb's getRootStyles, getInputContainerStyles, and getInputStyles
 * to StyleX static styles with size/state variants.
 *
 * Architecture matches baseweb's 3-layer structure:
 *   Root (border container) > InputContainer (background) > Textarea (input element)
 *
 * Color mapping (same as input component):
 * - inputFill → transparent
 * - inputFillDisabled → backgroundStateDisabled
 * - inputFillActive → transparent
 * - inputFillError → transparent
 * - inputFillPositive → transparent
 * - inputBorder → backgroundTertiary (#E8E8E8)
 * - inputBorderError → negative (#DE1135)
 * - inputBorderPositive → borderPositive (#0E8345)
 * - borderSelected → borderSelected (#000000)
 * - inputTextDisabled → contentStateDisabled
 * - inputPlaceholder → contentTertiary
 * - inputPlaceholderDisabled → contentStateDisabled
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
	// ─── Root wrapper (border container) ────────────────────────────────────────
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
		borderLeftColor: colors.borderOpaque,
		borderRightColor: colors.borderOpaque,
		borderTopColor: colors.borderOpaque,
		borderBottomColor: colors.borderOpaque,
		backgroundColor: colors.backgroundSecondary,
		transitionProperty: "border",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
		fontFamily: typography.primaryFontFamily,
	},

	// Root size variant: mini border radius
	rootMini: {
		borderTopLeftRadius: radii.inputBorderRadiusMini,
		borderTopRightRadius: radii.inputBorderRadiusMini,
		borderBottomLeftRadius: radii.inputBorderRadiusMini,
		borderBottomRightRadius: radii.inputBorderRadiusMini,
	},

	// Root state: focused
	rootFocused: {
		borderLeftColor: colors.borderSelected,
		borderRightColor: colors.borderSelected,
		borderTopColor: colors.borderSelected,
		borderBottomColor: colors.borderSelected,
		backgroundColor: colors.backgroundPrimary,
	},

	// Root state: error
	rootError: {
		borderLeftColor: colors.negative,
		borderRightColor: colors.negative,
		borderTopColor: colors.negative,
		borderBottomColor: colors.negative,
		backgroundColor: colors.backgroundPrimary,
	},

	// Root state: positive
	rootPositive: {
		borderLeftColor: colors.borderPositive,
		borderRightColor: colors.borderPositive,
		borderTopColor: colors.borderPositive,
		borderBottomColor: colors.borderPositive,
		backgroundColor: colors.backgroundPrimary,
	},

	// Root state: disabled
	rootDisabled: {
		borderLeftColor: colors.backgroundStateDisabled,
		borderRightColor: colors.backgroundStateDisabled,
		borderTopColor: colors.backgroundStateDisabled,
		borderBottomColor: colors.backgroundStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
	},

	// Root resize: fit-content width when resize is set
	rootResizable: {
		width: "fit-content",
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

	// ─── InputContainer (background layer) ──────────────────────────────────────
	inputContainer: {
		display: "flex",
		width: "100%",
		transitionProperty: "background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
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

	// ─── Textarea element ───────────────────────────────────────────────────────
	textarea: {
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

	// Textarea disabled state
	textareaDisabled: {
		cursor: "not-allowed",
		color: colors.contentStateDisabled,
		WebkitTextFillColor: colors.contentStateDisabled,
		caretColor: colors.contentPrimary,
		"::placeholder": {
			color: colors.contentStateDisabled,
		},
	},

	// ─── Textarea resize variants ───────────────────────────────────────────────
	resizeNone: {
		resize: "none",
	},
	resizeVertical: {
		resize: "vertical",
	},
	resizeHorizontal: {
		resize: "horizontal",
	},
	resizeBoth: {
		resize: "both",
	},

	// ─── Size variants (padding) ────────────────────────────────────────────────
	// Font is inherited from root; padding is set on the textarea element.
	// mini: padding 4px top/bottom, 14px left/right
	sizeMini: {
		paddingTop: sizing.scale100,
		paddingBottom: sizing.scale100,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	// compact: padding 6px top/bottom, 14px left/right
	sizeCompact: {
		paddingTop: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	// default: padding 10px top/bottom, 14px left/right
	sizeDefault: {
		paddingTop: sizing.scale400,
		paddingBottom: sizing.scale400,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},
	// large: padding 14px top/bottom, 14px left/right
	sizeLarge: {
		paddingTop: sizing.scale550,
		paddingBottom: sizing.scale550,
		paddingLeft: sizing.scale550,
		paddingRight: sizing.scale550,
	},

	// ─── Character counter ──────────────────────────────────────────────────────
	// Not in baseweb - custom addition for basestrom.
	counter: {
		display: "flex",
		justifyContent: "flex-end",
		fontFamily: typography.primaryFontFamily,
		fontSize: "12px",
		lineHeight: "20px",
		fontWeight: "normal",
		color: colors.contentTertiary,
		paddingTop: sizing.scale100,
		paddingRight: sizing.scale0,
	},
	counterError: {
		color: colors.negative,
	},
});
