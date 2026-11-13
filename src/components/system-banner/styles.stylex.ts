/**
 * SystemBanner styles - extends Banner with full-width, no border-radius,
 * no margin, and responsive page margins via padding.
 *
 * SystemBanner is a full-bleed banner that sits at the top of the page.
 * When it has a single primary action, the entire banner is clickable.
 */
import * as stylex from "@stylexjs/stylex";
import { sizing } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root override ──────────────────────────────────────────────────────────
	// Full-bleed: no border-radius, no margin, responsive padding
	root: {
		borderStartStartRadius: 0,
		borderStartEndRadius: 0,
		borderEndStartRadius: 0,
		borderEndEndRadius: 0,
		marginTop: 0,
		marginRight: 0,
		marginBottom: 0,
		marginLeft: 0,
		paddingInlineStart: sizing.scale600,
		paddingInlineEnd: sizing.scale600,
	},

	// ─── Clickable root (when single primary action) ────────────────────────────
	rootClickable: {
		cursor: "pointer",
		WebkitAppearance: "none",
		textAlign: "inherit" as const,
		boxShadow: "none",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		alignItems: "center",
		":hover": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.04)",
		},
		":active": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.08)",
		},
	},

	// ─── Leading content override ───────────────────────────────────────────────
	leadingContent: {
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
	},

	// ─── Trailing icon button override ──────────────────────────────────────────
	// Remove hover/active shadows (parent handles it in single-action mode)
	trailingIconButton: {
		":hover": {
			boxShadow: "none",
		},
		":active": {
			boxShadow: "none",
		},
	},

	// ─── MessageContent as button (two-action mode) ─────────────────────────────
	messageContentButton: {
		backgroundColor: "transparent",
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		fontFamily: "inherit",
		fontSize: "inherit",
		fontStyle: "inherit",
		fontWeight: "inherit",
		lineHeight: "inherit",
		cursor: "pointer",
		textAlign: "inherit" as const,
		paddingTop: 0,
		paddingBottom: 0,
		paddingLeft: 0,
		paddingRight: 0,
		":hover": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.04)",
		},
		":active": {
			boxShadow: "inset 999px 999px 0px rgba(0, 0, 0, 0.08)",
		},
	},
});
