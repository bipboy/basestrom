import type { Overrides } from '../../helpers/overrides';

export type SkeletonOverrideKeys = 'root' | 'row';
export type SkeletonOverrides = Overrides<SkeletonOverrideKeys>;

export interface SkeletonSignature {
  Args: {
    /** Number of row placeholders. 0 or omitted = single block. */
    rows?: number;
    /** Enable shimmer animation. Defaults to false. */
    animation?: boolean;
    /** Container height. */
    height?: string;
    /** Container width. */
    width?: string;
    /** Whether rows expand to fill vertical space. */
    autoSizeRows?: boolean;
    /** StyleX style overrides. */
    overrides?: SkeletonOverrides;
  };
  Element: HTMLDivElement;
}
