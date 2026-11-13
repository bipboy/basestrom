/**
 * Button component - complete port from baseweb button.
 *
 * Supports: 6 kinds, 4 sizes, 4 shapes, loading, selected, disabled,
 * backgroundSafe (FAB), fullWidth, href (link button), Ember router
 * navigation via @route / @model / @models / @query, minHitArea,
 * custom colors, start/end enhancers via named blocks.
 *
 * Uses Interactive component for element rendering (button/anchor/LinkTo).
 */
import type { TOC } from '@ember/component/template-only';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { colors } from '../../themes/vars.stylex';
import Interactive from '../interactive/index.gts';
import Spinner from '../spinner/index.gts';
import { styles } from './styles.stylex';
import {
  KIND,
  SHAPE,
  SIZE,
  type ButtonKind,
  type ButtonOverrides,
  type ButtonShape,
  type ButtonSignature,
  type ButtonSize,
  type SpinnerOverrides,
} from './types';

export {
  KIND, SHAPE, SIZE, type ButtonKind, type ButtonOverrides, type ButtonShape, type ButtonSignature, type ButtonSize
};

// ─── Inner body (content + loading + enhancers) ─────────────────────────────────
// Extracted as a template-only component so the tree of conditionals is declared
// once and reused across all rendering branches.

interface BodySignature {
  Args: {
    isLoading: boolean;
    hasStart: boolean;
    hasEnd: boolean;
    loadingContentClassName: string | undefined;
    startEnhancerClassName: string | undefined;
    endEnhancerClassName: string | undefined;
    spinnerContainerClassName: string | undefined;
    spinnerBoxSize: string;
    spinnerBorderWidth: string;
    spinnerColor: string;
    spinnerOverrides: SpinnerOverrides | undefined;
  };
  Blocks: {
    default: [];
    startEnhancer: [];
    endEnhancer: [];
  };
}

const Body: TOC<BodySignature> = <template>
  {{#if @isLoading}}
    <span class={{@loadingContentClassName}}>
      {{#if @hasStart}}
        <span class={{@startEnhancerClassName}}>{{yield to="startEnhancer"}}</span>
      {{/if}}
      {{yield}}
      {{#if @hasEnd}}
        <span class={{@endEnhancerClassName}}>{{yield to="endEnhancer"}}</span>
      {{/if}}
    </span>
    <span class={{@spinnerContainerClassName}}>
      <Spinner
        @boxSize={{@spinnerBoxSize}}
        @borderWidth={{@spinnerBorderWidth}}
        @color={{@spinnerColor}}
        @overrides={{@spinnerOverrides}}
      />
    </span>
  {{else}}
    {{#if @hasStart}}
      <span class={{@startEnhancerClassName}}>{{yield to="startEnhancer"}}</span>
    {{/if}}
    {{yield}}
    {{#if @hasEnd}}
      <span class={{@endEnhancerClassName}}>{{yield to="endEnhancer"}}</span>
    {{/if}}
  {{/if}}
</template>;

// ─── Button ─────────────────────────────────────────────────────────────────────

export default class Button extends Component<ButtonSignature> {
  @tracked isFocusVisible = false;

  get kind(): ButtonKind { return this.args.kind ?? 'primary'; }
  get size(): ButtonSize { return this.args.size ?? 'medium'; }
  get shape(): ButtonShape { return this.args.shape ?? 'default'; }
  get isLoading(): boolean { return this.args.isLoading ?? false; }
  get isSelected(): boolean { return this.args.isSelected ?? false; }
  get isDisabled(): boolean { return this.args.disabled ?? false; }
  get isIconShape(): boolean { return this.shape === 'circle' || this.shape === 'square'; }
  get backgroundSafe(): boolean { return this.args.backgroundSafe ?? false; }

  get kindStyle() {
    if (this.isDisabled && this.isSelected) return styles.disabledSelected;
    if (this.isDisabled) return styles.disabled;
    if (this.isSelected) {
      switch (this.kind) {
        case 'primary': return styles.primarySelected;
        case 'secondary': return styles.secondarySelected;
        case 'tertiary': return styles.tertiarySelected;
        default: return styles.primarySelected;
      }
    }
    return styles[this.kind];
  }

  get sizeStyle() {
    if (this.isIconShape) {
      switch (this.size) {
        case 'xSmall': return styles.iconXSmall;
        case 'small': return styles.iconSmall;
        case 'large': return styles.iconLarge;
        default: return styles.iconMedium;
      }
    }
    switch (this.size) {
      case 'xSmall': return styles.sizeXSmall;
      case 'small': return styles.sizeSmall;
      case 'large': return styles.sizeLarge;
      default: return styles.sizeMedium;
    }
  }

  get shapeStyle() {
    switch (this.shape) {
      case 'pill': return styles.shapePill;
      case 'circle': return styles.shapeCircle;
      case 'square': return styles.shapeSquare;
      default: return styles.shapeDefault;
    }
  }

  get spinnerColorStyle() {
    if (this.isDisabled) return String(colors.contentStateDisabled);
    return String(colors.borderAccent);
  }

  get spinnerBoxSize(): string {
    switch (this.size) {
      case 'xSmall': return '12px';
      case 'small':  return '16px';
      case 'large':  return '24px';
      default:       return '20px';
    }
  }

  get spinnerBorderWidth(): string {
    return '2px';
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.base, this.args.overrides, 'root');
    const focusStyle = this.isFocusVisible && !this.isDisabled
      ? (this.backgroundSafe ? styles.focusVisibleBackgroundSafe : styles.focusVisible)
      : null;

    const { className } = stylex.props(
      ...resolved,
      this.kindStyle,
      this.sizeStyle,
      this.shapeStyle,
      this.isLoading && styles.baseLoading,
      this.args.fullWidth && styles.widthFill,
      this.backgroundSafe && !this.isFocusVisible && !this.isDisabled && !this.isSelected && styles.backgroundSafe,
      this.args.minHitArea === 'tap' && styles.minHitAreaTap,
      focusStyle,
    );
    return className || undefined;
  }

  get rootStyle(): string | undefined {
    const parts: string[] = [];
    if (this.args.colors && !this.isDisabled) {
      parts.push(`background-color:${this.args.colors.backgroundColor}`);
      parts.push(`color:${this.args.colors.color}`);
    }
    return parts.length > 0 ? parts.join(';') : undefined;
  }

  get startEnhancerClassName(): string | undefined {
    const resolved = resolveOverride(styles.startEnhancer, this.args.overrides, 'startEnhancer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get endEnhancerClassName(): string | undefined {
    const resolved = resolveOverride(styles.endEnhancer, this.args.overrides, 'endEnhancer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get spinnerOverrides(): SpinnerOverrides | undefined {
    const fromConsumer = this.args.overrides?.spinner;
    if (!fromConsumer) return undefined;
    return { root: fromConsumer };
  }

  get spinnerContainerClassName(): string | undefined {
    const { className } = stylex.props(styles.spinnerContainer);
    return className || undefined;
  }

  get loadingContentClassName(): string | undefined {
    const { className } = stylex.props(styles.loadingContent);
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
      class={{this.rootClassName}}
      style={{this.rootStyle}}
      @route={{@route}}
      @model={{@model}}
      @models={{@models}}
      @query={{@query}}
      @href={{@href}}
      @target={{@target}}
      @rel={{@rel}}
      @disabled={{this.isDisabled}}
      @type={{@type}}
      ...attributes
      data-basestrom="button"
      {{on "focus" this.handleFocus}}
      {{on "blur" this.handleBlur}}
    >
      <Body
        @isLoading={{this.isLoading}}
        @hasStart={{has-block "startEnhancer"}}
        @hasEnd={{has-block "endEnhancer"}}
        @loadingContentClassName={{this.loadingContentClassName}}
        @startEnhancerClassName={{this.startEnhancerClassName}}
        @endEnhancerClassName={{this.endEnhancerClassName}}
        @spinnerContainerClassName={{this.spinnerContainerClassName}}
        @spinnerBoxSize={{this.spinnerBoxSize}}
        @spinnerBorderWidth={{this.spinnerBorderWidth}}
        @spinnerColor={{this.spinnerColorStyle}}
        @spinnerOverrides={{this.spinnerOverrides}}
      >
        <:default>{{yield}}</:default>
        <:startEnhancer>{{yield to="startEnhancer"}}</:startEnhancer>
        <:endEnhancer>{{yield to="endEnhancer"}}</:endEnhancer>
      </Body>
    </Interactive>
  </template>
}
