/**
 * bst-on-args-change modifier - calls a callback on insert and when args change.
 *
 * Equivalent to React's `useEffect(callback, [deps])`.
 * Replaces the inline `onArgsChange` helper with a proper modifier.
 *
 * Usage:
 * ```gts
 * <div {{bst-on-args-change this.callback this.someArg this.otherArg}}>...</div>
 * ```
 *
 * The callback receives the element as its first argument, followed by all
 * additional positional arguments.
 */
import { modifier } from 'ember-modifier';

export interface BstOnArgsChangeModifierSignature {
  Element: Element;
  Args: {
    Positional: [
      (el: Element, ...rest: unknown[]) => void,
      ...unknown[]
    ];
  };
}

export const bstOnArgsChange = modifier<BstOnArgsChangeModifierSignature>(
  (element, positional) => {
    const [callback, ...args] = positional;
    callback(element, ...args);
  }
);

export default bstOnArgsChange;
