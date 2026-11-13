/**
 * The full Theme interface.
 * This is the top-level type that components receive.
 */
import type { PrimitiveColors } from "../tokens/types";
import type { ComponentColors } from "./light-theme/color-component-tokens";
import type {
	Animation,
	Borders,
	Breakpoints,
	FoundationColors,
	Grid,
	Lighting,
	MediaQuery,
	SemanticColors,
	Sizing,
	Typography,
} from "./types";

export type ColorTokens = PrimitiveColors &
	FoundationColors &
	SemanticColors &
	ComponentColors & { [key: string]: string };

export type Theme = {
	name: string;
	animation: Animation;
	borders: Borders;
	breakpoints: Breakpoints;
	colors: ColorTokens;
	direction: "auto" | "rtl" | "ltr";
	grid: Grid;
	lighting: Lighting;
	mediaQuery: MediaQuery;
	sizing: Sizing;
	typography: Typography;
};
