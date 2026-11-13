/**
 * SlidingButton styles - complete port from baseweb sliding-button.
 *
 * Styled sub-elements: root, track, slider, label, completedLabel,
 * grabber, loadingOverlay, loadingSpinner.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	radii,
	sizing,
	typography,
} from "../../themes/vars.stylex";

const spinAnimation = stylex.keyframes({
	from: { transform: "rotate(0deg)" },
	to: { transform: "rotate(360deg)" },
});

export const styles = stylex.create({
	// --- Root ---
	root: {
		width: "100%",
		borderRadius: radii.radius300,
		outline: {
			default: "none",
			":focus-visible": `3px solid ${colors.borderAccent}`,
		},
		outlineOffset: "0px",
	},

	// --- Track ---
	track: {
		position: "relative",
		backgroundColor: colors.backgroundTertiary,
		borderRadius: radii.radius300,
		height: sizing.scale1400,
		overflow: "hidden",
		userSelect: "none",
		touchAction: "none",
	},
	trackDisabled: {
		backgroundColor: colors.backgroundStateDisabled,
	},

	// --- Slider ---
	slider: {
		position: "absolute",
		top: 0,
		left: 0,
		bottom: 0,
		backgroundColor: colors.backgroundInversePrimary,
		borderRadius: radii.radius300,
		display: "flex",
		alignItems: "center",
		justifyContent: "flex-end",
		overflow: "hidden",
		transitionProperty: "width",
		transitionDuration: animation.timing200,
		transitionTimingFunction: "ease-out",
	},
	sliderRtl: {
		left: "auto",
		right: 0,
		justifyContent: "flex-start",
	},
	sliderDisabled: {
		backgroundColor: colors.backgroundStateDisabled,
	},
	sliderCompleted: {
		paddingRight: sizing.scale600,
	},
	sliderCompletedRtl: {
		paddingRight: 0,
		paddingLeft: sizing.scale600,
	},
	sliderNoTransition: {
		transitionProperty: "none",
	},

	// --- Label ---
	label: {
		position: "absolute",
		top: 0,
		left: sizing.scale1400,
		right: 0,
		bottom: 0,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		color: colors.contentPrimary,
		transitionProperty: "opacity, color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: "ease-out",
		pointerEvents: "none",
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
	},
	labelRtl: {
		left: 0,
		right: sizing.scale1400,
	},
	labelDisabled: {
		color: colors.contentStateDisabled,
	},
	labelSliding: {
		color: colors.contentStateDisabled,
	},
	labelCompleted: {
		opacity: 0,
	},

	// --- CompletedLabel ---
	completedLabel: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		color: colors.contentInversePrimary,
		pointerEvents: "none",
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
	},
	completedLabelDisabled: {
		color: colors.contentStateDisabled,
	},

	// --- Grabber ---
	grabber: {
		width: sizing.scale1400,
		height: sizing.scale1400,
		flexShrink: 0,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		color: colors.contentInversePrimary,
		cursor: "grab",
		touchAction: "none",
	},
	grabberDisabled: {
		color: colors.contentStateDisabled,
		cursor: "default",
	},
	grabberNotInteractive: {
		cursor: "default",
	},

	// --- LoadingOverlay ---
	loadingOverlay: {
		position: "absolute",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		backgroundColor: colors.backgroundInversePrimary,
		borderRadius: radii.radius300,
	},

	// --- LoadingSpinner ---
	loadingSpinner: {
		width: sizing.scale700,
		height: sizing.scale700,
		borderRadius: "50%",
		borderWidth: sizing.scale0,
		borderStyle: "solid",
		borderLeftColor: colors.borderInverseOpaque,
		borderRightColor: colors.borderInverseOpaque,
		borderBottomColor: colors.borderInverseOpaque,
		borderTopColor: colors.contentInversePrimary,
		boxSizing: "border-box",
		animationName: spinAnimation,
		animationDuration: "750ms",
		animationTimingFunction: "linear",
		animationIterationCount: "infinite",
	},
});
