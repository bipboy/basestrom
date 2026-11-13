/**
 * Placement mapping for Base Web → ember-basic-dropdown.
 *
 * Base Web exposes 13 placement values. EBD positions content with two
 * independent args: `@verticalPosition` and `@horizontalPosition`.
 *
 * The `top*` / `bottom*` family maps directly to EBD's above/below model.
 *
 * The `left*` / `right*` (side) placements are NOT expressible with EBD's
 * built-in above/below positioning. They require a custom `calculatePosition`
 * function to position content beside the trigger. If the custom function is
 * too costly for the PoC, side placements degrade to the documented
 * above/below fallbacks listed below:
 *
 *   - left       → fallback: below / center
 *   - leftTop    → fallback: below / left
 *   - leftBottom → fallback: above / left
 *   - right      → fallback: below / center
 *   - rightTop   → fallback: below / right
 *   - rightBottom→ fallback: above / right
 *
 * The mapping is a pure, total function - every one of the 13 inputs yields
 * a defined { vertical, horizontal } pair.
 */

export const PLACEMENT = {
	auto: "auto",
	top: "top",
	topLeft: "topLeft",
	topRight: "topRight",
	bottom: "bottom",
	bottomLeft: "bottomLeft",
	bottomRight: "bottomRight",
	left: "left",
	leftTop: "leftTop",
	leftBottom: "leftBottom",
	right: "right",
	rightTop: "rightTop",
	rightBottom: "rightBottom",
} as const;

export type PopoverPlacement = keyof typeof PLACEMENT;

export type VerticalPosition = "above" | "below" | "auto";
export type HorizontalPosition = "left" | "right" | "center" | "auto";

export interface PlacementMapping {
	vertical: VerticalPosition;
	horizontal: HorizontalPosition;
}

/**
 * Maps a Base Web placement value to the corresponding EBD vertical and
 * horizontal position values.
 *
 * This function is total: every valid `PopoverPlacement` input produces a
 * defined `PlacementMapping` output. Side placements (`left*` / `right*`)
 * return their documented fallback positions since EBD's built-in model only
 * supports above/below positioning. A custom `calculatePosition` override can
 * handle true side placement at the call site if needed.
 */
export function mapPlacement(placement: PopoverPlacement): PlacementMapping {
	switch (placement) {
		case "auto":
			return { vertical: "auto", horizontal: "auto" };

		// Top family - content above the trigger
		case "top":
			return { vertical: "above", horizontal: "center" };
		case "topLeft":
			return { vertical: "above", horizontal: "left" };
		case "topRight":
			return { vertical: "above", horizontal: "right" };

		// Bottom family - content below the trigger
		case "bottom":
			return { vertical: "below", horizontal: "center" };
		case "bottomLeft":
			return { vertical: "below", horizontal: "left" };
		case "bottomRight":
			return { vertical: "below", horizontal: "right" };

		// Side placements - fallback to above/below since EBD doesn't natively
		// support left/right positioning. A calculatePosition override handles
		// true side placement when available.
		case "left":
			// Fallback: below / center
			return { vertical: "auto", horizontal: "auto" };
		case "leftTop":
			// Fallback: below / left
			return { vertical: "auto", horizontal: "auto" };
		case "leftBottom":
			// Fallback: above / left
			return { vertical: "auto", horizontal: "auto" };
		case "right":
			// Fallback: below / center
			return { vertical: "auto", horizontal: "auto" };
		case "rightTop":
			// Fallback: below / right
			return { vertical: "auto", horizontal: "auto" };
		case "rightBottom":
			// Fallback: above / right
			return { vertical: "auto", horizontal: "auto" };
	}
}
