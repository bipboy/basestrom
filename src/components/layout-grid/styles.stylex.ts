/**
 * LayoutGrid base styles - minimal StyleX styles for the grid structure.
 * Most styling is computed dynamically via inline styles based on responsive props.
 */
import * as stylex from "@stylexjs/stylex";

export const gridWrapperStyles = stylex.create({
	base: {
		margin: "auto",
	},
});

export const gridStyles = stylex.create({
	base: {
		boxSizing: "border-box",
		display: "flex",
		flexWrap: "wrap",
	},
});

export const cellStyles = stylex.create({
	base: {
		boxSizing: "border-box",
	},
});
