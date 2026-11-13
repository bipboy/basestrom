import type { Overrides } from '../../helpers/overrides';
import type { ButtonKind, ButtonOverrides } from '../button/types';

// ─── Types ───────────────────────────────────────────────────────────────────

export type ButtonTimedOverrideKeys = 'root' | 'timerContainer' | 'startEnhancer' | 'endEnhancer' | 'spinner';
export type ButtonTimedOverrides = Overrides<ButtonTimedOverrideKeys>;

export interface ButtonTimedSignature {
  Args: {
    /** Countdown duration in seconds. Must be > 0. */
    initialTime: number;
    /** When true, the countdown is frozen and the progress bar pauses. */
    paused?: boolean;
    /** Callback fired when timer expires or button is clicked manually. */
    onClick: () => void;
    /** Visual kind - inherits from Button. Defaults to 'primary'. */
    kind?: ButtonKind;
    /** Whether the button is disabled (also disabled when timer expires). */
    disabled?: boolean;
    /** Whether the button shows a loading spinner. */
    isLoading?: boolean;
    /** Override styles for subcomponents. */
    overrides?: ButtonTimedOverrides;
  };
  Blocks: {
    default: [];
    startEnhancer: [];
    endEnhancer: [];
  };
  Element: HTMLButtonElement | HTMLAnchorElement;
}

// Re-export Button overrides type for convenience
export type { ButtonOverrides };
