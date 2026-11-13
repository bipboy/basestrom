import type { Overrides } from "../../helpers/overrides";

export type TypographyOverrideKeys = "root";
export type TypographyOverrides = Overrides<TypographyOverrideKeys>;

interface TypographySignature {
	Args: {
		overrides?: TypographyOverrides;
	};
	Blocks: { default: [] };
	Element: HTMLElement;
}

export type { TypographySignature };
