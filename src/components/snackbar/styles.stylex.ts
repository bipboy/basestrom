/**
 * Snackbar styles - port from baseweb snackbar styled-components.
 *
 * Key mappings:
 * - backgroundInverseSecondary → #282828 (dark background)
 * - contentInversePrimary → #FFFFFF (white text)
 * - borderInverseTransparent → rgba(255,255,255,0.2) (action hover)
 * - backgroundInverseSecondary → #282828 (action active)
 * - radius400 → 12px (border-radius)
 * - deepBelow shadow → 0px 16px 48px rgba(0, 0, 0, 0.22)
 *
 * Visual structure:
 *   PlacementContainer (fixed, full viewport, flex positioning)
 *   └── Root (dark pill, inline-block, max-width 540px)
 *       ├── Content (inline-flex row)
 *       │   ├── StartEnhancerContainer (icon/spinner)
 *       │   ├── Message (text, max 3 lines)
 *       │   └── ActionButton (inline, when fits)
 *       └── WrapActionButtonContainer (below, when action too wide)
 */
import * as stylex from "@stylexjs/stylex";
import { colors, radii, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root ───────────────────────────────────────────────────────────────────
	root: {
		backgroundColor: colors.backgroundInverseSecondary,
		borderTopLeftRadius: radii.radius400,
		borderTopRightRadius: radii.radius400,
		borderBottomLeftRadius: radii.radius400,
		borderBottomRightRadius: radii.radius400,
		boxShadow: "0px 16px 48px rgba(0, 0, 0, 0.22)",
		color: colors.contentInversePrimary,
		display: "inline-block",
		maxWidth: "540px",
		minWidth: "320px",
	},

	// ─── Content ────────────────────────────────────────────────────────────────
	content: {
		alignItems: "center",
		display: "inline-flex",
		width: "100%",
	},

	// ─── Start Enhancer Container ───────────────────────────────────────────────
	startEnhancerContainer: {
		alignItems: "center",
		display: "flex",
		paddingLeft: sizing.scale600,
	},

	// ─── Message ────────────────────────────────────────────────────────────────
	message: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: "normal" as const,
		lineHeight: "24px",
		WebkitBoxOrient: "vertical",
		WebkitLineClamp: "3",
		display: "-webkit-box",
		marginTop: sizing.scale600,
		marginBottom: sizing.scale600,
		overflow: "hidden",
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
	},
	messageWithSuffix: {
		paddingRight: sizing.scale300,
	},

	// ─── Wrap Action Button Container ───────────────────────────────────────────
	wrapActionButtonContainer: {
		display: "flex",
		justifyContent: "flex-end",
	},

	// ─── Action Button Container ────────────────────────────────────────────────
	actionButtonContainer: {
		marginLeft: "auto",
	},

	// ─── Action Button ──────────────────────────────────────────────────────────
	actionButton: {
		display: "inline-flex",
		alignItems: "center",
		justifyContent: "center",
		backgroundColor: "transparent",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		borderTopLeftRadius: "999px",
		borderTopRightRadius: "999px",
		borderBottomLeftRadius: "999px",
		borderBottomRightRadius: "999px",
		color: colors.contentInversePrimary,
		cursor: "pointer",
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
		paddingTop: sizing.scale550,
		paddingBottom: sizing.scale550,
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
		marginRight: sizing.scale100,
		whiteSpace: "nowrap",
		width: "100%",
		":hover": {
			backgroundColor: colors.borderInverseTransparent,
		},
		":active": {
			backgroundColor: colors.backgroundInverseSecondary,
		},
	},

	// ─── Placement Container ────────────────────────────────────────────────────
	placementContainer: {
		display: "flex",
		flexDirection: "column",
		pointerEvents: "none",
		position: "fixed",
		right: 0,
		left: 0,
		transitionProperty: "all",
		transitionTimingFunction: "cubic-bezier(0.22, 1, 0.36, 1)",
		transitionDuration: "1s",
		marginTop: sizing.scale300,
		marginRight: sizing.scale300,
		marginBottom: sizing.scale300,
		marginLeft: sizing.scale300,
	},

	// Placement variants
	placementTop: {
		alignItems: "center",
		justifyContent: "flex-start",
		top: 0,
	},
	placementTopLeft: {
		alignItems: "flex-start",
		justifyContent: "flex-start",
		top: 0,
	},
	placementTopRight: {
		alignItems: "flex-end",
		justifyContent: "flex-start",
		top: 0,
	},
	placementBottom: {
		alignItems: "center",
		justifyContent: "flex-end",
		bottom: 0,
	},
	placementBottomLeft: {
		alignItems: "flex-start",
		justifyContent: "flex-end",
		bottom: 0,
	},
	placementBottomRight: {
		alignItems: "flex-end",
		justifyContent: "flex-end",
		bottom: 0,
	},

	// ─── Alert wrapper ──────────────────────────────────────────────────────────
	alertWrapper: {
		display: "inline",
		pointerEvents: "all",
	},
});
