/**
 * Banner component - port from baseweb banner.
 *
 * Displays an informational message with optional artwork, title, and action.
 * Supports 4 kinds (info, negative, positive, warning) × 2 hierarchies (low, high).
 *
 * Usage:
 * ```hbs
 * <Bst::Banner @kind="info" @title="Update available">
 *   A new version is ready to install.
 * </Bst::Banner>
 *
 * <Bst::Banner @kind="negative" @hierarchy="high" @title="Error">
 *   Something went wrong.
 *   <:action @label="Retry" @onClick={{this.retry}} />
 * </Bst::Banner>
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  ACTION_POSITION,
  ARTWORK_TYPE,
  HIERARCHY,
  KIND,
  type ActionPosition,
  type ArtworkType,
  type BannerOverrides,
  type BannerSignature,
  type Hierarchy,
  type Kind,
} from './types';

// Re-export types and constants
export {
  ACTION_POSITION,
  ARTWORK_TYPE,
  HIERARCHY,
  KIND,
  type ActionPosition,
  type ArtworkType, type BannerOverrides,
  type BannerSignature, type Hierarchy,
  type Kind
};

// ─── Color schemes ──────────────────────────────────────────────────────────────

interface ColorScheme {
  backgroundColor: string;
  color: string;
  actionBackgroundColor: string;
}

function getLowColors(kind: Kind): ColorScheme {
  switch (kind) {
    case 'negative':
      return {
        backgroundColor: '#FFF0EE', // backgroundNegativeLight
        color: '#000000',           // contentPrimary
        actionBackgroundColor: '#FFD7D1', // bannerActionLowNegative
      };
    case 'positive':
      return {
        backgroundColor: '#EAF6ED', // backgroundPositiveLight
        color: '#000000',
        actionBackgroundColor: '#C4EDCB', // bannerActionLowPositive
      };
    case 'warning':
      return {
        backgroundColor: '#FDF2DC', // backgroundWarningLight
        color: '#000000',
        actionBackgroundColor: '#FFE3AC', // bannerActionLowWarning
      };
    case 'info':
    default:
      return {
        backgroundColor: '#EFF4FE', // backgroundAccentLight
        color: '#000000',
        actionBackgroundColor: '#D4E2FC', // bannerActionLowInfo
      };
  }
}

function getHighColors(kind: Kind): ColorScheme {
  switch (kind) {
    case 'negative':
      return {
        backgroundColor: '#DE1135', // backgroundNegative
        color: '#FFFFFF',           // contentOnColor
        actionBackgroundColor: '#AB0A28', // bannerActionHighNegative
      };
    case 'positive':
      return {
        backgroundColor: '#0E8345', // backgroundPositive
        color: '#FFFFFF',
        actionBackgroundColor: '#0A6633', // bannerActionHighPositive
      };
    case 'warning':
      return {
        backgroundColor: '#F6BC2F', // backgroundWarning
        color: '#000000',           // contentPrimary
        actionBackgroundColor: '#D4A017', // bannerActionHighWarning
      };
    case 'info':
    default:
      return {
        backgroundColor: '#276EF1', // backgroundAccent
        color: '#FFFFFF',
        actionBackgroundColor: '#1E54B7', // bannerActionHighInfo
      };
  }
}

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Banner extends Component<BannerSignature> {
  // ─── Computed ───────────────────────────────────────────────────────────────

  get kind(): Kind { return this.args.kind ?? 'info'; }
  get hierarchy(): Hierarchy { return this.args.hierarchy ?? 'low'; }
  get nested(): boolean { return this.args.nested ?? false; }
  get actionPosition(): ActionPosition { return this.args.actionPosition ?? 'trailing'; }
  get ariaLabel(): string { return this.args['aria-label'] ?? 'this is an announcement banner'; }

  get colorScheme(): ColorScheme {
    return this.hierarchy === 'high'
      ? getHighColors(this.kind)
      : getLowColors(this.kind);
  }

  get hasActionBelow(): boolean {
    return this.actionPosition === 'below' && !!this.args.actionLabel;
  }

  get hasActionTrailing(): boolean {
    return this.actionPosition === 'trailing' && !!this.args.actionLabel;
  }

  get hasActionIconTrailing(): boolean {
    return this.actionPosition === 'trailing' && !!this.args.actionIcon;
  }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.nested ? styles.rootNested : styles.rootNotNested,
    );
    return className || undefined;
  }

  get rootStyle(): string {
    const { backgroundColor, color } = this.colorScheme;
    return htmlSafe(`background-color: ${backgroundColor}; color: ${color}`).toString();
  }

  get leadingContentClassName(): string | undefined {
    const resolved = resolveOverride(styles.leadingContent, this.args.overrides, 'leadingContent');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get leadingContentWithArtworkClassName(): string | undefined {
    const resolved = resolveOverride(styles.leadingContent, this.args.overrides, 'leadingContent');
    const { className } = stylex.props(...resolved, styles.leadingContentWithArtwork);
    return className || undefined;
  }

  get messageContentClassName(): string | undefined {
    const resolved = resolveOverride(styles.messageContent, this.args.overrides, 'messageContent');
    const { className } = stylex.props(
      ...resolved,
      this.actionPosition === 'trailing' && styles.messageContentTrailingAction,
    );
    return className || undefined;
  }

  get titleClassName(): string | undefined {
    const resolved = resolveOverride(styles.title, this.args.overrides, 'title');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get messageClassName(): string | undefined {
    const resolved = resolveOverride(styles.message, this.args.overrides, 'message');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trailingContentClassName(): string | undefined {
    const resolved = resolveOverride(styles.trailingContent, this.args.overrides, 'trailingContent');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trailingButtonContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.trailingButtonContainer, this.args.overrides, 'trailingButtonContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trailingIconButtonClassName(): string | undefined {
    const resolved = resolveOverride(styles.trailingIconButton, this.args.overrides, 'trailingIconButton');
    const { className } = stylex.props(
      ...resolved,
      this.nested ? styles.trailingIconButtonNested : styles.trailingIconButtonNotNested,
    );
    return className || undefined;
  }

  get belowContentClassName(): string | undefined {
    const resolved = resolveOverride(styles.belowContent, this.args.overrides, 'belowContent');
    const { className } = stylex.props(
      ...resolved,
      this.hasActionBelow && styles.belowContentActive,
    );
    return className || undefined;
  }

  get actionButtonClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionButton, this.args.overrides, 'actionButton');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionButtonStyle(): string {
    const { actionBackgroundColor, color } = this.colorScheme;
    return htmlSafe(`background-color: ${actionBackgroundColor}; color: ${color}`).toString();
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleActionClick = (event: MouseEvent) => {
    this.args.onActionClick?.(event);
  };

  <template>
    <div
      class={{this.rootClassName}}
      style={{this.rootStyle}}
      role="complementary"
      aria-label={{this.ariaLabel}}
      data-basestrom="banner"
      ...attributes
    >
      {{! Leading content (artwork) }}
      {{#if (has-block "artwork")}}
        <div class={{this.leadingContentWithArtworkClassName}}>
          {{yield to="artwork"}}
        </div>
      {{else}}
        <div class={{this.leadingContentClassName}}></div>
      {{/if}}

      {{! Message content }}
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

      {{! Trailing content }}
      <div class={{this.trailingContentClassName}}>
        {{#if this.hasActionIconTrailing}}
          <button
            class={{this.trailingIconButtonClassName}}
            type="button"
            aria-label={{@actionLabel}}
            {{on "click" this.handleActionClick}}
          >
            {{yield to="action"}}
          </button>
        {{else if this.hasActionTrailing}}
          <div class={{this.trailingButtonContainerClassName}}>
            <button
              class={{this.actionButtonClassName}}
              style={{this.actionButtonStyle}}
              type="button"
              {{on "click" this.handleActionClick}}
            >
              {{@actionLabel}}
            </button>
          </div>
        {{/if}}
      </div>

      {{! Below content }}
      {{#if this.hasActionBelow}}
        <div class={{this.belowContentClassName}}>
          <button
            class={{this.actionButtonClassName}}
            style={{this.actionButtonStyle}}
            type="button"
            {{on "click" this.handleActionClick}}
          >
            {{@actionLabel}}
          </button>
        </div>
      {{else}}
        <div class={{this.belowContentClassName}}></div>
      {{/if}}
    </div>
  </template>
}
