/**
 * Card component - port from baseweb card.
 *
 * A content container with optional header image, thumbnail, title, body, and action area.
 * Uses <section> as root element for semantic HTML (allows h1 in title).
 *
 * Usage:
 * ```hbs
 * <Bst::Card @title="Card Title" @headerImage="/path/to/image.jpg">
 *   <:body>Card body content goes here.</:body>
 *   <:action><button>Click me</button></:action>
 * </Bst::Card>
 *
 * {{! With thumbnail }}
 * <Bst::Card @title="With Thumbnail" @thumbnail="/path/to/thumb.jpg">
 *   <:body>Content alongside thumbnail.</:body>
 * </Bst::Card>
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
    type CardOverrides,
    type CardSignature,
} from './types';

// Re-export types
export { type CardOverrides, type CardSignature };

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Card extends Component<CardSignature> {
  // ─── Computed ───────────────────────────────────────────────────────────────

  get hasHeaderImage(): boolean { return !!this.args.headerImage; }
  get hasThumbnail(): boolean { return !!this.args.thumbnail; }
  get hasTitle(): boolean { return !!this.args.title; }

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get headerImageClassName(): string | undefined {
    const resolved = resolveOverride(styles.headerImage, this.args.overrides, 'headerImage');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get contentsClassName(): string | undefined {
    const resolved = resolveOverride(styles.contents, this.args.overrides, 'contents');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get thumbnailClassName(): string | undefined {
    const resolved = resolveOverride(styles.thumbnail, this.args.overrides, 'thumbnail');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get titleClassName(): string | undefined {
    const resolved = resolveOverride(styles.title, this.args.overrides, 'title');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get bodyClassName(): string | undefined {
    const resolved = resolveOverride(styles.body, this.args.overrides, 'body');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionClassName(): string | undefined {
    const resolved = resolveOverride(styles.action, this.args.overrides, 'action');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  <template>
    <section
      class={{this.rootClassName}}
      data-basestrom="card"
      ...attributes
    >
      {{! Header Image }}
      {{#if this.hasHeaderImage}}
        <img
          class={{this.headerImageClassName}}
          src={{@headerImage}}
          alt={{@headerImageAlt}}
        />
      {{/if}}

      {{! Contents }}
      <div class={{this.contentsClassName}}>
        {{! Thumbnail }}
        {{#if this.hasThumbnail}}
          <img
            class={{this.thumbnailClassName}}
            src={{@thumbnail}}
            alt={{@thumbnailAlt}}
          />
        {{/if}}

        {{! Title }}
        {{#if this.hasTitle}}
          <h1 class={{this.titleClassName}}>{{@title}}</h1>
        {{/if}}

        {{! Body }}
        {{#if (has-block "body")}}
          <div class={{this.bodyClassName}}>
            {{yield to="body"}}
          </div>
        {{else if (has-block)}}
          <div class={{this.bodyClassName}}>
            {{yield}}
          </div>
        {{/if}}

        {{! Action }}
        {{#if (has-block "action")}}
          <div class={{this.actionClassName}}>
            {{yield to="action"}}
          </div>
        {{/if}}
      </div>
    </section>
  </template>
}
