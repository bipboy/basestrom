/**
 * Link component - styled anchor with router integration.
 *
 * A port of baseweb's Link with Ember-specific additions:
 * - `@route` / `@model` / `@models` / `@query` for Ember router navigation
 * - `@href` for standard external links
 * - `@animateUnderline` for animated hover underline effect
 * - Focus-visible outline
 * - Visited/active color states
 *
 * Uses Interactive component for element rendering (anchor/LinkTo).
 *
 * ## Usage - External link
 *
 * ```hbs
 * <Bst::Link @href="https://example.com" @target="_blank">
 *   Visit Example
 * </Bst::Link>
 * ```
 *
 * ## Usage - Ember route link
 *
 * ```hbs
 * <Bst::Link @route="dashboard">Dashboard</Bst::Link>
 * <Bst::Link @route="user.profile" @model={{this.userId}}>Profile</Bst::Link>
 * <Bst::Link @route="search" @query={{hash q="ember"}}>Search</Bst::Link>
 * ```
 *
 * ## Usage - Animated underline
 *
 * ```hbs
 * <Bst::Link @href="/about" @animateUnderline={{true}}>
 *   About Us
 * </Bst::Link>
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import Interactive from '../interactive/index.gts';
import { styles } from './styles.stylex';
import { type LinkOverrides, type LinkSignature } from './types';

// Re-export types
export { type LinkOverrides, type LinkSignature };

export default class Link extends Component<LinkSignature> {
  @tracked isFocusVisible = false;

  get isDisabled(): boolean {
    return this.args.disabled ?? false;
  }

  get className(): string | undefined {
    const baseStyle = this.args.animateUnderline ? styles.animated : styles.standard;
    const resolved = resolveOverride(baseStyle, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.isFocusVisible && styles.focusVisible,
      this.isDisabled && styles.disabled,
    );
    return className || undefined;
  }

  handleFocus = (event: FocusEvent) => {
    if ((event.target as HTMLElement)?.matches?.(':focus-visible')) {
      this.isFocusVisible = true;
    }
  };

  handleBlur = () => {
    requestAnimationFrame(() => {
      this.isFocusVisible = false;
    });
  };

  <template>
    <Interactive
      class={{this.className}}
      @route={{@route}}
      @model={{@model}}
      @models={{@models}}
      @query={{@query}}
      @href={{@href}}
      @target={{@target}}
      @rel={{@rel}}
      @disabled={{this.isDisabled}}
      ...attributes
      data-basestrom="link"
      {{on "focus" this.handleFocus}}
      {{on "blur" this.handleBlur}}
    >
      {{yield}}
    </Interactive>
  </template>
}
