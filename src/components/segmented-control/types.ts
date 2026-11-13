import type { Overrides } from '../../helpers/overrides';

// --- Constants --------------------------------------------------------------

export const FILL = {
  fixed: 'fixed',
  intrinsic: 'intrinsic',
} as const;

export type Fill = keyof typeof FILL;

export const SIZE = {
  small: 'small',
  medium: 'medium',
  large: 'large',
} as const;

export type SegmentedControlSize = keyof typeof SIZE;

// --- Override keys ----------------------------------------------------------

export type SegmentedControlOverrideKeys = 'root' | 'segmentList' | 'active';
export type SegmentedControlOverrides = Overrides<SegmentedControlOverrideKeys>;

export type SegmentOverrideKeys =
  | 'segment'
  | 'labelBlock'
  | 'artworkContainer'
  | 'label'
  | 'description'
  | 'badge'
  | 'badgeHint';
export type SegmentOverrides = Overrides<SegmentOverrideKeys>;

// --- Yielded context --------------------------------------------------------

export interface SegmentedControlContext {
  activeKey: string | number;
  disabled: boolean;
  fill: Fill;
  size: SegmentedControlSize;
  activateOnFocus: boolean;
  /** Called by a Segment when its element is connected/disconnected. */
  registerSegment: (key: string | number, el: HTMLElement | null) => void;
  /** Called when a Segment is activated (click or keyboard). */
  selectSegment: (key: string | number) => void;
  /** Keyboard navigation between segments. */
  onSegmentKeyDown: (event: KeyboardEvent, key: string | number) => void;
}

// --- Signatures -------------------------------------------------------------

export interface SegmentedControlSignature {
  Args: {
    /** Currently active segment key. */
    activeKey?: string | number;
    /** Disable all segments. */
    disabled?: boolean;
    /** 'fixed' makes all segments share equal width. 'intrinsic' sizes by content. */
    fill?: Fill;
    /** Size variant: 'small', 'medium' (default), 'large'. */
    size?: SegmentedControlSize;
    /** Whether arrow-key focus changes also activate the focused segment. */
    activateOnFocus?: boolean;
    /** CSS height of the root container. */
    height?: string;
    /** CSS width of the root container. */
    width?: string;
    /** Called when the active segment changes. */
    onChange?: (params: { activeKey: string | number }) => void;
    /** StyleX overrides. */
    overrides?: SegmentedControlOverrides;
  };
  Blocks: { default: [SegmentedControlContext] };
  Element: HTMLDivElement;
}

export interface SegmentSignature {
  Args: {
    /** Context yielded by SegmentedControl. */
    group: SegmentedControlContext;
    /** Unique key for this segment. */
    key: string | number;
    /** Text label. */
    label?: string;
    /** Secondary description rendered below the label. */
    description?: string;
    /** Optional badge value (e.g., count). */
    badge?: string | number;
    /** Renders a small dot accent next to the label. */
    badgeHint?: boolean;
    /** Disable this individual segment. */
    disabled?: boolean;
    /** StyleX overrides. */
    overrides?: SegmentOverrides;
  };
  Blocks: {
    default: [];
    artwork: [];
  };
  Element: HTMLButtonElement;
}
