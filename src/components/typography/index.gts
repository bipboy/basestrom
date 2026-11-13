/**
 * Typography components.
 *
 * Pre-styled text components that map to the theme's typography scale.
 * Each renders with appropriate font size, weight, line-height,
 * and uses semantic HTML elements where appropriate.
 *
 * Includes:
 * - Display (Large/Medium/Small/XSmall)
 * - Heading (XXLarge/XLarge/Large/Medium/Small/XSmall)
 * - Label (Large/Medium/Small/XSmall)
 * - Paragraph (Large/Medium/Small/XSmall)
 * - Mono variants of all above (16 components)
 * - HeadingLevel context system (auto h1→h6)
 *
 * Usage:
 * ```hbs
 * <Bst::HeadingLarge>Page Title</Bst::HeadingLarge>
 * <Bst::ParagraphMedium>Body text here.</Bst::ParagraphMedium>
 * <Bst::MonoLabelSmall>Code label</Bst::MonoLabelSmall>
 *
 * {{! HeadingLevel auto-nesting }}
 * <Bst::HeadingLevel as |Level nextLevel|>
 *   <Level>This renders as h1</Level>
 *   <Bst::HeadingLevel @level={{nextLevel}} as |SubLevel nextLevel2|>
 *     <SubLevel>This renders as h2</SubLevel>
 *   </Bst::HeadingLevel>
 * </Bst::HeadingLevel>
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { styles } from './styles.stylex';
import {
    type TypographyOverrides,
    type TypographySignature,
} from './types';

export { type TypographyOverrides, type TypographySignature };

function resolveClass(
  variantStyle: ReturnType<typeof stylex.create>[string],
  overrides: TypographyOverrides | undefined,
): string | undefined {
  const overrideStyles = overrides?.root;
  if (overrideStyles) {
    const arr = Array.isArray(overrideStyles) ? overrideStyles : [overrideStyles];
    const { className } = stylex.props(styles.base, variantStyle, ...arr);
    return className || undefined;
  }
  const { className } = stylex.props(styles.base, variantStyle);
  return className || undefined;
}

// --- Display ---

export class DisplayLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.displayLarge, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-display-large">{{yield}}</div></template>
}

export class DisplayMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.displayMedium, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-display-medium">{{yield}}</div></template>
}

export class DisplaySmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.displaySmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-display-small">{{yield}}</div></template>
}

export class DisplayXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.displayXSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-display-xsmall">{{yield}}</div></template>
}

// --- Heading ---

export class HeadingXXLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingXXLarge, this.args.overrides); }
  <template><h1 class={{this.className}} ...attributes data-basestrom="typo-heading-xxlarge">{{yield}}</h1></template>
}

export class HeadingXLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingXLarge, this.args.overrides); }
  <template><h2 class={{this.className}} ...attributes data-basestrom="typo-heading-xlarge">{{yield}}</h2></template>
}

export class HeadingLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingLarge, this.args.overrides); }
  <template><h3 class={{this.className}} ...attributes data-basestrom="typo-heading-large">{{yield}}</h3></template>
}

export class HeadingMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingMedium, this.args.overrides); }
  <template><h4 class={{this.className}} ...attributes data-basestrom="typo-heading-medium">{{yield}}</h4></template>
}

export class HeadingSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingSmall, this.args.overrides); }
  <template><h5 class={{this.className}} ...attributes data-basestrom="typo-heading-small">{{yield}}</h5></template>
}

export class HeadingXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.headingXSmall, this.args.overrides); }
  <template><h6 class={{this.className}} ...attributes data-basestrom="typo-heading-xsmall">{{yield}}</h6></template>
}

// --- Label ---

export class LabelLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.labelLarge, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-label-large">{{yield}}</div></template>
}

export class LabelMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.labelMedium, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-label-medium">{{yield}}</div></template>
}

export class LabelSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.labelSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-label-small">{{yield}}</div></template>
}

export class LabelXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.labelXSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-label-xsmall">{{yield}}</div></template>
}

// --- Paragraph ---

export class ParagraphLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.paragraphLarge, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-paragraph-large">{{yield}}</p></template>
}

export class ParagraphMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.paragraphMedium, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-paragraph-medium">{{yield}}</p></template>
}

export class ParagraphSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.paragraphSmall, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-paragraph-small">{{yield}}</p></template>
}

export class ParagraphXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.paragraphXSmall, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-paragraph-xsmall">{{yield}}</p></template>
}

// --- Mono Display ---

export class MonoDisplayLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoDisplayLarge, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-display-large">{{yield}}</div></template>
}

export class MonoDisplayMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoDisplayMedium, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-display-medium">{{yield}}</div></template>
}

export class MonoDisplaySmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoDisplaySmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-display-small">{{yield}}</div></template>
}

export class MonoDisplayXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoDisplayXSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-display-xsmall">{{yield}}</div></template>
}

// --- Mono Heading ---

export class MonoHeadingXXLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingXXLarge, this.args.overrides); }
  <template><h1 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-xxlarge">{{yield}}</h1></template>
}

export class MonoHeadingXLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingXLarge, this.args.overrides); }
  <template><h2 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-xlarge">{{yield}}</h2></template>
}

export class MonoHeadingLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingLarge, this.args.overrides); }
  <template><h3 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-large">{{yield}}</h3></template>
}

export class MonoHeadingMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingMedium, this.args.overrides); }
  <template><h4 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-medium">{{yield}}</h4></template>
}

export class MonoHeadingSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingSmall, this.args.overrides); }
  <template><h5 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-small">{{yield}}</h5></template>
}

export class MonoHeadingXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoHeadingXSmall, this.args.overrides); }
  <template><h6 class={{this.className}} ...attributes data-basestrom="typo-mono-heading-xsmall">{{yield}}</h6></template>
}

// --- Mono Label ---

export class MonoLabelLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoLabelLarge, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-label-large">{{yield}}</div></template>
}

export class MonoLabelMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoLabelMedium, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-label-medium">{{yield}}</div></template>
}

export class MonoLabelSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoLabelSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-label-small">{{yield}}</div></template>
}

export class MonoLabelXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoLabelXSmall, this.args.overrides); }
  <template><div class={{this.className}} ...attributes data-basestrom="typo-mono-label-xsmall">{{yield}}</div></template>
}

// --- Mono Paragraph ---

export class MonoParagraphLarge extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoParagraphLarge, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-mono-paragraph-large">{{yield}}</p></template>
}

export class MonoParagraphMedium extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoParagraphMedium, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-mono-paragraph-medium">{{yield}}</p></template>
}

export class MonoParagraphSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoParagraphSmall, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-mono-paragraph-small">{{yield}}</p></template>
}

export class MonoParagraphXSmall extends Component<TypographySignature> {
  get className() { return resolveClass(styles.monoParagraphXSmall, this.args.overrides); }
  <template><p class={{this.className}} ...attributes data-basestrom="typo-mono-paragraph-xsmall">{{yield}}</p></template>
}

// --- HeadingLevel context system ---

/**
 * HeadingLevel provides automatic heading level nesting (h1→h6).
 *
 * Each nested HeadingLevel increments the level. The yielded component
 * renders the appropriate heading element with the corresponding style.
 *
 * Usage:
 * ```hbs
 * <Bst::HeadingLevel as |H nextLevel|>
 *   <H>This renders as h1</H>
 *   <Bst::HeadingLevel @level={{nextLevel}} as |H2 nextLevel2|>
 *     <H2>This renders as h2</H2>
 *   </Bst::HeadingLevel>
 * </Bst::HeadingLevel>
 * ```
 */

interface HeadingLevelHeadingSignature {
  Args: {
    overrides?: TypographyOverrides;
  };
  Blocks: { default: [] };
  Element: HTMLElement;
}

class HeadingLevel1 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingXXLarge, this.args.overrides); }
  <template><h1 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h1></template>
}

class HeadingLevel2 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingXLarge, this.args.overrides); }
  <template><h2 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h2></template>
}

class HeadingLevel3 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingLarge, this.args.overrides); }
  <template><h3 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h3></template>
}

class HeadingLevel4 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingMedium, this.args.overrides); }
  <template><h4 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h4></template>
}

class HeadingLevel5 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingSmall, this.args.overrides); }
  <template><h5 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h5></template>
}

class HeadingLevel6 extends Component<HeadingLevelHeadingSignature> {
  get className() { return resolveClass(styles.headingXSmall, this.args.overrides); }
  <template><h6 class={{this.className}} ...attributes data-basestrom="heading-level">{{yield}}</h6></template>
}

type HeadingLevelComponent = typeof HeadingLevel1 | typeof HeadingLevel2 | typeof HeadingLevel3 | typeof HeadingLevel4 | typeof HeadingLevel5 | typeof HeadingLevel6;

const HEADING_COMPONENTS: Record<number, HeadingLevelComponent> = {
  1: HeadingLevel1,
  2: HeadingLevel2,
  3: HeadingLevel3,
  4: HeadingLevel4,
  5: HeadingLevel5,
  6: HeadingLevel6,
};

interface HeadingLevelSignature {
  Args: {
    /** Current heading level (1-6). Defaults to 1. Pass nextLevel from parent HeadingLevel. */
    level?: number;
  };
  Blocks: { default: [HeadingLevelComponent, number] };
  Element: never;
}

export class HeadingLevel extends Component<HeadingLevelSignature> {
  get level(): number {
    return Math.min(Math.max(this.args.level ?? 1, 1), 6);
  }

  get nextLevel(): number {
    return Math.min(this.level + 1, 6);
  }

  get HeadingComponent(): HeadingLevelComponent {
    return HEADING_COMPONENTS[this.level] ?? HeadingLevel6;
  }

  <template>
    {{yield this.HeadingComponent this.nextLevel}}
  </template>
}
