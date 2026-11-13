/**
 * Checkbox styles - full port from baseweb checkbox-v2.
 * Uses correct StyleX conditional values syntax for pseudo-classes.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	sizing,
	typography,
} from "../../themes/vars.stylex";

const checkSvg = `url("data:image/svg+xml,%3Csvg width='17' height='17' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='m10 17.34-4.56-4.56 2.12-2.12L10 13.1l6.44-6.44 2.12 2.12L10 17.34Z' fill='%23FFFFFF'/%3E%3C/svg%3E")`;
const indeterminateSvg = `url("data:image/svg+xml,%3Csvg width='17' height='17' viewBox='0 0 24 24' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M18 10.5H6v3h12v-3Z' fill='%23FFFFFF'/%3E%3C/svg%3E")`;

export const styles = stylex.create({
	// --- Root (label) ---
	root: {
		display: "inline-flex",
		flexDirection: "row",
		verticalAlign: "middle",
		alignItems: "flex-start",
		cursor: "pointer",
		userSelect: "none",
	},
	rootDisabled: {
		cursor: "not-allowed",
	},
	rootLabelLeft: {
		flexDirection: "row-reverse",
	},

	// --- CheckmarkContainer (state layer) ---
	checkmarkContainer: {
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		boxSizing: "border-box",
		minHeight: sizing.scale900,
		minWidth: sizing.scale900,
		borderRadius: sizing.scale300,
		padding: sizing.scale300,
		backgroundColor: {
			default: "transparent",
			":hover": colors.hoverOverlayAlpha,
			":active": colors.pressedOverlayAlpha,
		},
		transitionProperty: "background-color",
		transitionDuration: animation.timing100,
	},
	checkmarkContainerError: {
		backgroundColor: {
			default: "transparent",
			":hover": colors.hoverNegativeAlpha,
			":active": colors.pressedNegativeAlpha,
		},
	},
	checkmarkContainerDisabled: {
		backgroundColor: {
			default: "transparent",
			":hover": "transparent",
			":active": "transparent",
		},
	},

	// --- Checkmark (the visual box) ---
	checkmark: {
		flex: "0 0 auto",
		width: "17px",
		height: "17px",
		boxSizing: "border-box",
		display: "inline-block",
		verticalAlign: "middle",
		borderLeftStyle: "solid",
		borderRightStyle: "solid",
		borderTopStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftWidth: sizing.scale0,
		borderRightWidth: sizing.scale0,
		borderTopWidth: sizing.scale0,
		borderBottomWidth: sizing.scale0,
		borderTopLeftRadius: sizing.scale100,
		borderTopRightRadius: sizing.scale100,
		borderBottomLeftRadius: sizing.scale100,
		borderBottomRightRadius: sizing.scale100,
		borderColor: colors.contentTertiary,
		backgroundColor: "transparent",
		backgroundRepeat: "no-repeat",
		backgroundPosition: "center",
		backgroundImage: "none",
		transitionProperty: "background-image, border-color, background-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,
	},
	checkmarkChecked: {
		borderColor: "transparent",
		backgroundColor: colors.contentPrimary,
		backgroundImage: checkSvg,
	},
	checkmarkIndeterminate: {
		borderColor: "transparent",
		backgroundColor: colors.contentPrimary,
		backgroundImage: indeterminateSvg,
	},
	checkmarkError: {
		borderColor: colors.borderNegative,
	},
	checkmarkErrorChecked: {
		borderColor: "transparent",
		backgroundColor: colors.borderNegative,
		backgroundImage: checkSvg,
	},
	checkmarkErrorIndeterminate: {
		borderColor: "transparent",
		backgroundColor: colors.borderNegative,
		backgroundImage: indeterminateSvg,
	},
	checkmarkDisabled: {
		borderColor: colors.contentStateDisabled,
	},
	checkmarkDisabledChecked: {
		borderColor: "transparent",
		backgroundColor: colors.contentStateDisabled,
		backgroundImage: checkSvg,
	},
	checkmarkDisabledIndeterminate: {
		borderColor: "transparent",
		backgroundColor: colors.contentStateDisabled,
		backgroundImage: indeterminateSvg,
	},
	checkmarkFocusVisible: {
		borderColor: colors.borderSelected,
		outline: `3px solid ${colors.borderAccent}`,
		outlineOffset: "2px",
	},

	// --- Label ---
	label: {
		verticalAlign: "middle",
		paddingTop: sizing.scale200,
		paddingLeft: sizing.scale100,
		color: colors.contentPrimary,
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: "normal",
		lineHeight: "20px",
	},
	labelLeft: {
		paddingLeft: 0,
		paddingRight: sizing.scale100,
	},
	labelDisabled: {
		color: colors.contentStateDisabled,
	},

	// --- Hidden input ---
	input: {
		opacity: 0,
		width: 0,
		height: 0,
		overflow: "hidden",
		margin: 0,
		padding: 0,
		position: "absolute",
	},
});
