/**
 * Button styles - complete port from baseweb button.
 */
import * as stylex from "@stylexjs/stylex";
import {
  animation,
  colors,
  lighting,
  radii,
  sizing,
  typography,
} from "../../themes/vars.stylex";

export const styles = stylex.create({
	base: {
		display: "inline-flex",
		alignItems: "center",
		justifyContent: "center",
		borderWidth: 0,
		borderStyle: "none",
		outline: "none",
		boxSizing: "border-box",
		textDecoration: {
			default: "none",
			":link": "none",
			":visited": "none",
			":hover": "none",
			":active": "none",
			":focus": "none",
		},
		WebkitAppearance: "none",
		cursor: "pointer",
		margin: 0,
		position: "relative",
		transitionProperty: "background",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeLinear,
		fontFamily: typography.primaryFontFamily,
	},
	baseLoading: {
		flexDirection: "column",
	},

	primary: {
		color: {
			default: colors.contentInversePrimary,
			":link": colors.contentInversePrimary,
			":visited": colors.contentInversePrimary,
		},
		backgroundColor: colors.backgroundInversePrimary,
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayInverseAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayInverseAlpha}`,
		},
	},
	secondary: {
		color: {
			default: colors.contentPrimary,
			":link": colors.contentPrimary,
			":visited": colors.contentPrimary,
		},
		backgroundColor: colors.backgroundSecondary,
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},
	tertiary: {
		color: {
			default: colors.contentPrimary,
			":link": colors.contentPrimary,
			":visited": colors.contentPrimary,
		},
		backgroundColor: "transparent",
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},
	dangerPrimary: {
		color: {
			default: colors.contentOnColor,
			":link": colors.contentOnColor,
			":visited": colors.contentOnColor,
		},
		backgroundColor: colors.backgroundNegative,
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},
	dangerSecondary: {
		color: {
			default: colors.borderNegative,
			":link": colors.borderNegative,
			":visited": colors.borderNegative,
		},
		backgroundColor: colors.backgroundSecondary,
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},
	dangerTertiary: {
		color: {
			default: colors.borderNegative,
			":link": colors.borderNegative,
			":visited": colors.borderNegative,
		},
		backgroundColor: "transparent",
		boxShadow: {
			default: "none",
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayAlpha}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayAlpha}`,
		},
	},

	primarySelected: {
		color: {
			default: colors.contentInversePrimary,
			":link": colors.contentInversePrimary,
			":visited": colors.contentInversePrimary,
		},
		backgroundColor: colors.backgroundInversePrimary,
		boxShadow: {
			default: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
			":hover": `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
			":active": `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
		},
	},
	secondarySelected: {
		color: {
			default: colors.contentInversePrimary,
			":link": colors.contentInversePrimary,
			":visited": colors.contentInversePrimary,
		},
		backgroundColor: colors.backgroundInversePrimary,
		boxShadow: {
			default: "none",
			":hover": "none",
			":active": "none",
		},
	},
	tertiarySelected: {
		color: {
			default: colors.contentPrimary,
			":link": colors.contentPrimary,
			":visited": colors.contentPrimary,
		},
		backgroundColor: "transparent",
		boxShadow: {
			default: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
			":hover": `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
			":active": `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderSelected}`,
		},
	},

	// --- Disabled ---
	disabled: {
		cursor: "not-allowed",
		color: {
			default: colors.contentStateDisabled,
			":link": colors.contentStateDisabled,
			":visited": colors.contentStateDisabled,
		},
		backgroundColor: colors.backgroundStateDisabled,
		boxShadow: {
			default: "none",
			":hover": "none",
			":active": "none",
		},
	},
	disabledSelected: {
		cursor: "not-allowed",
		color: {
			default: colors.contentStateDisabled,
			":link": colors.contentStateDisabled,
			":visited": colors.contentStateDisabled,
		},
		backgroundColor: colors.backgroundStateDisabled,
		boxShadow: {
			default: "none",
			":hover": "none",
			":active": "none",
		},
	},

	backgroundSafe: {
		boxShadow: {
			default: lighting.shallowBelow,
			":hover": `inset 999px 999px 0px ${colors.hoverOverlayInverseAlpha}, ${lighting.shallowBelow}`,
			":active": `inset 999px 999px 0px ${colors.pressedOverlayInverseAlpha}, ${lighting.shallowBelow}`,
		},
	},

	focusVisible: {
		boxShadow: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderAccent}`,
	},
	focusVisibleBackgroundSafe: {
		boxShadow: `inset 0 0 0 ${sizing.scale0} ${colors.contentInversePrimary}, 0 0 0 ${sizing.scale0} ${colors.borderAccent}, ${lighting.shallowBelow}`,
	},

	sizeXSmall: {
		paddingTop: sizing.scale200,
		paddingBottom: sizing.scale200,
		paddingLeft: sizing.scale300,
		paddingRight: sizing.scale300,
		fontSize: "12px",
		fontWeight: 500,
		lineHeight: "16px",
		minHeight: sizing.scale850,
	},
	sizeSmall: {
		paddingTop: sizing.scale400,
		paddingBottom: sizing.scale400,
		paddingLeft: sizing.scale500,
		paddingRight: sizing.scale500,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "16px",
		minHeight: sizing.scale950,
	},
	sizeMedium: {
		paddingTop: sizing.scale550,
		paddingBottom: sizing.scale550,
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
		minHeight: sizing.scale1200,
	},
	sizeLarge: {
		paddingTop: sizing.scale600,
		paddingBottom: sizing.scale600,
		paddingLeft: sizing.scale700,
		paddingRight: sizing.scale700,
		fontSize: "18px",
		fontWeight: 500,
		lineHeight: "24px",
		minHeight: sizing.scale1400,
	},

	shapeDefault: { borderRadius: radii.buttonBorderRadius },
	shapePill: { borderRadius: "999px" },
	shapeCircle: { borderRadius: "50%" },
	shapeSquare: { borderRadius: radii.buttonBorderRadius },

	iconXSmall: { height: sizing.scale850, width: sizing.scale850, padding: 0 },
	iconSmall: { height: sizing.scale950, width: sizing.scale950, padding: 0 },
	iconMedium: { height: sizing.scale1200, width: sizing.scale1200, padding: 0 },
	iconLarge: { height: sizing.scale1400, width: sizing.scale1400, padding: 0 },

	widthFill: { width: "100%" },
	minHitAreaTap: {
		position: "relative",
	},

	startEnhancer: {
		display: "flex",
		alignItems: "center",
		flexShrink: 0,
		marginRight: sizing.scale300,
	},
	endEnhancer: {
		display: "flex",
		alignItems: "center",
		flexShrink: 0,
		marginLeft: sizing.scale300,
	},

	loadingContent: {
		opacity: 0,
		display: "flex",
		height: "0px",
		overflow: "hidden",
	},

	spinnerContainer: { lineHeight: 0, position: "static" },
});
