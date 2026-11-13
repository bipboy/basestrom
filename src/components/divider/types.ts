import type { Overrides } from '../../helpers/overrides';

export const SIZE = {
  cell: 'cell',
  section: 'section',
  module: 'module',
} as const;

export type DividerSize = keyof typeof SIZE;
export type DividerOverrideKeys = 'root';
export type DividerOverrides = Overrides<DividerOverrideKeys>;

export interface DividerSignature {
  Args: {
    /** Size variant: 'cell' (default), 'section', or 'module'. */
    size?: DividerSize;
    /** StyleX style overrides. */
    overrides?: DividerOverrides;
  };
  Element: HTMLHRElement;
}
