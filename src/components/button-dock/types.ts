import type { Overrides } from '../../helpers/overrides';

/**
 * Override keys for ButtonDock subcomponents.
 *
 * - `root` - the outermost container element
 * - `actionContainer` - the wrapper around action sub-containers
 * - `actionSubContainer` - each group of action buttons
 */
export type ButtonDockOverrideKeys = 'root' | 'actionContainer' | 'actionSubContainer';

/** Override type for ButtonDock. */
export type ButtonDockOverrides = Overrides<ButtonDockOverrideKeys>;

export interface ButtonDockSignature {
  Args: {
    /** StyleX overrides for root, actionContainer, and actionSubContainer elements. */
    overrides?: ButtonDockOverrides;
  };
  Blocks: {
    /** Slot for the primary action button (required). */
    primaryAction: [];
    /** Slot for up to two secondary action buttons. */
    secondaryActions: [];
    /** Slot for a dismissive/cancel action button. */
    dismissiveAction: [];
    /** Slot for content above the action buttons (e.g., helper text, progress). */
    topAccessory: [];
  };
  Element: HTMLDivElement;
}
