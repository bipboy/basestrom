import type { Overrides } from '../../helpers/overrides';

export const SIZE = {
  small: 'small',
  medium: 'medium',
  large: 'large',
} as const;

export type SpinnerSize = keyof typeof SIZE;
export type SpinnerOverrideKeys = 'root';
export type SpinnerOverrides = Overrides<SpinnerOverrideKeys>;

export interface SpinnerSignature {
  Args: {
    /** Named size preset. Default: `medium`. */
    size?: SpinnerSize;
    /** Custom box dimension (e.g. `"48px"`). Overrides @size box. */
    boxSize?: string;
    /** Custom border thickness (e.g. `"6px"`). Overrides @size border. */
    borderWidth?: string;
    /** Color of the active arc (top border). Default: theme `contentAccent`. */
    color?: string;
    /** StyleX overrides. */
    overrides?: SpinnerOverrides;
    /** ARIA label. Default: `"loading"`. */
    'aria-label'?: string;
  };
  Element: HTMLElement;
}
