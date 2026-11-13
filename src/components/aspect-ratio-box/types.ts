import type { Overrides } from '../../helpers/overrides';

export type AspectRatioBoxOverrideKeys = 'root' | 'body';
export type AspectRatioBoxOverrides = Overrides<AspectRatioBoxOverrideKeys>;

export interface AspectRatioBoxSignature {
  Args: {
    aspectRatio?: number;
    overrides?: AspectRatioBoxOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLDivElement;
}
