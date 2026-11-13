/**
 * Select styles - native <select> element styled like a basestrom control.
 *
 * Takes visual cues from the Button (secondary) component:
 * - backgroundSecondary fill
 * - No border (borderWidth: 0)
 * - buttonBorderRadius
 * - Hover/active overlays via boxShadow inset
 * - caret-24 SVG as background-image indicator
 *
 * The caret indicator and the right padding that reserves space for it are
 * kept identical across every size variant, so the distance between the value
 * and the caret is stable regardless of size.
 *
 * All declarations use longhand CSS properties only (per StyleX guidelines).
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	radii,
	sizing,
	typography,
} from "../../themes/vars.stylex";

/**
 * HDS flight-icons caret-24 (double chevron up-down) encoded as a data URL.
 * Rendered at 16px in the background. Black for default, gray for disabled.
 */
const CARET_SVG = `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' fill='none' viewBox='0 0 24 24'%3E%3Cpath fill='%23000000' fill-rule='evenodd' d='M16.707 14.232a.75.75 0 0 1 1.06-.025c.299.286.31.761.025 1.06l-5.25 5.5A.75.75 0 0 1 12 21a.75.75 0 0 1-.543-.232l-5.25-5.5a.75.75 0 0 1 1.085-1.036L12 19.164zM12 3c.204 0 .4.085.542.232l5.25 5.5c.285.3.274.775-.025 1.061a.75.75 0 0 1-1.06-.025L12 4.836 7.292 9.768a.75.75 0 0 1-1.085-1.036l5.25-5.5A.75.75 0 0 1 12 3' clip-rule='evenodd'/%3E%3C/svg%3E")`;

const CARET_SVG_DISABLED = `url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' fill='none' viewBox='0 0 24 24'%3E%3Cpath fill='%23A6A6A6' fill-rule='evenodd' d='M16.707 14.232a.75.75 0 0 1 1.06-.025c.299.286.31.761.025 1.06l-5.25 5.5A.75.75 0 0 1 12 21a.75.75 0 0 1-.543-.232l-5.25-5.5a.75.75 0 0 1 1.085-1.036L12 19.164zM12 3c.204 0 .4.085.542.232l5.25 5.5c.285.3.274.775-.025 1.061a.75.75 0 0 1-1.06-.025L12 4.836 7.292 9.768a.75.75 0 0 1-1.085-1.036l5.25-5.5A.75.75 0 0 1 12 3' clip-rule='evenodd'/%3E%3C/svg%3E")`;

export const styles = stylex.create({
	// ─── Root (the <select> element) ────────────────────────────────────────────
	root: {
		boxSizing: "border-box",
		display: "block",
		maxWidth: "100%",
		width: "100%",
		fontFamily: typography.primaryFontFamily,
		color: colors.contentPrimary,
		backgroundColor: colors.backgroundSecondary,
		// No border - same as secondary button
		borderTopWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
		borderRightWidth: 0,
		borderTopStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		borderRightStyle: "none",
		borderRadius: radii.buttonBorderRadius,
		// Caret background-image - fixed offset + size for ALL sizes so the
		// value-to-caret distance stays identical across size variants.
		backgroundImage: CARET_SVG,
		backgroundRepeat: "no-repeat",
		backgroundPositionX: `calc(100% - ${sizing.scale500})`,
		backgroundPositionY: "center",
		backgroundSize: "16px 16px",
		// Remove native appearance
		appearance: "none",
		WebkitAppearance: "none",
		MozAppearance: "none",
		// Transitions (same as button)
		transitionProperty: "background, box-shadow",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeLinear,
		cursor: "pointer",
		outline: "none",
		// Hover overlay via boxShadow - same approach as secondary button
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},

	// ─── Focus ──────────────────────────────────────────────────────────────────
	focused: {
		boxShadow: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderAccent}`,
	},

	// ─── Invalid ────────────────────────────────────────────────────────────────
	invalid: {
		boxShadow: {
			default: `inset 0 0 0 2px ${colors.borderNegative}`,
			":hover": `inset 0 0 0 2px ${colors.borderNegative}, inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 0 0 0 2px ${colors.borderNegative}, inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},

	// ─── Invalid + focus ────────────────────────────────────────────────────────
	invalidFocused: {
		boxShadow: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderNegative}`,
	},

	// ─── Disabled ───────────────────────────────────────────────────────────────
	disabled: {
		color: colors.contentStateDisabled,
		backgroundColor: colors.backgroundStateDisabled,
		backgroundImage: CARET_SVG_DISABLED,
		cursor: "not-allowed",
		boxShadow: {
			default: "none",
			":hover": "none",
			":active": "none",
		},
	},

	// ─── Size variants ──────────────────────────────────────────────────────────
	// paddingRight is identical across sizes (scale950 = 36px) so the gap
	// between the value text and the caret stays the same for every size:
	//   caret offset from edge (12px) + caret width (16px) + gap (8px) = 36px
	sizeMini: {
		fontSize: "12px",
		fontWeight: 500,
		lineHeight: "16px",
		paddingTop: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale300,
		paddingRight: sizing.scale950,
		minHeight: sizing.scale850,
	},
	sizeCompact: {
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "16px",
		paddingTop: sizing.scale400,
		paddingBottom: sizing.scale400,
		paddingLeft: sizing.scale500,
		paddingRight: sizing.scale950,
		minHeight: sizing.scale950,
	},
	sizeDefault: {
		fontSize: "16px",
		fontWeight: "normal",
		lineHeight: "20px",
		paddingTop: sizing.scale550,
		paddingBottom: sizing.scale550,
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale950,
		minHeight: sizing.scale1200,
	},
	sizeLarge: {
		fontSize: "18px",
		fontWeight: "normal",
		lineHeight: "24px",
		paddingTop: sizing.scale600,
		paddingBottom: sizing.scale600,
		paddingLeft: sizing.scale700,
		paddingRight: sizing.scale950,
		minHeight: sizing.scale1400,
	},
});
