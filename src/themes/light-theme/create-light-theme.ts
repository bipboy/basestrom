import { primitiveColors } from "../../tokens";
import type { Theme } from "../theme-type";
import { getFoundationColorOverrides } from "../utils";
import getComponentColors from "./color-component-tokens";
import defaultFoundationColors from "./color-foundation-tokens";
import getSemanticColors from "./color-semantic-tokens";
import { LightTheme } from "./light-theme";

type DeepPartial<T> = {
	[P in keyof T]?: T[P] extends object ? DeepPartial<T[P]> : T[P];
};

function deepMerge<T extends object>(target: T, source?: DeepPartial<T>): T {
	if (!source) return target;
	const result = { ...target };
	for (const key of Object.keys(source) as (keyof T)[]) {
		const sourceVal = source[key];
		const targetVal = target[key];
		if (
			sourceVal &&
			typeof sourceVal === "object" &&
			!Array.isArray(sourceVal) &&
			targetVal &&
			typeof targetVal === "object" &&
			!Array.isArray(targetVal)
		) {
			(result as Record<string, unknown>)[key as string] = deepMerge(
				targetVal as object,
				sourceVal as DeepPartial<object>,
			);
		} else if (sourceVal !== undefined) {
			(result as Record<string, unknown>)[key as string] = sourceVal;
		}
	}
	return result;
}

export default function createLightTheme(
	overrides?: DeepPartial<Theme>,
): Theme {
	const foundationColors = {
		...defaultFoundationColors,
		...getFoundationColorOverrides(overrides?.colors),
	};
	const semanticColors = getSemanticColors(foundationColors);
	const componentColors = getComponentColors(semanticColors);

	const theme: Theme = {
		...structuredClone(LightTheme),
		colors: {
			...primitiveColors,
			...foundationColors,
			...semanticColors,
			...componentColors,
		},
	};

	return deepMerge(theme, overrides);
}
