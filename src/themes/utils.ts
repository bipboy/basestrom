import type { SemanticColors } from "./types";

/**
 * Convert hex color to rgba string.
 */
export function hexToRgb(hex = "", alpha = "1"): string | null {
	const shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
	hex = hex.replace(shorthandRegex, (_m, r, g, b) => r + r + g + g + b + b);
	const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
	return result
		? `rgba(${parseInt(result[1]!, 16)}, ${parseInt(result[2]!, 16)}, ${parseInt(
				result[3]!,
				16,
			)}, ${alpha})`
		: null;
}

const foundationColorKeys = [
	"primaryA",
	"primaryB",
	"primary",
	"accent",
	"negative",
	"warning",
	"positive",
] as const;

export function getFoundationColorOverrides(
	colors?: Partial<SemanticColors>,
): Record<string, string> {
	if (!colors) return {};

	return foundationColorKeys.reduce(
		(acc, key) => {
			const value = (colors as Record<string, string>)[key];
			if (value) {
				acc[key] = value;
			}
			return acc;
		},
		{} as Record<string, string>,
	);
}
