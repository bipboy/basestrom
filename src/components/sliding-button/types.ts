import type { Overrides } from '../../helpers/overrides';

// ---------------------------------------------------------------------------
// Constants
// ---------------------------------------------------------------------------

/**
 * Threshold presets controlling how far the user must drag to confirm.
 */
export const THRESHOLD = {
  low: 'low',
  high: 'high',
} as const;

export type ThresholdKey = keyof typeof THRESHOLD;

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export type SlidingButtonOverrideKeys =
  | 'root'
  | 'track'
  | 'slider'
  | 'label'
  | 'completedLabel'
  | 'grabber'
  | 'loadingOverlay'
  | 'loadingSpinner';

export type SlidingButtonOverrides = Overrides<SlidingButtonOverrideKeys>;

export interface SlidingButtonSignature {
  Args: {
    /** Text displayed in the button track. */
    label: string;
    /** Completion threshold - 'high' requires 80% drag, 'low' requires 20%. */
    threshold?: ThresholdKey;
    /** Shows loading spinner, disables interaction. */
    isLoading?: boolean;
    /** Grays out the component, disables interaction. */
    isDisabled?: boolean;
    /** Called once when the user drags past the threshold. */
    onComplete?: () => void;
    /** Auto-reset to idle state after N milliseconds. */
    slideBackAfterMs?: number;
    /** Override internal elements. */
    overrides?: SlidingButtonOverrides;
    /** Accessible label - recommended to omit "Slide" for screen readers. */
    'aria-label'?: string;
  };
  Element: HTMLDivElement;
}
