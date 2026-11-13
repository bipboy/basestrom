/**
 * SystemBanner component - port from baseweb system-banner.
 *
 * A full-bleed, high-hierarchy banner for system-level notifications.
 * Sits at the top of the page with no border-radius and responsive margins.
 *
 * Behavior:
 * - Single primary action → entire banner is clickable (button element)
 * - Two actions → primary action on message area, secondary as trailing icon/button
 * - No action → static informational banner
 *
 * Usage:
 * ```hbs
 * {{! Single action - entire banner clickable }}
 * <Bst::SystemBanner @kind="info" @primaryActionLabel="Learn more" @onPrimaryAction={{this.learn}}>
 *   New feature available
 * </Bst::SystemBanner>
 *
 * {{! Two actions }}
 * <Bst::SystemBanner
 *   @kind="negative"
 *   @primaryActionLabel="Fix now"
 *   @onPrimaryAction={{this.fix}}
 *   @secondaryActionLabel="Dismiss"
 *   @onSecondaryAction={{this.dismiss}}
 * >
 *   Connection error detected
 *   <:secondaryIcon>✕</:secondaryIcon>
 * </Bst::SystemBanner>
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles as bannerStyles } from '../banner/styles.stylex';
import { styles } from './styles.stylex';
import {
  KIND,
  type Kind,
  type SystemBannerOverrides,
  type SystemBannerSignature,
} from './types';

// Re-export types and constants
export {
  KIND,
  type Kind,
  type SystemBannerOverrides,
  type SystemBannerSignature
};

// ─── Color schemes (high hierarchy only for SystemBanner) ───────────────────────

interface ColorScheme {
  backgroundColor: string;
  color: string;
}

function getColors(kind: Kind): ColorScheme {
  switch (kind) {
    case 'negative':
      return { backgroundColor: '#DE1135', color: '#FFFFFF' };
    case 'positive':
      return { backgroundColor: '#0E8345', color: '#FFFFFF' };
    case 'warning':
      return { backgroundColor: '#F6BC2F', color: '#000000' };
    case 'info':
    default:
      return { backgroundColor: '#276EF1', color: '#FFFFFF' };
  }
}

// ─── Component ──────────────────────────────────────────────────────────────────

export class SystemBanner extends Component<SystemBannerSignature> {
  // ─── Computed ───────────────────────────────────────────────────────────────

  get kind(): Kind { return this.args.kind ?? 'info'; }
  get ariaLabel(): string { return this.args['aria-label'] ?? 'system notification'; }

  get colorScheme(): ColorScheme {
    return getColors(this.kind);
  }

  /** Single primary action = entire banner is a button */
  get isSingleAction(): boolean {
    return !!this.args.primaryActionLabel && !!this.args.onPrimaryAction && !this.args.secondaryActionLabel;
  }

  /** Two actions = message area is clickable, trailing has secondary */
  get isTwoActions(): boolean {
    return !!this.args.primaryActionLabel && !!this.args.onPrimaryAction && !!this.args.secondaryActionLabel;
  }

  get hasSecondaryIcon(): boolean {
    return this.isTwoActions;
  }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      styles.root,
      this.isSingleAction && styles.rootClickable,
    );
    return className || undefined;
  }

  get rootStyle(): string {
    const { backgroundColor, color } = this.colorScheme;
    return htmlSafe(`background-color: ${backgroundColor}; color: ${color}`).toString();
  }

  get leadingContentClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.leadingContent, this.args.overrides, 'leadingContent');
    const { className } = stylex.props(...resolved, styles.leadingContent);
    return className || undefined;
  }

  get leadingContentWithArtworkClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.leadingContent, this.args.overrides, 'leadingContent');
    const { className } = stylex.props(
      ...resolved,
      bannerStyles.leadingContentWithArtwork,
      styles.leadingContent,
    );
    return className || undefined;
  }

  get messageContentClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.messageContent, this.args.overrides, 'messageContent');
    const { className } = stylex.props(
      ...resolved,
      bannerStyles.messageContentTrailingAction,
      this.isTwoActions && styles.messageContentButton,
    );
    return className || undefined;
  }

  get titleClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.title, this.args.overrides, 'title');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get messageClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.message, this.args.overrides, 'message');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trailingContentClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.trailingContent, this.args.overrides, 'trailingContent');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trailingIconButtonClassName(): string | undefined {
    const resolved = resolveOverride(bannerStyles.trailingIconButton, this.args.overrides, 'trailingIconButton');
    const { className } = stylex.props(
      ...resolved,
      styles.trailingIconButton,
    );
    return className || undefined;
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handlePrimaryClick = (event: MouseEvent) => {
    this.args.onPrimaryAction?.(event);
  };

  handleSecondaryClick = (event: MouseEvent) => {
    event.stopPropagation();
    this.args.onSecondaryAction?.(event);
  };

  <template>
    {{#if this.isSingleAction}}
      {{! Single action mode - entire banner is a button }}
      <button
        class={{this.rootClassName}}
        style={{this.rootStyle}}
        type="button"
        role="complementary"
        aria-label={{@primaryActionLabel}}
        data-basestrom="system-banner"
        {{on "click" this.handlePrimaryClick}}
        ...attributes
      >
        {{#if (has-block "artwork")}}
          <div class={{this.leadingContentWithArtworkClassName}}>
            {{yield to="artwork"}}
          </div>
        {{else}}
          <div class={{this.leadingContentClassName}}></div>
        {{/if}}

        <div class={{this.messageContentClassName}}>
          {{#if @title}}
            <div class={{this.titleClassName}}>{{@title}}</div>
          {{/if}}
          {{#if @message}}
            <div class={{this.messageClassName}}>{{@message}}</div>
          {{else if (has-block)}}
            <div class={{this.messageClassName}}>
              {{yield}}
            </div>
          {{/if}}
        </div>

        <div class={{this.trailingContentClassName}}>
          {{#if (has-block "secondaryIcon")}}
            <div class={{this.trailingIconButtonClassName}}>
              {{yield to="secondaryIcon"}}
            </div>
          {{/if}}
        </div>
      </button>
    {{else}}
      {{! Static or two-action mode }}
      <div
        class={{this.rootClassName}}
        style={{this.rootStyle}}
        role="complementary"
        aria-label={{this.ariaLabel}}
        data-basestrom="system-banner"
        ...attributes
      >
        {{#if (has-block "artwork")}}
          <div class={{this.leadingContentWithArtworkClassName}}>
            {{yield to="artwork"}}
          </div>
        {{else}}
          <div class={{this.leadingContentClassName}}></div>
        {{/if}}

        {{#if this.isTwoActions}}
          {{! Message area is clickable for primary action }}
          <button
            class={{this.messageContentClassName}}
            type="button"
            aria-label={{@primaryActionLabel}}
            {{on "click" this.handlePrimaryClick}}
          >
            {{#if @title}}
              <div class={{this.titleClassName}}>{{@title}}</div>
            {{/if}}
            {{#if @message}}
              <div class={{this.messageClassName}}>{{@message}}</div>
            {{else if (has-block)}}
              <div class={{this.messageClassName}}>
                {{yield}}
              </div>
            {{/if}}
          </button>
        {{else}}
          <div class={{this.messageContentClassName}}>
            {{#if @title}}
              <div class={{this.titleClassName}}>{{@title}}</div>
            {{/if}}
            {{#if @message}}
              <div class={{this.messageClassName}}>{{@message}}</div>
            {{else if (has-block)}}
              <div class={{this.messageClassName}}>
                {{yield}}
              </div>
            {{/if}}
          </div>
        {{/if}}

        <div class={{this.trailingContentClassName}}>
          {{#if this.hasSecondaryIcon}}
            <button
              class={{this.trailingIconButtonClassName}}
              type="button"
              aria-label={{@secondaryActionLabel}}
              {{on "click" this.handleSecondaryClick}}
            >
              {{#if (has-block "secondaryIcon")}}
                {{yield to="secondaryIcon"}}
              {{else}}
                {{@secondaryActionLabel}}
              {{/if}}
            </button>
          {{/if}}
        </div>
      </div>
    {{/if}}
  </template>
}

export default SystemBanner;
