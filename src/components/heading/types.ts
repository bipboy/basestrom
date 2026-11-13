import type { Overrides } from '../../helpers/overrides';

export type HeadingOverrideKeys = 'root';
export type HeadingOverrides = Overrides<HeadingOverrideKeys>;

export interface HeadingSignature {
  Args: {
    /** Semantic heading level (1-6). Determines which h1-h6 element is rendered. */
    level?: 1 | 2 | 3 | 4 | 5 | 6;
    /** Override the visual style level independently of the semantic level. */
    styleLevel?: 1 | 2 | 3 | 4 | 5 | 6;
    /** StyleX overrides. */
    overrides?: HeadingOverrides;
  };
  Blocks: {
    default: [];
  };
  Element: HTMLHeadingElement;
}
