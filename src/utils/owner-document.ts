/**
 * Given a node, returns the ownerDocument if it exists,
 * otherwise the global document.
 */
export default function ownerDocument(node?: HTMLElement | null): Document {
	if (node?.ownerDocument) {
		return node.ownerDocument;
	}
	return document;
}
