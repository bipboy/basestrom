/**
 * Radio styles - full port from baseweb radio-v2.
 * Uses correct StyleX conditional values syntax for pseudo-classes.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	sizing,
	typography,
} from "../../themes/vars.stylex";

// --- RadioGroup ---
export const groupStyles = stylex.create({
	root: {
		display: "flex",
		flexWrap: "wrap",
		flexDirection: "column",
		alignItems: "flex-start",
		rowGap: sizing.scale300,
		columnGap: sizing.scale600,
	},
	horizontal: {
		flexDirection: "row",
	},
});

// --- Radio ---
export const radioStyles = stylex.create({
	// Root (label)
	root: {
		display: "inline-flex",
		flexDirection: "row",
		alignItems: "flex-start",
		cursor: "pointer",
		columnGap: sizing.scale100,
		rowGap: sizing.scale100,
	},
	rootDisabled: {
		cursor: "not-allowed",
	},
	rootLabelLeft: {
		flexDirection: "row-reverse",
	},

	// Backplate (state layer around the radio mark)
	backplate: {
		position: "relative",
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		boxSizing: "border-box",
		borderRadius: sizing.scale300,
		padding: sizing.scale300,
		minHeight: sizing.scale900,
		minWidth: sizing.scale900,
		backgroundColor: {
			default: "transparent",
			":hover": colors.hoverOverlayAlpha,
			":active": colors.pressedOverlayAlpha,
		},
		transitionProperty: "background-color",
		transitionDuration: animation.timing100,
	},
	backplateError: {
		backgroundColor: {
			default: "transparent",
			":hover": colors.hoverNegativeAlpha,
			":active": colors.pressedNegativeAlpha,
		},
	},
	backplateDisabled: {
		backgroundColor: {
			default: "transparent",
			":hover": "transparent",
			":active": "transparent",
		},
	},

	// Outer ring
	markOuter: {
		display: "flex",
		height: "17px",
		width: "17px",
		alignItems: "center",
		justifyContent: "center",
		flexShrink: 0,
		boxSizing: "border-box",
		borderWidth: sizing.scale0,
		borderStyle: "solid",
		borderColor: colors.contentPrimary,
		backgroundColor: colors.contentPrimary,
		borderRadius: "50%",
		verticalAlign: "middle",
	},
	markOuterDisabled: {
		borderColor: colors.contentStateDisabled,
		backgroundColor: colors.contentStateDisabled,
	},
	markOuterError: {
		borderColor: colors.borderNegative,
		backgroundColor: colors.borderNegative,
	},
	markOuterFocusVisible: {
		outline: `3px solid ${colors.borderAccent}`,
		outlineOffset: "2px",
	},

	// Inner dot
	markInner: {
		borderRadius: "50%",
		width: "100%",
		height: "100%",
		backgroundColor: colors.contentInversePrimary,
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
		transitionProperty: "width, height",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
	},
	markInnerChecked: {
		width: "5px",
		height: "5px",
	},
	markInnerDisabled: {
		boxShadow: {
			default: "none",
			":hover": "none",
			":active": "none",
		},
	},

	// Label wrapper
	labelWrapper: {
		display: "flex",
		flexDirection: "column",
		alignItems: "flex-start",
		paddingTop: sizing.scale300,
		rowGap: sizing.scale0,
	},
	labelWrapperHorizontal: {
		maxWidth: "240px",
	},

	// Label text
	label: {
		verticalAlign: "middle",
		color: colors.contentPrimary,
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "16px",
	},
	labelDisabled: {
		color: colors.contentSecondary,
	},
	labelTruncate: {
		overflow: "hidden",
		textOverflow: "ellipsis",
		display: "-webkit-box",
		WebkitLineClamp: 3,
		WebkitBoxOrient: "vertical",
	},

	// Description
	description: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: "normal",
		lineHeight: "20px",
		color: colors.contentSecondary,
		cursor: "auto",
	},
	descriptionTruncate: {
		overflow: "hidden",
		textOverflow: "ellipsis",
		display: "-webkit-box",
		WebkitLineClamp: 3,
		WebkitBoxOrient: "vertical",
	},

	// Hidden input
	input: {
		width: 0,
		height: 0,
		margin: 0,
		padding: 0,
		clip: "rect(0 0 0 0)",
		position: "absolute",
	},
});
