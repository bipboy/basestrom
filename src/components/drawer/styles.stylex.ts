/**
 * Drawer styles - port from baseweb drawer styled-components.
 *
 * Key differences from Dialog:
 * - Uses CSS transitions (not keyframe animations) for open/close
 * - Backdrop fades via opacity transition
 * - DrawerContainer slides via transform transition
 * - Close button is a plain <button> with X icon
 * - Body has 32px margins on all sides
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
		position: "fixed",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		overflow: "auto",
		zIndex: 1000,
	},

	// ─── Backdrop ───────────────────────────────────────────────────────────────
	backdrop: {
		position: "fixed",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		backgroundColor: colors.backgroundOverlay,
		WebkitTapHighlightColor: "transparent",
		touchAction: "none",
	},

	backdropVisible: {
		opacity: 1,
	},

	backdropHidden: {
		opacity: 0,
	},

	backdropAnimate: {
		transitionProperty: "opacity",
		transitionDuration: animation.timing400,
		transitionTimingFunction: animation.easeOutCurve,
	},

	// ─── Container ──────────────────────────────────────────────────────────────
	container: {
		position: "fixed",
		backgroundColor: colors.backgroundPrimary,
		borderTopLeftRadius: radii.surfaceBorderRadius,
		borderTopRightRadius: radii.surfaceBorderRadius,
		borderBottomLeftRadius: radii.surfaceBorderRadius,
		borderBottomRightRadius: radii.surfaceBorderRadius,
		display: "flex",
		maxWidth: "100%",
		maxHeight: "100%",
	},

	containerVisible: {
		opacity: 1,
	},

	containerHidden: {
		opacity: 0,
	},

	containerAnimate: {
		transitionProperty: "opacity, transform",
		transitionDuration: animation.timing400,
		transitionTimingFunction: animation.easeOutCurve,
	},

	// ─── Body ───────────────────────────────────────────────────────────────────
	body: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		lineHeight: "20px",
		color: colors.contentPrimary,
		marginTop: sizing.scale900,
		marginBottom: sizing.scale900,
		marginLeft: sizing.scale900,
		marginRight: sizing.scale900,
		overflow: "auto",
		width: "100%",
	},

	// ─── Close Button ───────────────────────────────────────────────────────────
	close: {
		position: "absolute",
		top: sizing.scale500,
		right: sizing.scale500,
		width: sizing.scale800,
		height: sizing.scale800,
		background: "transparent",
		outlineStyle: "none",
		outlineWidth: 0,
		paddingLeft: 0,
		paddingTop: 0,
		paddingRight: 0,
		paddingBottom: 0,
		borderLeftWidth: "1px",
		borderRightWidth: "1px",
		borderTopWidth: "1px",
		borderBottomWidth: "1px",
		borderLeftStyle: "solid",
		borderRightStyle: "solid",
		borderTopStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftColor: "transparent",
		borderRightColor: "transparent",
		borderTopColor: "transparent",
		borderBottomColor: "transparent",
		fill: colors.contentPrimary,
		color: {
			default: colors.contentPrimary,
			":hover": colors.contentTertiary,
		},
		cursor: "pointer",
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		transitionProperty: "color",
		transitionDuration: animation.timing200,
	},

	closeFocusVisible: {
		outlineStyle: "solid",
		outlineWidth: "3px",
		outlineColor: colors.borderAccent,
	},

	// ─── Hidden utility (for the watcher div) ───────────────────────────────────
	hidden: {
		display: "none",
	},
});
