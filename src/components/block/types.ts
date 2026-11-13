import type { Overrides } from '../../helpers/overrides';

export type BlockOverrideKeys = 'root';
export type BlockOverrides = Overrides<BlockOverrideKeys>;

export interface BlockSignature {
  Args: {
    /** StyleX style overrides for subcomponents. */
    overrides?: BlockOverrides;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLDivElement;
}
