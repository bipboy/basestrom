/**
 * Scroll-into-view helper for combobox listbox navigation.
 *
 * Ported from baseweb/menu/utils.ts - adjusts `parent.scrollTop` so the
 * highlighted child is fully visible without scrolling the window.
 */

export function scrollItemIntoView(
	child: HTMLElement | undefined | null,
	parent: HTMLElement,
	isFirst?: boolean,
	isLast?: boolean,
	scrollAlignInView: "auto" | "center" = "auto",
): void {
	if (typeof document === "undefined") return;
	if (!child) return;

	const childRect = child.getBoundingClientRect();
	const parentRect = parent.getBoundingClientRect();

	// While scrolling down, if element is below view
	if (childRect.bottom > parentRect.bottom) {
		if (isLast) {
			parent.scrollTop = parent.scrollHeight - parentRect.height;
		} else {
			const targetBottom = child.offsetTop + childRect.height;
			parent.scrollTop =
				targetBottom -
				(scrollAlignInView === "center"
					? Math.round((parentRect.height + childRect.height) / 2)
					: parentRect.height);
		}

		// While scrolling up, if element is above view
	} else if (childRect.top < parentRect.top) {
		if (isFirst) {
			parent.scrollTop = 0;
		} else {
			parent.scrollTop =
				child.offsetTop -
				(scrollAlignInView === "center"
					? Math.round((parentRect.height - childRect.height) / 2)
					: 0);
		}
	}
}
