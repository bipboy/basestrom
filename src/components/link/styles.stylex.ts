/**
 * Link styles - exact port from baseweb link/styled-components.ts
 *
 * baseweb applies ALL styles always, varying values based on $isAnimateUnderline.
 * We split into two variants: `standard` (textDecoration underline) and
 * `animated` (gradient underline).
 */
import * as stylex from "@stylexjs/stylex";
import { animation, colors, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// Standard link: text-decoration underline, no background animation
	standard: {
		color: colors.linkText,
		fontSize: "inherit",
		lineHeight: "inherit",
		fontWeight: 500,
		fontFamily: typography.primaryFontFamily,
		cursor: "pointer",
		textDecoration: "underline",
		textUnderlinePosition: "under",
		backgroundImage: "none",
		backgroundSize: "0% 100%, 100% 100%",
		backgroundRepeat: "no-repeat",
		willChange: "background-size",
		transitionProperty: "backgroundSize",
		transitionDuration: animation.timing500,
		transitionTimingFunction: animation.easeDecelerate,
		":hover": {
			color: colors.linkHover,
			backgroundSize: "100% 100%, 100% 100%",
		},
		":visited": {
			color: colors.linkVisited,
		},
		":active": {
			color: colors.linkActive,
		},
	},
	// Animated underline: gradient-based underline that animates on hover
	animated: {
		color: colors.linkText,
		fontSize: "inherit",
		lineHeight: "inherit",
		fontWeight: 500,
		fontFamily: typography.primaryFontFamily,
		cursor: "pointer",
		position: "relative",
		textDecoration: "none",
		textUnderlinePosition: "under",
		backgroundImage: `linear-gradient(transparent calc(100% - 1px), ${colors.linkHover} 1px), linear-gradient(transparent calc(100% - 1px), ${colors.linkText} 1px)`,
		backgroundSize: "0% 100%, 100% 100%",
		backgroundRepeat: "no-repeat",
		willChange: "background-size",
		transitionProperty: "backgroundSize",
		transitionDuration: animation.timing500,
		transitionTimingFunction: animation.easeDecelerate,
		":hover": {
			color: colors.linkHover,
			backgroundSize: "100% 100%, 100% 100%",
		},
		":visited": {
			color: colors.linkVisited,
		},
		":active": {
			color: colors.linkActive,
		},
	},
	focusVisible: {
		outline: `3px solid ${colors.borderAccent}`,
		outlineOffset: "1px",
		textDecoration: "none",
	},
	disabled: {
		color: colors.contentStateDisabled,
		cursor: "not-allowed",
		textDecoration: "none",
		backgroundImage: "none",
		":hover": {
			color: colors.contentStateDisabled,
			backgroundSize: "0% 100%, 100% 100%",
		},
		":visited": {
			color: colors.contentStateDisabled,
		},
	},
});
