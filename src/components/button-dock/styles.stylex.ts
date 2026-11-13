/**
 * ButtonDock styles - complete port from baseweb button-dock.
 *
 * A fixed-position container for mobile CTAs at the bottom of the viewport.
 * Uses container queries to switch from stacked (mobile) to inline (wide) layout.
 */
import * as stylex from "@stylexjs/stylex";
import { colors, sizing } from "../../themes/vars.stylex";

export const styles = stylex.create({
	/**
	 * Root container - full-width box with column layout and padding.
	 * Defines a container query context named "root" for responsive children.
	 */
	root: {
		boxSizing: "border-box",
		display: "flex",
		flexDirection: "column",
		gap: sizing.scale300,
		width: "100%",
		paddingTop: sizing.scale600,
		paddingRight: sizing.scale600,
		paddingBottom: sizing.scale600,
		paddingLeft: sizing.scale600,
		backgroundColor: colors.backgroundPrimary,
		container: "root / inline-size",
	},

	/**
	 * Action container - wraps the action sub-containers.
	 * Stacks vertically on narrow viewports, switches to row on wide (>600px).
	 */
	actionContainer: {
		display: "flex",
		flexDirection: "column",
		gap: sizing.scale300,
		"@container root (inline-size > 600px)": {
			flexDirection: "row",
			justifyContent: "space-between",
		},
	},

	/**
	 * Action sub-container - default direction (column → row when wide).
	 */
	actionSubContainer: {
		display: "flex",
		flexDirection: "column",
		gap: sizing.scale300,
		"@container root (inline-size > 600px)": {
			flexDirection: "row",
		},
	},

	/**
	 * Action sub-container variant - reverses direction when wide.
	 * Used for the primary + dismissive action group so primary appears
	 * on the right in wide layouts.
	 */
	actionSubContainerReverse: {
		display: "flex",
		flexDirection: "column",
		gap: sizing.scale300,
		"@container root (inline-size > 600px)": {
			flexDirection: "row-reverse",
		},
	},
});
