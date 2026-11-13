/**
 * Popover component types.
 *
 * @module basestrom/components/popover/types
 */

import type { Overrides } from "../../helpers/overrides";
import type { AccessibilityType, TriggerType } from "./anchor";
import type { PopoverPlacement } from "./placement";

// ─── Re-exports ─────────────────────────────────────────────────────────────────

export { ACCESSIBILITY_TYPE, TRIGGER_TYPE } from "./anchor";
export { PLACEMENT } from "./placement";

// ─── Types ──────────────────────────────────────────────────────────────────────

export type { AccessibilityType, TriggerType } from "./anchor";
export type { PopoverPlacement } from "./placement";

export type PopoverOverrideKeys = "Body" | "Inner" | "Arrow";
export type PopoverOverrides = Overrides<PopoverOverrideKeys>;

interface BasePopoverArgs {
	placement?: PopoverPlacement;
	triggerType?: TriggerType;
	accessibilityType?: AccessibilityType;
	showArrow?: boolean;
	autoFocus?: boolean;
	focusLock?: boolean;
	returnFocus?: boolean;
	onMouseEnterDelay?: number;
	onMouseLeaveDelay?: number;
	popoverMargin?: number;
	/** Custom mount node for popover content. Defaults to 'ember-basic-dropdown-wormhole'. */
	mountNode?: HTMLElement;
	overrides?: PopoverOverrides;
	id?: string;
}

export interface PopoverSignature {
	Args: BasePopoverArgs & {
		isOpen?: boolean;
		onClickOutside?: (event: Event) => void;
		onEsc?: () => void;
	};
	Blocks: {
		trigger: [
			hash: {
				isOpen: boolean;
				open: () => void;
				close: () => void;
				toggle: () => void;
				anchor: unknown;
			},
		];
		content: [hash: { close: () => void }];
	};
	Element: HTMLElement;
}

export interface StatefulPopoverSignature {
	Args: BasePopoverArgs & {
		initialOpen?: boolean;
		dismissOnClickOutside?: boolean;
		dismissOnEsc?: boolean;
		onOpen?: () => void;
		onClose?: () => void;
	};
	Blocks: PopoverSignature["Blocks"];
	Element: HTMLElement;
}
