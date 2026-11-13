/**
 * ButtonDock component - complete port from baseweb button-dock.
 *
 * A layout container for action buttons, typically used at the bottom of a page
 * or modal for mobile CTAs. Supports responsive behavior via CSS container queries:
 * stacks actions vertically on narrow viewports and arranges them horizontally
 * when the container exceeds 600px inline-size.
 *
 * ## Features
 * - `primaryAction` - the main CTA button (required)
 * - `secondaryActions` - up to two secondary action buttons (named block)
 * - `dismissiveAction` - a dismissive/cancel action button (named block)
 * - `topAccessory` - slot for content above the action buttons (named block)
 * - Override system for `root`, `actionContainer`, `actionSubContainer` elements
 * - Container query responsive layout (column → row at >600px)
 *
 * ## Usage
 *
 * ```gts
 * import ButtonDock from 'basestrom/components/button-dock';
 * import Button from 'basestrom/components/button';
 *
 * <template>
 *   <ButtonDock>
 *     <:primaryAction>
 *       <Button @kind="primary">Submit</Button>
 *     </:primaryAction>
 *     <:dismissiveAction>
 *       <Button @kind="tertiary">Cancel</Button>
 *     </:dismissiveAction>
 *   </ButtonDock>
 * </template>
 * ```
 *
 * ## With secondary actions and top accessory
 *
 * ```gts
 * <ButtonDock>
 *   <:topAccessory>
 *     <p>Review your selections before continuing.</p>
 *   </:topAccessory>
 *   <:secondaryActions>
 *     <Button @kind="secondary">Save Draft</Button>
 *     <Button @kind="secondary">Preview</Button>
 *   </:secondaryActions>
 *   <:primaryAction>
 *     <Button @kind="primary">Publish</Button>
 *   </:primaryAction>
 *   <:dismissiveAction>
 *     <Button @kind="tertiary">Discard</Button>
 *   </:dismissiveAction>
 * </ButtonDock>
 * ```
 *
 * ## With overrides
 *
 * ```gts
 * import * as stylex from '@stylexjs/stylex';
 *
 * const dockOverrides = stylex.create({
 *   root: { boxShadow: '0 -2px 8px rgba(0,0,0,0.1)' },
 *   actionContainer: { gap: '16px' },
 * });
 *
 * <ButtonDock @overrides={{dockOverrides}}>
 *   <:primaryAction>
 *     <Button @kind="primary">Confirm</Button>
 *   </:primaryAction>
 * </ButtonDock>
 * ```
 */
import Component from '@glimmer/component';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type ButtonDockOverrides,
  type ButtonDockSignature,
} from './types';

export { type ButtonDockOverrides, type ButtonDockSignature };

/**
 * ButtonDock - a responsive action button container.
 *
 * Renders action buttons in a stacked column layout on narrow containers
 * and switches to a horizontal row layout when the container exceeds 600px.
 */
export default class ButtonDock extends Component<ButtonDockSignature> {
  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionContainer, this.args.overrides, 'actionContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionSubContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionSubContainer, this.args.overrides, 'actionSubContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get actionSubContainerReverseClassName(): string | undefined {
    const resolved = resolveOverride(styles.actionSubContainerReverse, this.args.overrides, 'actionSubContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  <template>
    <div
      class={{this.rootClassName}}
      ...attributes
      data-basestrom="button-dock"
    >
      {{#if (has-block "topAccessory")}}
        {{yield to="topAccessory"}}
      {{/if}}

      <div class={{this.actionContainerClassName}}>
        {{#if (has-block "secondaryActions")}}
          <div class={{this.actionSubContainerClassName}}>
            {{yield to="secondaryActions"}}
          </div>
        {{/if}}

        <div class={{this.actionSubContainerReverseClassName}}>
          {{#if (has-block "primaryAction")}}
            {{yield to="primaryAction"}}
          {{/if}}
          {{#if (has-block "dismissiveAction")}}
            {{yield to="dismissiveAction"}}
          {{/if}}
        </div>
      </div>
    </div>
  </template>
}
