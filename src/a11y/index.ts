/**
 * Accessibility utilities for basestrom components.
 */

/**
 * Generate an ID suitable for aria attributes.
 * Ensures unique IDs across component instances.
 */
let counter = 0;
export function generateId(prefix = "bst"): string {
	return `${prefix}-${++counter}`;
}

/**
 * Common ARIA role constants used across components.
 */
export const ROLE = {
	alert: "alert",
	alertdialog: "alertdialog",
	button: "button",
	checkbox: "checkbox",
	dialog: "dialog",
	grid: "grid",
	gridcell: "gridcell",
	listbox: "listbox",
	menu: "menu",
	menuitem: "menuitem",
	option: "option",
	progressbar: "progressbar",
	radio: "radio",
	radiogroup: "radiogroup",
	slider: "slider",
	spinbutton: "spinbutton",
	switch: "switch",
	tab: "tab",
	tablist: "tablist",
	tabpanel: "tabpanel",
	textbox: "textbox",
	timer: "timer",
	tooltip: "tooltip",
	tree: "tree",
	treeitem: "treeitem",
} as const;

/**
 * Check if the user prefers reduced motion.
 * Useful for disabling animations.
 */
export function prefersReducedMotion(): boolean {
	if (typeof window === "undefined") return false;
	return window.matchMedia("(prefers-reduced-motion: reduce)").matches;
}

/**
 * Trap focus within a container element.
 * Returns a cleanup function to remove the trap.
 */
export function trapFocus(container: HTMLElement): () => void {
	const focusableSelector = [
		"a[href]",
		"button:not([disabled])",
		"input:not([disabled])",
		"select:not([disabled])",
		"textarea:not([disabled])",
		'[tabindex]:not([tabindex="-1"])',
	].join(", ");

	function handleKeyDown(event: KeyboardEvent) {
		if (event.key !== "Tab") return;

		const focusable = Array.from(
			container.querySelectorAll<HTMLElement>(focusableSelector),
		);
		if (focusable.length === 0) return;

		const first = focusable[0]!;
		const last = focusable[focusable.length - 1]!;

		if (event.shiftKey && document.activeElement === first) {
			event.preventDefault();
			last.focus();
		} else if (!event.shiftKey && document.activeElement === last) {
			event.preventDefault();
			first.focus();
		}
	}

	container.addEventListener("keydown", handleKeyDown);
	return () => container.removeEventListener("keydown", handleKeyDown);
}
