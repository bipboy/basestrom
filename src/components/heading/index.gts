/**
 * Heading component - port from baseweb heading.
 *
 * A context-aware heading that renders h1-h6 based on nesting level.
 * Must be used inside a HeadingLevel context (from typography).
 *
 * The `@styleLevel` prop allows overriding the visual style independently
 * of the semantic heading level (e.g., render as h3 but look like h1).
 *
 * Usage:
 * ```hbs
 * <Bst::HeadingLevel as |H nextLevel|>
 *   <Bst::Heading>This is h1 with level 1 style</Bst::Heading>
 *   <Bst::HeadingLevel @level={{nextLevel}} as |H2 nextLevel2|>
 *     <Bst::Heading>This is h2 with level 2 style</Bst::Heading>
 *     <Bst::Heading @styleLevel={{1}}>This is h2 but looks like h1</Bst::Heading>
 *   </Bst::HeadingLevel>
 * </Bst::HeadingLevel>
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    type HeadingOverrides,
    type HeadingSignature,
} from './types';

export { type HeadingOverrides, type HeadingSignature };

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Heading extends Component<HeadingSignature> {
  get level(): number {
    return Math.min(Math.max(this.args.level ?? 1, 1), 6);
  }

  get visualLevel(): number {
    return this.args.styleLevel ?? this.level;
  }

  get levelStyle() {
    switch (this.visualLevel) {
      case 1: return styles.level1;
      case 2: return styles.level2;
      case 3: return styles.level3;
      case 4: return styles.level4;
      case 5: return styles.level5;
      case 6: return styles.level6;
      default: return styles.level1;
    }
  }

  get className(): string | undefined {
    const resolved = resolveOverride(styles.base, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved, this.levelStyle);
    return className || undefined;
  }

  get isLevel1(): boolean { return this.level === 1; }
  get isLevel2(): boolean { return this.level === 2; }
  get isLevel3(): boolean { return this.level === 3; }
  get isLevel4(): boolean { return this.level === 4; }
  get isLevel5(): boolean { return this.level === 5; }

  <template>
    {{#if this.isLevel1}}
      <h1 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h1>
    {{else if this.isLevel2}}
      <h2 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h2>
    {{else if this.isLevel3}}
      <h3 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h3>
    {{else if this.isLevel4}}
      <h4 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h4>
    {{else if this.isLevel5}}
      <h5 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h5>
    {{else}}
      <h6 class={{this.className}} data-basestrom="heading" ...attributes>{{yield}}</h6>
    {{/if}}
  </template>
}
