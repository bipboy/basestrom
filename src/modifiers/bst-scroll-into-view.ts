/**
 * bst-scroll-into-view modifier - scrolls element into view on focus.
 *
 * Port of HDS hds-scroll-into-view-on-focus modifier for basestrom.
 *
 * Usage:
 * ```gts
 * <input {{bst-scroll-into-view options=(hash block="center")}} />
 * ```
 */
import { modifier } from 'ember-modifier';

export interface BstScrollIntoViewModifierSignature {
  Args: {
    Named: {
      options?: ScrollIntoViewOptions;
    };
  };
  Element: HTMLElement;
}

const DEFAULT_OPTIONS: ScrollIntoViewOptions = {
  block: 'nearest',
  inline: 'nearest',
};

const bstScrollIntoView = modifier<BstScrollIntoViewModifierSignature>(
  (element, _positional, named) => {
    const scrollOptions = named.options ?? DEFAULT_OPTIONS;

    const onFocus = (): void => {
      element.scrollIntoView(scrollOptions);
    };

    element.addEventListener('focus', onFocus);

    return () => {
      element.removeEventListener('focus', onFocus);
    };
  }
);

export default bstScrollIntoView;
