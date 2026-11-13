/**
 * Interactive component types.
 */

export interface InteractiveSignature {
	Args: {
		/** External URL. Renders a native <a> element. */
		href?: string;
		/** Ember route name. Renders via <LinkTo>. */
		route?: string;
		/** Single dynamic segment model for the route. */
		model?: unknown;
		/** Multiple dynamic segment models for the route. */
		models?: unknown[];
		/** Query params hash for the route. */
		query?: Record<string, unknown>;
		/** Link target (_blank, _self, etc). */
		target?: string;
		/** Rel attribute (e.g. "noopener noreferrer"). Auto-set for target="_blank". */
		rel?: string;
		/** Disable the interactive element. */
		disabled?: boolean;
		/** Button type (only for button element). */
		type?: "button" | "submit" | "reset";
		/** LinkTo current-when. */
		"current-when"?: string | boolean;
		/** LinkTo replace. */
		replace?: boolean;
	};
	Blocks: { default: [] };
	Element: HTMLAnchorElement | HTMLButtonElement;
}
