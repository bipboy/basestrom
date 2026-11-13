import type { Overrides } from '../../helpers/overrides';
import type { ButtonKind, ButtonShape, ButtonSize } from '../button/types';

// ─── Constants ───────────────────────────────────────────────────────────────

export const MODE = Object.freeze({
  radio: 'radio',
  checkbox: 'checkbox',
} as const);

export const STATE_CHANGE_TYPE = Object.freeze({
  change: 'change',
} as const);

export const PADDING = Object.freeze({
  default: 'default',
  none: 'none',
  custom: 'custom',
} as const);

export type ButtonGroupMode = (typeof MODE)[keyof typeof MODE];
export type ButtonGroupPadding = (typeof PADDING)[keyof typeof PADDING];

// ─── Types ───────────────────────────────────────────────────────────────────

export type ButtonGroupOverrideKeys = 'root';
export type ButtonGroupOverrides = Overrides<ButtonGroupOverrideKeys>;

export interface ButtonGroupSignature {
  Args: {
    /** Accessible label for the group. */
    'aria-label'?: string;
    /** Id of element that labels the group. */
    'aria-labelledby'?: string;
    /** Id of element that describes the group. */
    'aria-describedby'?: string;
    /**
     * Selection mode:
     * - `radio`: single selection, arrow-key navigation, radiogroup role
     * - `checkbox`: multi-selection, group role with checkbox semantics
     * - undefined: simple clickable button group (no toggle semantics)
     */
    mode?: ButtonGroupMode;
    /** Whether all buttons in the group are disabled. */
    disabled?: boolean;
    /**
     * Index or array of indices of selected button(s).
     * Used with controlled components when `mode` is defined.
     */
    selected?: number | number[];
    /**
     * Called when a button is clicked. Receives the click event and button index.
     */
    onClick?: (event: MouseEvent | KeyboardEvent, index: number) => void;
    /** Button kind propagated to all children. */
    kind?: ButtonKind;
    /** Button size propagated to all children. */
    size?: ButtonSize;
    /** Button shape propagated to all children. */
    shape?: ButtonShape;
    /** Whether buttons should wrap to next line. */
    wrap?: boolean;
    /** Stretch the group and all buttons to full container width. */
    fullWidth?: boolean;
    /** Horizontal padding for the group container. */
    padding?: ButtonGroupPadding;
    /** Style overrides for the root element. */
    overrides?: ButtonGroupOverrides;
  };
  Blocks: {
    default: [{ Button: any }];
  };
  Element: HTMLDivElement;
}

/**
 * State reducer type for StatefulButtonGroup.
 * Allows consumers to intercept and modify state changes.
 */
export type StateReducer = (
  stateType: (typeof STATE_CHANGE_TYPE)[keyof typeof STATE_CHANGE_TYPE],
  nextState: { selected: number[] },
  currentState: { selected: number[] },
) => { selected: number[] };

export interface StatefulButtonGroupSignature {
  Args: {
    /** Initial selected indices. */
    initialSelected?: number[];
    /** State reducer for custom state logic. */
    stateReducer?: StateReducer;
    /** Accessible label for the group. */
    'aria-label'?: string;
    /** Id of element that labels the group. */
    'aria-labelledby'?: string;
    /** Id of element that describes the group. */
    'aria-describedby'?: string;
    /** Selection mode (radio or checkbox). */
    mode?: ButtonGroupMode;
    /** Whether all buttons in the group are disabled. */
    disabled?: boolean;
    /** Called when a button is clicked. */
    onClick?: (event: MouseEvent | KeyboardEvent, index: number) => void;
    /** Button kind propagated to all children. */
    kind?: ButtonKind;
    /** Button size propagated to all children. */
    size?: ButtonSize;
    /** Button shape propagated to all children. */
    shape?: ButtonShape;
    /** Whether buttons should wrap to next line. */
    wrap?: boolean;
    /** Stretch the group and all buttons to full container width. */
    fullWidth?: boolean;
    /** Horizontal padding for the group container. */
    padding?: ButtonGroupPadding;
    /** Style overrides for the root element. */
    overrides?: ButtonGroupOverrides;
  };
  Blocks: {
    default: [{ Button: any }];
  };
  Element: HTMLDivElement;
}
