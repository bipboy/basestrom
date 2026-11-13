/**
 * SegmentedControl styles - 1:1 port from baseweb segmented-control.
 *
 * Stacking model (matches baseweb):
 * - Root: `isolation: isolate; position: relative` -> creates a stacking
 *   context.
 * - SegmentList: `position: relative; z-index: -2` -> own stacking context
 *   sitting one layer behind Root content.
 * - Active highlight: `position: absolute; z-index: -1` -> drawn behind
 *   segments inside the SegmentList stacking context.
 * - Segments are transparent; the active highlight (white panel + black
 *   border) shows through behind them.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	lighting,
	sizing,
	typography,
} from "../../themes/vars.stylex";

// --- Root --------------------------------------------------------------------

export const rootStyles = stylex.create({
	base: {
		backgroundColor: colors.backgroundSecondary,
		borderRadius: sizing.scale500,
		boxSizing: "border-box",
		isolation: "isolate",
		paddingTop: sizing.scale100,
		paddingRight: sizing.scale100,
		paddingBottom: sizing.scale100,
		paddingLeft: sizing.scale100,
		position: "relative",
		overflowX: "hidden",
		overflowY: "hidden",
	},
	intrinsic: {
		// Hide scrollbar in intrinsic mode.
		scrollbarWidth: "none",
	},
	// Size variants for root padding & border-radius
	sizeSmall: {
		paddingTop: sizing.scale0,
		paddingRight: sizing.scale0,
		paddingBottom: sizing.scale0,
		paddingLeft: sizing.scale0,
		borderRadius: sizing.scale300,
	},
	sizeMedium: {
		paddingTop: sizing.scale100,
		paddingRight: sizing.scale100,
		paddingBottom: sizing.scale100,
		paddingLeft: sizing.scale100,
		borderRadius: sizing.scale500,
	},
	sizeLarge: {
		paddingTop: sizing.scale200,
		paddingRight: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale200,
		borderRadius: sizing.scale550,
	},
});

// --- Segment list -----------------------------------------------------------

export const segmentListStyles = stylex.create({
	base: {
		backgroundColor: colors.backgroundSecondary,
		boxSizing: "border-box",
		display: "flex",
		flexDirection: "row",
		height: "100%",
		justifyContent: "space-evenly",
		overflowX: "hidden",
		overflowY: "hidden",
		position: "relative",
		width: "100%",
		zIndex: -2,
	},
	sizeSmall: {
		minHeight: "32px",
	},
	sizeMedium: {
		minHeight: "40px",
	},
	sizeLarge: {
		minHeight: "48px",
	},
});

// --- Segment (button) -------------------------------------------------------

export const segmentStyles = stylex.create({
	base: {
		fontFamily: typography.primaryFontFamily,
		cursor: "pointer",
		position: "relative",
		appearance: "none",
		WebkitAppearance: "none",
		marginTop: 0,
		marginRight: 0,
		marginBottom: 0,
		marginLeft: 0,
		boxSizing: "border-box",
		display: "grid",
		alignItems: "center",
		justifyContent: "center",
		borderTopWidth: 0,
		borderRightWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderTopStyle: "none",
		borderRightStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		color: colors.contentTertiary,
		backgroundColor: "transparent",
		flexGrow: 1,
		transitionProperty: "box-shadow, color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.linearCurve,
		outlineStyle: "none",
		outlineWidth: 0,
		outlineOffset: "-3px",
		overflowX: "hidden",
		overflowY: "hidden",
		boxShadow: {
			default: "none",
			":hover": lighting.overlay100,
		},
	},
	// Size variants for segment padding & border-radius
	sizeSmall: {
		paddingTop: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale400,
		paddingRight: sizing.scale400,
		borderRadius: sizing.scale300,
	},
	sizeMedium: {
		paddingTop: sizing.scale300,
		paddingBottom: sizing.scale300,
		paddingLeft: sizing.scale500,
		paddingRight: sizing.scale500,
		borderRadius: sizing.scale300,
	},
	sizeLarge: {
		paddingTop: sizing.scale400,
		paddingBottom: sizing.scale400,
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
		borderRadius: sizing.scale400,
	},
	active: {
		color: colors.contentPrimary,
		// Active segment never shows hover overlay.
		boxShadow: {
			default: "none",
			":hover": "none",
		},
	},
	disabled: {
		cursor: "not-allowed",
		color: colors.contentStateDisabled,
		boxShadow: {
			default: "none",
			":hover": "none",
		},
	},
	focusVisible: {
		outlineStyle: "solid",
		outlineWidth: "3px",
		outlineColor: colors.borderAccent,
	},
	fillFixed: {
		flexGrow: 1,
		flexBasis: 0,
	},
});

// --- Active highlight -------------------------------------------------------

export const activeStyles = stylex.create({
	base: {
		position: "absolute",
		bottom: "0px",
		left: "0px",
		height: "100%",
		boxSizing: "border-box",
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftStyle: "solid",
		borderTopWidth: sizing.scale0,
		borderRightWidth: sizing.scale0,
		borderBottomWidth: sizing.scale0,
		borderLeftWidth: sizing.scale0,
		borderTopColor: colors.primaryA,
		borderRightColor: colors.primaryA,
		borderBottomColor: colors.primaryA,
		borderLeftColor: colors.primaryA,
		backgroundColor: colors.backgroundPrimary,
		zIndex: -1,
		pointerEvents: "none",
	},
	sizeSmall: {
		borderRadius: sizing.scale300,
	},
	sizeMedium: {
		borderRadius: sizing.scale300,
	},
	sizeLarge: {
		borderRadius: sizing.scale400,
	},
	animate: {
		transitionProperty: "all",
		transitionDuration: animation.timing400,
		transitionTimingFunction: animation.easeInOutQuinticCurve,
	},
});

// --- Inner blocks -----------------------------------------------------------

export const labelBlockStyles = stylex.create({
	base: {
		display: "flex",
		gap: sizing.scale100,
		alignItems: "center",
		position: "relative",
		justifyContent: "center",
		overflowX: "hidden",
		overflowY: "hidden",
	},
});

export const labelStyles = stylex.create({
	base: {
		fontFamily: typography.primaryFontFamily,
		fontWeight: 500,
		overflowX: "hidden",
		overflowY: "hidden",
		whiteSpace: "nowrap",
		textOverflow: "ellipsis",
		position: "relative",
	},
	sizeSmall: {
		fontSize: "12px",
		lineHeight: "16px",
	},
	sizeMedium: {
		fontSize: "14px",
		lineHeight: "16px",
	},
	sizeLarge: {
		fontSize: "16px",
		lineHeight: "20px",
	},
});

export const descriptionStyles = stylex.create({
	base: {
		fontFamily: typography.primaryFontFamily,
		fontWeight: "normal",
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
		marginTop: 0,
		marginBottom: 0,
		marginLeft: 0,
		marginRight: 0,
		overflowX: "hidden",
		overflowY: "hidden",
		whiteSpace: "nowrap",
		textOverflow: "ellipsis",
		position: "relative",
	},
	sizeSmall: {
		fontSize: "10px",
		lineHeight: "16px",
	},
	sizeMedium: {
		fontSize: "12px",
		lineHeight: "20px",
	},
	sizeLarge: {
		fontSize: "14px",
		lineHeight: "20px",
	},
});

export const artworkContainerStyles = stylex.create({
	base: {
		display: "flex",
		alignItems: "center",
	},
	sizeSmall: {
		height: "12px",
		width: "12px",
	},
	sizeMedium: {
		height: "14px",
		width: "14px",
	},
	sizeLarge: {
		height: "16px",
		width: "16px",
	},
});

export const badgeStyles = stylex.create({
	base: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "12px",
		fontWeight: "normal",
		lineHeight: "20px",
		width: "16px",
		height: "16px",
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		borderRadius: "50%",
		backgroundColor: colors.backgroundAccent,
		color: colors.contentOnColor,
	},
});

export const badgeHintStyles = stylex.create({
	base: {
		width: "8px",
		height: "8px",
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		borderRadius: "50%",
		backgroundColor: colors.backgroundAccent,
		alignSelf: "start",
		marginLeft: "-2px",
	},
});
