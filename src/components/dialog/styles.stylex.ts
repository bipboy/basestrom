/**
 * Dialog styles - port from baseweb dialog styled-components.
 *
 * Key mappings:
 * - Root: fixed overlay panel with border-radius, shadow, animations
 * - Overlay: full-viewport semi-transparent background
 * - ScrollContainer: scrollable body area
 * - Heading: sticky top, HeadingMedium typography, line-clamp support
 * - Body: ParagraphLarge typography, padded content area
 * - DismissButton: absolute top-right, circular secondary button
 *
 * Sizes: xSmall (480px), small (640px), medium (800px), large (100%)
 * Placements: center, topLeft, topCenter, topRight, bottomLeft, bottomCenter, bottomRight
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	lighting,
	radii,
	typography,
} from "../../themes/vars.stylex";

// ─── Keyframes ──────────────────────────────────────────────────────────────────

const overlayFadeIn = stylex.keyframes({
	from: { opacity: 0 },
	to: { opacity: 1 },
});

// Center: must preserve translate(-50%,-50%) positioning in the animation
const dialogSlideInCenter = stylex.keyframes({
	from: { opacity: 0, transform: "translate(-50%, calc(-50% + 16px))" },
	to: { opacity: 1, transform: "translate(-50%, -50%)" },
});

// Bottom placements: preserve translateX(-50%) for centered ones
const dialogSlideInBottomCenter = stylex.keyframes({
	from: { opacity: 0, transform: "translateX(-50%) translateY(16px)" },
	to: { opacity: 1, transform: "translateX(-50%) translateY(0)" },
});

const dialogSlideInBottom = stylex.keyframes({
	from: { opacity: 0, transform: "translateY(16px)" },
	to: { opacity: 1, transform: "translateY(0)" },
});

// Top placements
const dialogSlideInTopCenter = stylex.keyframes({
	from: { opacity: 0, transform: "translateX(-50%) translateY(16px)" },
	to: { opacity: 1, transform: "translateX(-50%) translateY(0)" },
});

const dialogSlideInTop = stylex.keyframes({
	from: { opacity: 0, transform: "translateY(16px)" },
	to: { opacity: 1, transform: "translateY(0)" },
});

// ─── Styles ─────────────────────────────────────────────────────────────────────

export const styles = stylex.create({
	// ─── Overlay ────────────────────────────────────────────────────────────────
	overlay: {
		position: "fixed",
		top: 0,
		left: 0,
		right: 0,
		bottom: 0,
		backgroundColor: colors.backgroundOverlay,
		animationName: overlayFadeIn,
		animationDuration: animation.timing100,
		animationTimingFunction: "ease-out",
		animationFillMode: "forwards",
		zIndex: 1000,
	},

	// ─── Root ───────────────────────────────────────────────────────────────────
	root: {
		position: "fixed",
		display: "flex",
		flexDirection: "column",
		alignItems: "center",
		borderTopLeftRadius: radii.radius500,
		borderTopRightRadius: radii.radius500,
		borderBottomLeftRadius: radii.radius500,
		borderBottomRightRadius: radii.radius500,
		boxShadow: lighting.shallowBelow,
		backgroundColor: colors.backgroundPrimary,
		color: colors.contentPrimary,
		borderTopWidth: 0,
		borderRightWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderTopStyle: "none",
		borderRightStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		overflow: "hidden",
		zIndex: 1001,
		animationDuration: animation.timing400,
		animationTimingFunction: animation.easeDecelerate,
		animationFillMode: "forwards",
	},

	// Entry animation variants (per-placement to preserve positioning transforms)
	animCenter: {
		animationName: dialogSlideInCenter,
	},
	animBottomCenter: {
		animationName: dialogSlideInBottomCenter,
	},
	animBottom: {
		animationName: dialogSlideInBottom,
	},
	animTopCenter: {
		animationName: dialogSlideInTopCenter,
	},
	animTop: {
		animationName: dialogSlideInTop,
	},

	// ─── Size variants ──────────────────────────────────────────────────────────
	sizeXSmall: {
		width: "480px",
		maxWidth: "calc(100% - 80px)",
		maxHeight: "calc(100vh - 80px)",
	},
	sizeSmall: {
		width: "640px",
		maxWidth: "calc(100% - 80px)",
		maxHeight: "calc(100vh - 80px)",
	},
	sizeMedium: {
		width: "800px",
		maxWidth: "calc(100% - 80px)",
		maxHeight: "calc(100vh - 80px)",
	},
	sizeLarge: {
		width: "100%",
		maxWidth: "calc(100% - 80px)",
		maxHeight: "calc(100vh - 80px)",
	},

	// ─── Scroll Container ───────────────────────────────────────────────────────
	scrollContainer: {
		flex: 1,
		overflowY: "auto",
		position: "relative",
		width: "100%",
	},

	// ─── Heading ────────────────────────────────────────────────────────────────
	heading: {
		position: "sticky",
		top: 0,
		paddingTop: "32px",
		paddingBottom: 0,
		paddingLeft: "32px",
		paddingRight: "32px",
		backgroundColor: colors.backgroundPrimary,
		fontFamily: typography.secondaryFontFamily,
		fontSize: "28px",
		lineHeight: "36px",
		fontWeight: 700,
		margin: 0,
		zIndex: 1,
	},
	headingMobile: {
		paddingLeft: "16px",
		paddingRight: "16px",
	},
	headingLineClamp: {
		display: "-webkit-box",
		WebkitBoxOrient: "vertical",
		overflow: "hidden",
	},

	// ─── Body ───────────────────────────────────────────────────────────────────
	body: {
		marginTop: "8px",
		marginBottom: "32px",
		paddingLeft: "32px",
		paddingRight: "32px",
		fontFamily: typography.primaryFontFamily,
		fontSize: "18px",
		lineHeight: "28px",
		fontWeight: "normal" as const,
	},
	bodyMobile: {
		paddingLeft: "16px",
		paddingRight: "16px",
	},

	// ─── Artwork ────────────────────────────────────────────────────────────────
	artwork: {
		display: "flex",
		justifyContent: "center",
		paddingTop: "24px",
		paddingLeft: "24px",
		paddingRight: "24px",
	},

	// ─── Button Dock ────────────────────────────────────────────────────────────
	buttonDock: {
		width: "100%",
		boxSizing: "border-box",
		paddingTop: "0",
		paddingBottom: "24px",
		paddingLeft: "24px",
		paddingRight: "24px",
	},

	// ─── Dismiss Button ─────────────────────────────────────────────────────────
	dismissButton: {
		position: "absolute",
		top: "16px",
		right: "8px",
		zIndex: 2,
		backgroundColor: "rgba(255, 255, 255, 0.6)",
		borderTopLeftRadius: "50%",
		borderTopRightRadius: "50%",
		borderBottomLeftRadius: "50%",
		borderBottomRightRadius: "50%",
	},
});
