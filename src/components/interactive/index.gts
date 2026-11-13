/**
 * Interactive component - unified interactive element (button/anchor/LinkTo).
 *
 * Architecture borrowed from HDS Interactive, adapted for StyleX.
 *
 * Renders the appropriate element based on arguments:
 * - `@route` → `<LinkTo>` (Ember router navigation)
 * - `@href` → `<a>` (external or internal link)
 * - neither → `<button>`
 *
 * ## Usage - Button
 *
 * ```gts
 * <Interactive {{on "click" this.handleClick}}>
 *   Click me
 * </Interactive>
 * ```
 *
 * ## Usage - External link
 *
 * ```gts
 * <Interactive @href="https://example.com" @target="_blank">
 *   Visit Example
 * </Interactive>
 * ```
 *
 * ## Usage - Ember route link
 *
 * ```gts
 * <Interactive @route="dashboard">Dashboard</Interactive>
 * <Interactive @route="user.profile" @model={{this.userId}}>Profile</Interactive>
 * <Interactive @route="search" @query={{hash q="ember"}}>Search</Interactive>
 * ```
 *
 * ## Features
 *
 * - Unified API for button/anchor/LinkTo
 * - Disabled state support for all element types
 * - Focus-visible handling
 * - Whitespace control (squishies) for inline elements
 * - Automatic `rel="noopener noreferrer"` for `target="_blank"`
 */
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import Component from '@glimmer/component';
import { type InteractiveSignature } from './types';

export { type InteractiveSignature };

export default class Interactive extends Component<InteractiveSignature> {
  get isDisabled(): boolean {
    return this.args.disabled ?? false;
  }

  get isRouteLink(): boolean {
    return !!this.args.route;
  }

  get isAnchor(): boolean {
    return !this.isRouteLink && !!this.args.href;
  }

  get isButton(): boolean {
    return !this.isRouteLink && !this.isAnchor;
  }

  get routeName(): string {
    return this.args.route!;
  }

  get queryParams(): Record<string, unknown> {
    return this.args.query ?? {};
  }

  /**
   * Normalizes @model / @models into a single array suitable for <LinkTo @models>.
   * Returns [] when neither is set so routes without dynamic segments work.
   */
  get linkModels(): unknown[] | undefined {
    if (this.args.models) return this.args.models;
    if (this.args.model !== undefined) return [this.args.model];
    return undefined;
  }

  get buttonType(): 'button' | 'submit' | 'reset' {
    return this.args.type ?? 'button';
  }

  get rel(): string | undefined {
    if (this.args.rel) return this.args.rel;
    if (this.args.target === '_blank') return 'noopener noreferrer';
    return undefined;
  }

  get hrefValue(): string | undefined {
    // When disabled, remove href to prevent navigation
    if (this.isDisabled) return undefined;
    return this.args.href;
  }

  /**
   * Handle Space key for disabled anchor elements.
   * Native <button> handles this, but <a> needs manual handling.
   */
  onKeyUp = (event: KeyboardEvent): void => {
    if (event.key === ' ' || event.code === 'Space') {
      (event.target as HTMLElement).click();
    }
  };

  handleClick = (event: Event): void => {
    if (this.isDisabled) {
      event.preventDefault();
      event.stopImmediatePropagation();
    }
  };

  <template>
    {{! IMPORTANT: whitespace control (squishies ~) to prevent unwanted spaces in inline elements }}
    {{! See: https://handlebarsjs.com/guide/expressions.html#whitespace-control }}
    {{~#if this.isRouteLink~}}
      {{! Ember LinkTo for route navigation }}
      {{~#if this.linkModels~}}
        <LinkTo
          @route={{this.routeName}}
          @models={{this.linkModels}}
          @query={{this.queryParams}}
          @disabled={{this.isDisabled}}
          @current-when={{@current-when}}
          @replace={{@replace}}
          ...attributes
          aria-disabled={{if this.isDisabled "true"}}
          {{on "click" this.handleClick}}
        >{{yield}}</LinkTo>
      {{~else~}}
        <LinkTo
          @route={{this.routeName}}
          @query={{this.queryParams}}
          @disabled={{this.isDisabled}}
          @current-when={{@current-when}}
          @replace={{@replace}}
          ...attributes
          aria-disabled={{if this.isDisabled "true"}}
          {{on "click" this.handleClick}}
        >{{yield}}</LinkTo>
      {{~/if~}}
    {{~else if this.isAnchor~}}
      {{! Native anchor for href links }}
      <a
        href={{this.hrefValue}}
        target={{@target}}
        rel={{this.rel}}
        role="link"
        aria-disabled={{if this.isDisabled "true"}}
        ...attributes
        {{on "keyup" this.onKeyUp}}
        {{on "click" this.handleClick}}
      >{{yield}}</a>
    {{~else~}}
      {{! Native button as fallback }}
      <button
        type={{this.buttonType}}
        disabled={{this.isDisabled}}
        ...attributes
      >{{yield}}</button>
    {{~/if~}}
  </template>
}
