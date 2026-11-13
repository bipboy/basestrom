/**
 * The `anchor` element-modifier for Popover.
 *
 * Applied to the consumer's trigger element inside `<:trigger>`, it:
 * 1. Captures the trigger element (for ARIA wiring and `returnFocus`).
 * 2. Wires event listeners based on `triggerType` (click or hover).
 * 3. Sets ARIA attributes based on `accessibilityType` (menu, tooltip, none).
 *
 * The modifier is a factory function that accepts a state/config object and
 * returns a modifier instance. Because the function-based `modifier()` re-runs
 * its setup whenever positional args change, ARIA attributes (e.g.
 * `aria-expanded`) update reactively as `isOpen` changes.
 *
 * Usage in a template:
 *
 * ```gts
 * import { createAnchorModifier } from './anchor';
 *
 * // Inside the component class:
 * get anchorModifier() {
 *   return createAnchorModifier({
 *     isOpen: this.isOpen,
 *     triggerType: this.triggerType,
 *     accessibilityType: this.accessibilityType,
 *     contentId: this.contentId,
 *     toggle: this.toggle,
 *     open: this.open,
 *     close: this.close,
 *     onMouseEnterDelay: this.onMouseEnterDelay,
 *     onMouseLeaveDelay: this.onMouseLeaveDelay,
 *     onTriggerElementCapture: this.captureTriggerElement,
 *   });
 * }
 *
 * // In the template:
 * <button {{this.anchorModifier}}>Trigger</button>
 * ```
 */
import { modifier } from "ember-modifier";

export const TRIGGER_TYPE = { click: "click", hover: "hover" } as const;
export const ACCESSIBILITY_TYPE = {
	none: "none",
	menu: "menu",
	tooltip: "tooltip",
} as const;

export type TriggerType = keyof typeof TRIGGER_TYPE;
export type AccessibilityType = keyof typeof ACCESSIBILITY_TYPE;

export interface AnchorState {
	/** Current open state for aria-expanded. */
	isOpen: boolean;
	/** Determines which listeners to wire. */
	triggerType: TriggerType;
	/** Determines which ARIA attrs to set. */
	accessibilityType: AccessibilityType;
	/** The id of the content element (for aria-controls/aria-describedby). */
	contentId: string;
	/** Called on trigger activation (click / Enter / Space). */
	toggle: () => void;
	/** Called on hover enter / focus (hover triggerType). */
	open: () => void;
	/** Called on hover leave / blur (hover triggerType). */
	close: () => void;
	/** Delay before opening on hover (ms). */
	onMouseEnterDelay: number;
	/** Delay before closing on hover leave (ms). */
	onMouseLeaveDelay: number;
	/** Optional callback for capturing the trigger element. */
	onTriggerElementCapture?: (el: HTMLElement | null) => void;
}

/**
 * ARIA attributes that this modifier manages. Used to clean up on teardown
 * so the element is left in a clean state.
 */
const MANAGED_ARIA_ATTRS = [
	"aria-haspopup",
	"aria-expanded",
	"aria-controls",
	"aria-describedby",
] as const;

/**
 * Creates an anchor modifier bound to the given state.
 *
 * The returned modifier re-runs its setup whenever the state object reference
 * changes (pass a new object each render to get reactive ARIA updates).
 */
export function createAnchorModifier(state: AnchorState) {
	return modifier((element: Element, _positional: unknown[]) => {
		const el = element as HTMLElement;

		// 1. Capture the trigger element
		state.onTriggerElementCapture?.(el);

		// Timer handles for hover delays
		let enterTimer: ReturnType<typeof setTimeout> | null = null;
		let leaveTimer: ReturnType<typeof setTimeout> | null = null;

		// 2. Wire listeners by triggerType
		const listeners: Array<[string, EventListener]> = [];

		// NOTE: Click / Enter / Space toggling is already handled by
		// ember-basic-dropdown's own <dd.Trigger> (its trigger modifier listens
		// for click, keydown Enter (13) and Space (32) and calls
		// dropdown.actions.toggle). Wiring click→toggle here as well would
		// double-toggle and immediately re-close the popover. So for the `click`
		// trigger type the anchor modifier wires NO activation listeners - it only
		// captures the element and sets ARIA (below). For `hover` it adds the
		// mouse/focus listeners that EBD does not provide.
		if (state.triggerType === "hover") {
			const handleMouseEnter = () => {
				if (leaveTimer !== null) {
					clearTimeout(leaveTimer);
					leaveTimer = null;
				}
				if (state.onMouseEnterDelay > 0) {
					enterTimer = setTimeout(() => {
						enterTimer = null;
						state.open();
					}, state.onMouseEnterDelay);
				} else {
					state.open();
				}
			};

			const handleMouseLeave = () => {
				if (enterTimer !== null) {
					clearTimeout(enterTimer);
					enterTimer = null;
				}
				if (state.onMouseLeaveDelay > 0) {
					leaveTimer = setTimeout(() => {
						leaveTimer = null;
						state.close();
					}, state.onMouseLeaveDelay);
				} else {
					state.close();
				}
			};

			const handleFocus = () => {
				if (leaveTimer !== null) {
					clearTimeout(leaveTimer);
					leaveTimer = null;
				}
				state.open();
			};

			const handleBlur = () => {
				state.close();
			};

			el.addEventListener("mouseenter", handleMouseEnter);
			el.addEventListener("mouseleave", handleMouseLeave);
			el.addEventListener("focus", handleFocus);
			el.addEventListener("blur", handleBlur);
			listeners.push(
				["mouseenter", handleMouseEnter],
				["mouseleave", handleMouseLeave],
				["focus", handleFocus],
				["blur", handleBlur],
			);
		}

		// 3. Set ARIA by accessibilityType
		if (state.accessibilityType === "menu") {
			el.setAttribute("aria-haspopup", "true");
			el.setAttribute("aria-expanded", String(state.isOpen));
			el.setAttribute("aria-controls", state.contentId);
		} else if (state.accessibilityType === "tooltip") {
			el.setAttribute("aria-describedby", state.contentId);
		}
		// accessibilityType === "none" → omit all ARIA attributes

		// Return the teardown/cleanup function
		return () => {
			// Clear any pending timers
			if (enterTimer !== null) {
				clearTimeout(enterTimer);
				enterTimer = null;
			}
			if (leaveTimer !== null) {
				clearTimeout(leaveTimer);
				leaveTimer = null;
			}

			// Remove all listeners
			for (const [eventName, handler] of listeners) {
				el.removeEventListener(eventName, handler);
			}

			// Remove managed ARIA attributes
			for (const attr of MANAGED_ARIA_ATTRS) {
				el.removeAttribute(attr);
			}

			// Notify capture callback of teardown
			state.onTriggerElementCapture?.(null);
		};
	});
}
