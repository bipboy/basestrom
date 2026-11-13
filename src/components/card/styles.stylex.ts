/**
 * Card styles - port from baseweb card styled-components.
 *
 * Key mappings:
 * - Root: section element, 2px solid borderOpaque, radius400 (12px), white bg
 * - Contents: 16px margin all sides
 * - HeaderImage: top border-radius matches root, object-fit contain, max-width 100%
 * - Thumbnail: 96x96px, float right, border200 (1px solid rgba(0,0,0,0.08))
 * - Title: HeadingSmall (24px/700/32px), margin-bottom 12px
 * - Body: ParagraphMedium (16px/normal/24px), margin-bottom 16px
 * - Action: LabelMedium (16px/500/20px)
 */
import * as stylex from "@stylexjs/stylex";
import { colors, radii, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root (section element) ─────────────────────────────────────────────────
	root: {
		borderLeftWidth: "2px",
		borderTopWidth: "2px",
		borderRightWidth: "2px",
		borderBottomWidth: "2px",
		borderLeftStyle: "solid",
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftColor: colors.borderOpaque,
		borderRightColor: colors.borderOpaque,
		borderTopColor: colors.borderOpaque,
		borderBottomColor: colors.borderOpaque,
		borderTopLeftRadius: radii.radius400,
		borderTopRightRadius: radii.radius400,
		borderBottomLeftRadius: radii.radius400,
		borderBottomRightRadius: radii.radius400,
		backgroundColor: colors.backgroundPrimary,
		overflow: "hidden",
    boxSizing: "border-box",
	},

	// ─── Header Image ───────────────────────────────────────────────────────────
	headerImage: {
		borderTopLeftRadius: radii.surfaceBorderRadius,
		borderTopRightRadius: radii.surfaceBorderRadius,
		objectFit: "contain",
		maxWidth: "100%",
	},

	// ─── Contents ───────────────────────────────────────────────────────────────
	contents: {
		marginLeft: sizing.scale600,
		marginTop: sizing.scale600,
		marginRight: sizing.scale600,
		marginBottom: sizing.scale600,
	},

	// ─── Thumbnail ──────────────────────────────────────────────────────────────
	thumbnail: {
		float: "right",
		height: sizing.scale2400,
		width: sizing.scale2400,
		objectFit: "cover",
		borderTopLeftRadius: radii.surfaceBorderRadius,
		borderTopRightRadius: radii.surfaceBorderRadius,
		borderBottomLeftRadius: radii.surfaceBorderRadius,
		borderBottomRightRadius: radii.surfaceBorderRadius,
		borderLeftWidth: "1px",
		borderTopWidth: "1px",
		borderRightWidth: "1px",
		borderBottomWidth: "1px",
		borderLeftStyle: "solid",
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftColor: "hsla(0, 0%, 0%, 0.08)",
		borderTopColor: "hsla(0, 0%, 0%, 0.08)",
		borderRightColor: "hsla(0, 0%, 0%, 0.08)",
		borderBottomColor: "hsla(0, 0%, 0%, 0.08)",
		marginTop: 0,
		marginRight: 0,
		marginBottom: sizing.scale500,
		marginLeft: sizing.scale500,
	},

	// ─── Title ──────────────────────────────────────────────────────────────────
	// HeadingSmall = font650 = 24px/700/32px, secondaryFontFamily
	title: {
		fontFamily: typography.secondaryFontFamily,
		fontSize: "24px",
		fontWeight: 700,
		lineHeight: "32px",
		color: colors.contentPrimary,
		marginLeft: 0,
		marginTop: 0,
		marginRight: 0,
		marginBottom: sizing.scale500,
		paddingLeft: 0,
		paddingTop: 0,
		paddingRight: 0,
		paddingBottom: 0,
	},

	// ─── Body ───────────────────────────────────────────────────────────────────
	// ParagraphMedium = font300 = 16px/normal/24px
	body: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: "normal" as const,
		lineHeight: "24px",
		color: colors.contentPrimary,
		marginBottom: sizing.scale600,
	},

	// ─── Action ─────────────────────────────────────────────────────────────────
	// LabelMedium = font350 = 16px/500/20px
	action: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
	},
});
