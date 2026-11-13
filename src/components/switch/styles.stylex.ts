/**
 * Switch styles - port from baseweb switch.
 *
 * Hover/active state are tracked in JS (just like the React baseweb
 * implementation) and applied as `boxShadow` overlays on the track and
 * toggle. This matches baseweb's behavior where hovering the label,
 * track, or toggle all activate the same hover indication on both
 * elements regardless of checked state.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	sizing,
	typography,
} from "../../themes/vars.stylex";

// --- Root (label) -----------------------------------------------------------

export const rootStyles = stylex.create({
	root: {
		flexDirection: "row",
		display: "inline-flex",
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
});

// --- Track ------------------------------------------------------------------

export const trackStyles = stylex.create({
	base: {
		alignItems: "center",
		borderRadius: "999px",
		display: "flex",
		flex: "0 0 auto",
		boxSizing: "border-box",
		paddingTop: sizing.scale100,
		paddingBottom: sizing.scale100,
		paddingLeft: sizing.scale100,
		paddingRight: sizing.scale100,
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftStyle: "solid",
		borderTopWidth: sizing.scale0,
		borderRightWidth: sizing.scale0,
		borderBottomWidth: sizing.scale0,
		borderLeftWidth: sizing.scale0,
		borderTopColor: colors.contentTertiary,
		borderRightColor: colors.contentTertiary,
		borderBottomColor: colors.contentTertiary,
		borderLeftColor: colors.contentTertiary,
		backgroundColor: colors.backgroundTertiary,
		boxShadow: "none",
	},

	// Sizes
	sizeDefault: {
		// 32x52
		height: sizing.scale900,
		width: "52px",
	},
	sizeSmall: {
		// 24x40
		height: sizing.scale800,
		width: sizing.scale1000,
	},

	// Checked (uncheck-style border removed)
	checked: {
		backgroundColor: colors.backgroundInversePrimary,
		borderTopStyle: "none",
		borderRightStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderTopWidth: 0,
		borderRightWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderTopColor: "transparent",
		borderRightColor: "transparent",
		borderBottomColor: "transparent",
		borderLeftColor: "transparent",
	},

	// Hover overlays - applied via JS-tracked hover state
	hoverUnchecked: {
		// Off + hover: dark overlay
		boxShadow: `inset 0 0 0 999px ${colors.hoverOverlayAlpha}`,
	},
	hoverChecked: {
		// On + hover: inverse (light) overlay since track is dark
		boxShadow: `inset 0 0 0 999px ${colors.hoverOverlayInverseAlpha}`,
	},

	// Disabled
	disabled: {
		backgroundColor: colors.backgroundStateDisabled,
		borderTopColor: colors.borderStateDisabled,
		borderRightColor: colors.borderStateDisabled,
		borderBottomColor: colors.borderStateDisabled,
		borderLeftColor: colors.borderStateDisabled,
		boxShadow: "none",
	},

	// Focus visible
	focusVisible: {
		outlineWidth: "3px",
		outlineStyle: "solid",
		outlineColor: colors.borderAccent,
		outlineOffset: "2px",
	},
});

// --- Toggle (the moving thumb) ----------------------------------------------

export const toggleStyles = stylex.create({
	base: {
		borderRadius: "50%",
		outline: "none",
		boxSizing: "border-box",
		backgroundColor: colors.contentTertiary,
		transitionProperty: "transform, height, width, background-color",
		transitionDuration: animation.timing300,
		transitionTimingFunction: "cubic-bezier(0.27, 1.06, 0.18, 1.00)",
		backgroundRepeat: "no-repeat",
		backgroundPosition: "center",
		boxShadow: "none",
	},

	// Sizes - off
	defaultOff: {
		// 16x16
		width: sizing.scale600,
		height: sizing.scale600,
	},
	defaultOn: {
		// 24x24, translateX 20px (scale700)
		width: sizing.scale800,
		height: sizing.scale800,
		transform: `translateX(${sizing.scale700})`,
		backgroundColor: colors.contentInversePrimary,
	},
	smallOff: {
		// 12x12
		width: sizing.scale500,
		height: sizing.scale500,
	},
	smallOn: {
		// 16x16, translateX 16px (scale600)
		width: sizing.scale600,
		height: sizing.scale600,
		transform: `translateX(${sizing.scale600})`,
		backgroundColor: colors.contentInversePrimary,
	},

	// Hover overlays
	hoverUnchecked: {
		// Off + hover on knob: light overlay (knob is dark)
		boxShadow: `inset 0 0 0 999px ${colors.hoverOverlayInverseAlpha}`,
	},
	hoverChecked: {
		// On + hover on knob: dark overlay (knob is light/white)
		boxShadow: `inset 0 0 0 999px ${colors.hoverOverlayAlpha}`,
	},

	// Disabled
	disabled: {
		backgroundColor: colors.contentStateDisabled,
		boxShadow: "none",
	},
});

// --- Label ------------------------------------------------------------------

export const labelStyles = stylex.create({
	base: {
		verticalAlign: "middle",
		color: colors.contentPrimary,
		fontFamily: typography.primaryFontFamily,
	},

	// Default size: ParagraphMedium (16/24)
	sizeDefault: {
		fontSize: "16px",
		lineHeight: "24px",
		fontWeight: "normal",
		paddingTop: sizing.scale100,
	},
	// Small size: ParagraphSmall (14/20) with smaller top padding
	sizeSmall: {
		fontSize: "14px",
		lineHeight: "20px",
		fontWeight: "normal",
		paddingTop: sizing.scale0,
	},

	placementRight: {
		paddingLeft: sizing.scale300,
	},
	placementLeft: {
		paddingRight: sizing.scale300,
	},

	disabled: {
		color: colors.contentStateDisabled,
	},
});

// --- Hidden input -----------------------------------------------------------

export const inputStyles = stylex.create({
	base: {
		opacity: 0,
		width: 0,
		height: 0,
		overflow: "hidden",
		margin: 0,
		padding: 0,
		position: "absolute",
	},
});
