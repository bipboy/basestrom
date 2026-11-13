import * as stylex from "@stylexjs/stylex";

export const styles = stylex.create({
	root: {
		position: "relative",
		width: "100%",
	},
	body: {
		position: "absolute",
		top: 0,
		right: 0,
		bottom: 0,
		left: 0,
	},
});
