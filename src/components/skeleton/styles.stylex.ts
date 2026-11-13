/**
 * Skeleton styles - matches baseweb original.
 * Uses a 135deg gradient sweep animation at 1.5s ease-out.
 */
import * as stylex from "@stylexjs/stylex";
import { colors } from "../../themes/vars.stylex";

const shimmer = stylex.keyframes({
	"0%": { backgroundPosition: "100% 50%" },
	"100%": { backgroundPosition: "0% 50%" },
});

export const styles = stylex.create({
	root: {
		display: "flex",
		flexDirection: "column",
	},
	rootAnimated: {
		backgroundImage: `linear-gradient(135deg, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundSecondary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary})`,
		backgroundSize: "400% 100%",
		animationName: shimmer,
		animationDuration: "1.5s",
		animationTimingFunction: "ease-out",
		animationIterationCount: "infinite",
	},
	rootStatic: {
		backgroundColor: colors.backgroundTertiary,
	},
	row: {
		width: "100%",
		flexBasis: "15px",
		flexGrow: 0,
	},
	rowAnimated: {
		backgroundImage: `linear-gradient(135deg, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundSecondary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary}, ${colors.backgroundTertiary})`,
		backgroundSize: "400% 100%",
		animationName: shimmer,
		animationDuration: "1.5s",
		animationTimingFunction: "ease-out",
		animationIterationCount: "infinite",
	},
	rowStatic: {
		backgroundColor: colors.backgroundTertiary,
	},
	rowSpacing: {
		marginBottom: "10px",
	},
	rowLast: {
		marginBottom: "0px",
	},
	rowAutoSize: {
		flexGrow: 1,
	},
});
