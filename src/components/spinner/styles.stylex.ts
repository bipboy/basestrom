/**
 * Spinner styles - port from baseweb spinner.
 *
 * Visual spec mirrors baseweb:
 * - Top border = $color (default: contentAccent)
 * - Other 3 borders = backgroundTertiary
 * - Linear infinite rotation
 * - Border-radius 50%
 *
 * Size presets (from baseweb):
 *   small  → 24px box, 2px border (scale800 / scale0)
 *   medium → 32px box, 4px border (scale900 / scale100)
 *   large  → 40px box, 8px border (scale1000 / scale300)
 */
import * as stylex from "@stylexjs/stylex";
import { animation, colors, sizing } from "../../themes/vars.stylex";

export const spinAnimation = stylex.keyframes({
	from: { transform: "rotate(0deg)" },
	to: { transform: "rotate(360deg)" },
});

export const styles = stylex.create({
	base: {
		display: "block",
		boxSizing: "border-box",
		borderRadius: "50%",
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftStyle: "solid",
		// Default tracking colors. Top color is overridden inline via @color
		// when the consumer passes a custom color.
		borderTopColor: colors.contentAccent,
		borderRightColor: colors.backgroundTertiary,
		borderBottomColor: colors.backgroundTertiary,
		borderLeftColor: colors.backgroundTertiary,
		animationName: spinAnimation,
		animationDuration: animation.timing500,
		animationIterationCount: "infinite",
		animationTimingFunction: "linear",
		cursor: "wait",
	},

	// --- Size presets (box dimensions) ---
	sizeSmall: { width: sizing.scale800, height: sizing.scale800 },
	sizeMedium: { width: sizing.scale900, height: sizing.scale900 },
	sizeLarge: { width: sizing.scale1000, height: sizing.scale1000 },

	// --- Border-width presets ---
	borderSmall: {
		borderTopWidth: sizing.scale0,
		borderRightWidth: sizing.scale0,
		borderBottomWidth: sizing.scale0,
		borderLeftWidth: sizing.scale0,
	},
	borderMedium: {
		borderTopWidth: sizing.scale100,
		borderRightWidth: sizing.scale100,
		borderBottomWidth: sizing.scale100,
		borderLeftWidth: sizing.scale100,
	},
	borderLarge: {
		borderTopWidth: sizing.scale300,
		borderRightWidth: sizing.scale300,
		borderBottomWidth: sizing.scale300,
		borderLeftWidth: sizing.scale300,
	},
});
