/**
 * bst-ref modifier - captures a DOM element reference.
 *
 * Replaces the inline `ref` helper with a proper modifier.
 *
 * Usage:
 * ```gts
 * <div {{bst-ref this.captureEl}}></div>
 * ```
 *
 * The provided callback receives the element when it is inserted, and is
 * called with `null` when the element is destroyed.
 */
import { modifier } from 'ember-modifier';

export interface BstRefModifierSignature {
  Element: Element;
  Args: {
    Positional: [(el: Element | null) => void];
  };
}

export const bstRef = modifier<BstRefModifierSignature>(
  (element, [callback]) => {
    callback(element);
    return () => callback(null);
  }
);

export default bstRef;
