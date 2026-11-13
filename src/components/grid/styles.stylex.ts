import * as stylex from "@stylexjs/stylex";

export const BEHAVIOR = {
	fluid: "fluid",
	fixed: "fixed",
} as const;

export const ALIGNMENT = {
	start: "flex-start",
	center: "center",
	end: "flex-end",
} as const;

export const gridStyles = stylex.create({
	wrapper: {
		marginLeft: "auto",
		marginRight: "auto",
	},
	wrapperFluid: {
		width: "100%",
	},
	grid: {
		display: "flex",
		flexWrap: "wrap",
		boxSizing: "border-box",
	},
	alignStart: {
		alignItems: "flex-start",
	},
	alignCenter: {
		alignItems: "center",
	},
	alignEnd: {
		alignItems: "flex-end",
	},
	// Responsive margins
	marginSmall: {
		paddingLeft: "16px",
		paddingRight: "16px",
	},
	marginMedium: {
		"@media screen and (min-width: 600px)": {
			paddingLeft: "36px",
			paddingRight: "36px",
		},
	},
	marginLarge: {
		"@media screen and (min-width: 1136px)": {
			paddingLeft: "64px",
			paddingRight: "64px",
		},
	},
	// Responsive gutters (as negative margin on grid, positive padding on cells)
	gutterSmall: {
		marginLeft: "-8px",
		marginRight: "-8px",
	},
	gutterMedium: {
		"@media screen and (min-width: 600px)": {
			marginLeft: "-18px",
			marginRight: "-18px",
		},
	},
	gutterLarge: {
		"@media screen and (min-width: 1136px)": {
			marginLeft: "-18px",
			marginRight: "-18px",
		},
	},
});

export const cellStyles = stylex.create({
	base: {
		boxSizing: "border-box",
	},
	// Responsive gutters (padding on cells)
	gutterSmall: {
		paddingLeft: "8px",
		paddingRight: "8px",
	},
	gutterMedium: {
		"@media screen and (min-width: 600px)": {
			paddingLeft: "18px",
			paddingRight: "18px",
		},
	},
	gutterLarge: {
		"@media screen and (min-width: 1136px)": {
			paddingLeft: "18px",
			paddingRight: "18px",
		},
	},
	// Span helpers - responsive column widths
	// Small: 4 columns
	spanSmall1: { width: "25%" },
	spanSmall2: { width: "50%" },
	spanSmall3: { width: "75%" },
	spanSmall4: { width: "100%" },
	// Medium: 8 columns
	spanMedium1: { "@media screen and (min-width: 600px)": { width: "12.5%" } },
	spanMedium2: { "@media screen and (min-width: 600px)": { width: "25%" } },
	spanMedium3: { "@media screen and (min-width: 600px)": { width: "37.5%" } },
	spanMedium4: { "@media screen and (min-width: 600px)": { width: "50%" } },
	spanMedium5: { "@media screen and (min-width: 600px)": { width: "62.5%" } },
	spanMedium6: { "@media screen and (min-width: 600px)": { width: "75%" } },
	spanMedium7: { "@media screen and (min-width: 600px)": { width: "87.5%" } },
	spanMedium8: { "@media screen and (min-width: 600px)": { width: "100%" } },
	// Large: 12 columns
	spanLarge1: { "@media screen and (min-width: 1136px)": { width: "8.333%" } },
	spanLarge2: { "@media screen and (min-width: 1136px)": { width: "16.667%" } },
	spanLarge3: { "@media screen and (min-width: 1136px)": { width: "25%" } },
	spanLarge4: { "@media screen and (min-width: 1136px)": { width: "33.333%" } },
	spanLarge5: { "@media screen and (min-width: 1136px)": { width: "41.667%" } },
	spanLarge6: { "@media screen and (min-width: 1136px)": { width: "50%" } },
	spanLarge7: { "@media screen and (min-width: 1136px)": { width: "58.333%" } },
	spanLarge8: { "@media screen and (min-width: 1136px)": { width: "66.667%" } },
	spanLarge9: { "@media screen and (min-width: 1136px)": { width: "75%" } },
	spanLarge10: {
		"@media screen and (min-width: 1136px)": { width: "83.333%" },
	},
	spanLarge11: {
		"@media screen and (min-width: 1136px)": { width: "91.667%" },
	},
	spanLarge12: { "@media screen and (min-width: 1136px)": { width: "100%" } },
	// Skip (offset)
	skipSmall1: { marginLeft: "25%" },
	skipSmall2: { marginLeft: "50%" },
	skipSmall3: { marginLeft: "75%" },
	skipMedium1: {
		"@media screen and (min-width: 600px)": { marginLeft: "12.5%" },
	},
	skipMedium2: {
		"@media screen and (min-width: 600px)": { marginLeft: "25%" },
	},
	skipMedium3: {
		"@media screen and (min-width: 600px)": { marginLeft: "37.5%" },
	},
	skipMedium4: {
		"@media screen and (min-width: 600px)": { marginLeft: "50%" },
	},
	skipMedium5: {
		"@media screen and (min-width: 600px)": { marginLeft: "62.5%" },
	},
	skipMedium6: {
		"@media screen and (min-width: 600px)": { marginLeft: "75%" },
	},
	skipMedium7: {
		"@media screen and (min-width: 600px)": { marginLeft: "87.5%" },
	},
	skipLarge1: {
		"@media screen and (min-width: 1136px)": { marginLeft: "8.333%" },
	},
	skipLarge2: {
		"@media screen and (min-width: 1136px)": { marginLeft: "16.667%" },
	},
	skipLarge3: {
		"@media screen and (min-width: 1136px)": { marginLeft: "25%" },
	},
	skipLarge4: {
		"@media screen and (min-width: 1136px)": { marginLeft: "33.333%" },
	},
	skipLarge5: {
		"@media screen and (min-width: 1136px)": { marginLeft: "41.667%" },
	},
	skipLarge6: {
		"@media screen and (min-width: 1136px)": { marginLeft: "50%" },
	},
	skipLarge7: {
		"@media screen and (min-width: 1136px)": { marginLeft: "58.333%" },
	},
	skipLarge8: {
		"@media screen and (min-width: 1136px)": { marginLeft: "66.667%" },
	},
	skipLarge9: {
		"@media screen and (min-width: 1136px)": { marginLeft: "75%" },
	},
	skipLarge10: {
		"@media screen and (min-width: 1136px)": { marginLeft: "83.333%" },
	},
	skipLarge11: {
		"@media screen and (min-width: 1136px)": { marginLeft: "91.667%" },
	},
	// Alignment
	alignStart: { alignSelf: "flex-start" },
	alignCenter: { alignSelf: "center" },
	alignEnd: { alignSelf: "flex-end" },
	// Order - small (no media query)
	orderSmall0: { order: 0 },
	orderSmall1: { order: 1 },
	orderSmall2: { order: 2 },
	orderSmall3: { order: 3 },
	orderSmall4: { order: 4 },
	orderSmall5: { order: 5 },
	orderSmall6: { order: 6 },
	orderSmall7: { order: 7 },
	orderSmall8: { order: 8 },
	orderSmall9: { order: 9 },
	orderSmall10: { order: 10 },
	orderSmall11: { order: 11 },
	orderSmall12: { order: 12 },
	// Order - medium
	orderMedium0: { "@media screen and (min-width: 600px)": { order: 0 } },
	orderMedium1: { "@media screen and (min-width: 600px)": { order: 1 } },
	orderMedium2: { "@media screen and (min-width: 600px)": { order: 2 } },
	orderMedium3: { "@media screen and (min-width: 600px)": { order: 3 } },
	orderMedium4: { "@media screen and (min-width: 600px)": { order: 4 } },
	orderMedium5: { "@media screen and (min-width: 600px)": { order: 5 } },
	orderMedium6: { "@media screen and (min-width: 600px)": { order: 6 } },
	orderMedium7: { "@media screen and (min-width: 600px)": { order: 7 } },
	orderMedium8: { "@media screen and (min-width: 600px)": { order: 8 } },
	// Order - large
	orderLarge0: { "@media screen and (min-width: 1136px)": { order: 0 } },
	orderLarge1: { "@media screen and (min-width: 1136px)": { order: 1 } },
	orderLarge2: { "@media screen and (min-width: 1136px)": { order: 2 } },
	orderLarge3: { "@media screen and (min-width: 1136px)": { order: 3 } },
	orderLarge4: { "@media screen and (min-width: 1136px)": { order: 4 } },
	orderLarge5: { "@media screen and (min-width: 1136px)": { order: 5 } },
	orderLarge6: { "@media screen and (min-width: 1136px)": { order: 6 } },
	orderLarge7: { "@media screen and (min-width: 1136px)": { order: 7 } },
	orderLarge8: { "@media screen and (min-width: 1136px)": { order: 8 } },
	orderLarge9: { "@media screen and (min-width: 1136px)": { order: 9 } },
	orderLarge10: { "@media screen and (min-width: 1136px)": { order: 10 } },
	orderLarge11: { "@media screen and (min-width: 1136px)": { order: 11 } },
	orderLarge12: { "@media screen and (min-width: 1136px)": { order: 12 } },
});
