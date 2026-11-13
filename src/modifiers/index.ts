/**
 * basestrom modifiers - public API.
 */

// Clipboard
export {
	default as bstClipboard,
	copyToClipboard,
	getTargetElement,
	getTextToCopy,
	getTextToCopyFromTargetElement,
	writeTextToClipboard,
	type BstClipboardModifierSignature,
} from "./bst-clipboard";
// Args change effect
export {
	default as bstOnArgsChange,
	type BstOnArgsChangeModifierSignature,
} from "./bst-on-args-change";

// Element reference capture
export {
	default as bstRef,
	type BstRefModifierSignature,
} from "./bst-ref";
// Scroll into view on focus
export {
	default as bstScrollIntoView,
	type BstScrollIntoViewModifierSignature,
} from "./bst-scroll-into-view";
