import primitiveColors from "../../tokens/color-primitive-tokens";
import animation from "../shared/animation";
import breakpoints from "../shared/breakpoints";
import grid from "../shared/grid";
import lighting from "../shared/lighting";
import mediaQuery from "../shared/media-query";
import sizing from "../shared/sizing";
import typography from "../shared/typography";
import type { Theme } from "../theme-type";
import borders from "./borders";
import getComponentColors from "./color-component-tokens";
import foundationColors from "./color-foundation-tokens";
import getSemanticColors from "./color-semantic-tokens";

export const DarkTheme: Theme = {
	name: "dark-theme",
	colors: {
		...foundationColors,
		...primitiveColors,
		...getSemanticColors(),
		...getComponentColors(),
	},
	animation,
	breakpoints,
	borders,
	direction: "auto",
	grid,
	lighting,
	mediaQuery,
	sizing,
	typography,
};
