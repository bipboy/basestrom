import createDarkTheme from "./dark-theme/create-dark-theme";
import { DarkTheme } from "./dark-theme/dark-theme";
import darkThemePrimitives from "./dark-theme/primitives";
import createLightTheme from "./light-theme/create-light-theme";
import { LightTheme } from "./light-theme/light-theme";
import lightThemePrimitives from "./light-theme/primitives";

export type { Theme } from "./theme-type";

export * from "./types";
export {
	createDarkTheme,
	createLightTheme,
	createLightTheme as createTheme,
	DarkTheme,
	darkThemePrimitives,
	LightTheme,
	lightThemePrimitives,
};
