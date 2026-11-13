import * as stylex from "@stylexjs/stylex";

export const styles = stylex.create({
	root: {
		display: "flex",
		flexWrap: "wrap",
	},
	item: {
		boxSizing: "border-box",
	},
});
