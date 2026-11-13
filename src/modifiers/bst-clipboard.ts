/**
 * bst-clipboard modifier - copies text or element content to clipboard.
 *
 * Port of HDS hds-clipboard modifier for basestrom.
 *
 * Usage:
 * ```gts
 * <button {{bst-clipboard text="Copy me!" onSuccess=this.handleSuccess}}>
 *   Copy to clipboard
 * </button>
 * ```
 */

import { assert, warn } from "@ember/debug";
import { modifier } from "ember-modifier";

type TextToCopy = string | number | bigint;
type TargetToCopy = HTMLElement | string;

export interface BstClipboardModifierSignature {
	Element: HTMLElement;
	Args: {
		Named: {
			text?: TextToCopy;
			target?: TargetToCopy;
			onSuccess?: (...args: any[]) => void;
			onError?: (...args: any[]) => void;
		};
	};
}

export const getTextToCopy = (text: TextToCopy): string => {
	let textToCopy: string = "";

	if (typeof text === "string") {
		textToCopy = text;
	} else if (typeof text === "number" || typeof text === "bigint") {
		textToCopy = text.toString();
	} else {
		assert(
			`\`bst-clipboard\` modifier - \`text\` argument must be a string or number - provided: ${typeof text}`,
		);
	}

	return textToCopy;
};

export const getTargetElement = (
	target: string | Node,
): HTMLElement | undefined => {
	let targetElement: HTMLElement | null;

	if (typeof target === "string") {
		targetElement = document.querySelector(target);

		if (!targetElement) {
			console.error(
				"`bst-clipboard` modifier - `target` selector provided does not point to an existing DOM node, check your selector string",
				targetElement,
			);
			return;
		}
	} else if (target instanceof HTMLElement) {
		targetElement = target;
	} else {
		if (target instanceof NodeList) {
			assert(
				"`bst-clipboard` modifier - `target` argument must be a string or a DOM node - provided: a list of DOM nodes",
			);
		} else {
			assert(
				`\`bst-clipboard\` modifier - \`target\` argument must be a string or a DOM node - provided: ${typeof target}`,
			);
		}
	}
	return targetElement;
};

export const getTextToCopyFromTargetElement = (
	targetElement: TargetToCopy,
): string => {
	let textToCopy: string = "";

	if (targetElement instanceof HTMLElement) {
		if (
			targetElement instanceof HTMLInputElement ||
			targetElement instanceof HTMLTextAreaElement ||
			targetElement instanceof HTMLSelectElement
		) {
			textToCopy = targetElement.value;
		} else {
			// Hide any screen reader only text from the innerText calculation
			const srOnlyTexts = targetElement.querySelectorAll(".sr-only");
			srOnlyTexts.forEach((el: Element) => {
				if (el instanceof HTMLElement) {
					el.style.setProperty("display", "none");
				}
			});

			textToCopy = targetElement.innerText;

			// Restore visibility of screen reader only text
			srOnlyTexts.forEach((el: Element) => {
				if (el instanceof HTMLElement) {
					el.style.removeProperty("display");
				}
			});
		}
	}
	return textToCopy;
};

export const writeTextToClipboard = async (
	textToCopy: string,
): Promise<boolean> => {
	try {
		await navigator.clipboard.writeText(textToCopy);
		return true;
	} catch {
		// If not a secure context or clipboard API not available
		// Fallback to legacy execCommand method
		if (!navigator.clipboard) {
			try {
				// Create a temporary textarea element
				const textarea = document.createElement("textarea");
				textarea.value = textToCopy;
				textarea.style.position = "fixed";
				textarea.style.left = "-9999px";
				textarea.style.top = "-9999px";
				document.body.appendChild(textarea);
				textarea.select();
				textarea.setSelectionRange(0, textarea.value.length);
				const success = document.execCommand("copy");
				document.body.removeChild(textarea);
				return success;
			} catch (error) {
				warn(`copy action failed: ${JSON.stringify(error)}`, {
					id: "bst-clipboard.write-text-to-clipboard.catch-error",
				});
				return false;
			}
		}

		return false;
	}
};

export const copyToClipboard = async (
	text?: TextToCopy,
	target?: TargetToCopy,
): Promise<boolean> => {
	let textToCopy: string = "";

	if (text !== undefined) {
		textToCopy = getTextToCopy(text);
	} else if (target) {
		const targetElement = getTargetElement(target);
		if (targetElement) {
			textToCopy = getTextToCopyFromTargetElement(targetElement);
		}
	} else {
		assert(
			"`bst-clipboard` modifier - either a `text` or a `target` argument is required",
		);
	}
	const success = await writeTextToClipboard(textToCopy);
	return success;
};

export default modifier<BstClipboardModifierSignature>(
	(element, _positional, named): (() => void) => {
		assert(
			"`bst-clipboard` modifier - the modifier must be applied to an element",
			element,
		);

		const { text, target, onSuccess, onError } = named;

		const onClick = async (event: MouseEvent): Promise<void> => {
			const trigger = event.currentTarget;
			const success = await copyToClipboard(text, target);

			if (success) {
				if (typeof onSuccess === "function") {
					onSuccess({ trigger, text, target });
				}
			} else {
				if (typeof onError === "function") {
					onError({ trigger, text, target });
				}
			}
		};

		// eslint-disable-next-line @typescript-eslint/no-misused-promises
		element.addEventListener("click", onClick);

		return (): void => {
			// eslint-disable-next-line @typescript-eslint/no-misused-promises
			element.removeEventListener("click", onClick);
		};
	},
);
