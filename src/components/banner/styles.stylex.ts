/**
 * Banner styles - port from baseweb banner styled-components.
 *
 * Layout: CSS Grid with 3 columns (leading | message | trailing)
 * and 2 rows (main | below-action).
 *
 * Color scheme is determined by hierarchy (low/high) × kind (info/negative/positive/warning).
 */
import * as stylex from "@stylexjs/stylex";
import { radii, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root ───────────────────────────────────────────────────────────────────
	root: {
		display: "grid",
		gridColumnGap: sizing.scale600,
		gridTemplateColumns: "min-content auto min-content",
		gridTemplateRows: "auto minmax(0, min-content)",
		marginTop: sizing.scale600,
		marginRight: sizing.scale600,
		marginBottom: sizing.scale600,
		marginLeft: sizing.scale600,
	},
	rootNested: {
		borderStartStartRadius: radii.radius300,
		borderStartEndRadius: radii.radius300,
		borderEndStartRadius: radii.radius300,
		borderEndEndRadius: radii.radius300,
	},
	rootNotNested: {
		borderStartStartRadius: radii.radius400,
		borderStartEndRadius: radii.radius400,
		borderEndStartRadius: radii.radius400,
		borderEndEndRadius: radii.radius400,
	},

	// ─── Leading Content ────────────────────────────────────────────────────────
	leadingContent: {
		alignItems: "center",
		display: "flex",
	},
	leadingContentWithArtwork: {
		paddingInlineStart: sizing.scale600,
	},

	// ─── Message Content ────────────────────────────────────────────────────────
	messageContent: {
		display: "flex",
		flexDirection: "column",
		justifyContent: "center",
		paddingBlockStart: sizing.scale600,
	},
	messageContentTrailingAction: {
		paddingBlockEnd: sizing.scale600,
	},

	// ─── Title ──────────────────────────────────────────────────────────────────
	title: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "20px",
	},

	// ─── Message ────────────────────────────────────────────────────────────────
	message: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: "normal" as const,
		lineHeight: "24px",
	},

	// ─── Trailing Content ───────────────────────────────────────────────────────
	trailingContent: {
		display: "flex",
		gridRowEnd: "span 2",
		marginInlineStart: "auto",
	},

	// ─── Trailing Button Container ──────────────────────────────────────────────
	trailingButtonContainer: {
		display: "flex",
		alignItems: "center",
		paddingInlineEnd: sizing.scale600,
	},

	// ─── Trailing Icon Button ───────────────────────────────────────────────────
	trailingIconButton: {
		alignItems: "center",
		background: "none",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		color: "inherit",
		cursor: "pointer",
		display: "flex",
		paddingInlineStart: sizing.scale600,
		paddingInlineEnd: sizing.scale600,
		":hover": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.04)",
		},
		":active": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.08)",
		},
	},
	trailingIconButtonNested: {
		borderStartEndRadius: radii.radius300,
		borderEndEndRadius: radii.radius300,
	},
	trailingIconButtonNotNested: {
		borderStartEndRadius: radii.radius400,
		borderEndEndRadius: radii.radius400,
	},

	// ─── Below Content ──────────────────────────────────────────────────────────
	belowContent: {
		gridColumnStart: "2",
	},
	belowContentActive: {
		paddingBlockStart: sizing.scale300,
		paddingBlockEnd: sizing.scale600,
	},

	// ─── Action Button (pill shape) ─────────────────────────────────────────────
	actionButton: {
		display: "inline-flex",
		alignItems: "center",
		justifyContent: "center",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		borderTopLeftRadius: "24px",
		borderTopRightRadius: "24px",
		borderBottomLeftRadius: "24px",
		borderBottomRightRadius: "24px",
		cursor: "pointer",
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "20px",
		paddingTop: sizing.scale300,
		paddingBottom: sizing.scale300,
		paddingLeft: sizing.scale500,
		paddingRight: sizing.scale500,
		whiteSpace: "nowrap",
	},
});
