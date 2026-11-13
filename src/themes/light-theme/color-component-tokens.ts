/**
 * Component color tokens for light theme.
 * Only Block-related tokens for now. Others will be added as components are ported.
 */
import type { SemanticColors } from "../types";
import getSemanticColors from "./color-semantic-tokens";

const defaultSemanticColors = getSemanticColors();

export type ComponentColors = {
	// Currently empty - Block uses semantic tokens directly.
	// Component-specific tokens will be added here as components are ported.
};

export default (
	_semanticColors: SemanticColors = defaultSemanticColors,
): ComponentColors => ({});
