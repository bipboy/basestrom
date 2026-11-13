/**
 * SegmentedControl + Segment - 1:1 port of baseweb segmented-control.
 *
 * Architecture mirrors baseweb's React implementation:
 * - SegmentedControl yields a context object (group) consumed by Segment.
 * - The active segment registers its DOM element with the group.
 * - On every `activeKey` change the group re-measures the active segment
 *   (`length` and `distance`) and applies them to the absolutely-positioned
 *   highlight pane.
 * - The animation flag (`$animate` in baseweb) is enabled only after the
 *   first activeKey transition - matching baseweb's `keyUpdated > 1` check
 *   so the highlight does not slide in from the side on initial mount.
 *
 * Usage:
 * ```hbs
 * <Bst::SegmentedControl @activeKey={{this.tab}} @onChange={{this.handle}} as |group|>
 *   <Bst::Segment @group={{group}} @key="day"   @label="Day" />
 *   <Bst::Segment @group={{group}} @key="week"  @label="Week" />
 *   <Bst::Segment @group={{group}} @key="month" @label="Month" />
 * </Bst::SegmentedControl>
 * ```
 */
import { registerDestructor } from '@ember/destroyable';
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { bstOnArgsChange, bstRef } from '../../modifiers';
import {
  activeStyles,
  artworkContainerStyles,
  badgeHintStyles,
  badgeStyles,
  descriptionStyles,
  labelBlockStyles,
  labelStyles,
  rootStyles,
  segmentListStyles,
  segmentStyles,
} from './styles.stylex';
import {
  FILL,
  SIZE,
  type Fill,
  type SegmentedControlContext,
  type SegmentedControlOverrides,
  type SegmentedControlSignature,
  type SegmentedControlSize,
  type SegmentOverrides,
  type SegmentSignature,
} from './types';

export {
  FILL,
  SIZE,
  type Fill, type SegmentedControlContext, type SegmentedControlOverrides, type SegmentedControlSignature, type SegmentedControlSize, type SegmentOverrides, type SegmentSignature
};

// Make modifiers available in strict-mode template with original names
const onArgsChange = bstOnArgsChange;
const ref = bstRef;

// --- SegmentedControl -------------------------------------------------------

export class SegmentedControl extends Component<SegmentedControlSignature> {
  /** Highlight measurement (matches baseweb's `highlightLayout` state). */
  @tracked highlightLength = 0;
  @tracked highlightDistance = 0;

  /**
   * Mirrors baseweb's `keyUpdated` counter. Starts at 0, becomes 1 on
   * mount via the `onArgsChange` modifier (acts like a mount effect),
   * and increments on every subsequent activeKey change. The highlight
   * animates only when this counter is > 1, so the very first mount
   * does not animate but every user-initiated change does.
   */
  @tracked private keyUpdated = 0;

  /** Map of segment key -> element. */
  private segmentElements = new Map<string | number, HTMLElement>();
  private resizeObserver: ResizeObserver | null = null;

  constructor(owner: any, args: SegmentedControlSignature['Args']) {
    super(owner, args);

    if (typeof ResizeObserver !== 'undefined') {
      this.resizeObserver = new ResizeObserver(() => this.updateHighlight());
    }

    registerDestructor(this, () => {
      this.resizeObserver?.disconnect();
      this.resizeObserver = null;
      this.segmentElements.clear();
    });
  }


  // -- Resolved props --------------------------------------------------------

  get activeKey(): string | number {
    return this.args.activeKey ?? '0';
  }

  get isDisabled(): boolean {
    return this.args.disabled ?? false;
  }

  get fill(): Fill {
    return this.args.fill ?? 'intrinsic';
  }

  get size(): SegmentedControlSize {
    return this.args.size ?? 'medium';
  }

  get activateOnFocus(): boolean {
    return this.args.activateOnFocus ?? true;
  }

  /** Mirrors baseweb's `keyUpdated > 1` flag. */
  get shouldAnimate(): boolean {
    return this.keyUpdated > 1;
  }

  // -- Highlight measurement -------------------------------------------------

  /** Measure the active segment and update tracked highlight values. */
  private updateHighlight = (): void => {
    const el = this.segmentElements.get(this.activeKey);
    if (!el) {
      this.highlightLength = 0;
      this.highlightDistance = 0;
      return;
    }
    const { width } = el.getBoundingClientRect();
    this.highlightLength = Math.floor(width);
    this.highlightDistance = el.offsetLeft;
  };

  /**
   * Render-modifier callback bound to `activeKey`. Equivalent to baseweb's
   * `useEffect(() => setKeyUpdated(c + 1), [activeKey])`. Runs once on
   * mount and on every activeKey change.
   *
   * The increment of `keyUpdated` and the highlight measurement are both
   * deferred to the next animation frame. This is required for two reasons:
   *
   * 1. Glimmer forbids writing tracked state in the same render computation
   *    that read it (the template reads `shouldAnimate` -> `keyUpdated`).
   *    rAF puts the write in a fresh computation.
   * 2. The active segment's bounding rect is only stable after the browser
   *    has laid out the new DOM, so we need to wait one frame anyway.
   */
  onActiveKeyChange = (_el: Element, _activeKey: unknown): void => {
    requestAnimationFrame(() => {
      this.keyUpdated += 1;
      this.updateHighlight();
    });
  };


  // -- Context callbacks (consumed by <Bst::Segment>) -----------------------

  registerSegment = (key: string | number, el: HTMLElement | null): void => {
    if (el) {
      this.segmentElements.set(key, el);
      this.resizeObserver?.observe(el);
      // If this is the active segment, schedule a re-measure since its
      // size/position may have changed.
      if (key === this.activeKey) {
        requestAnimationFrame(() => this.updateHighlight());
      }
    } else {
      const existing = this.segmentElements.get(key);
      if (existing) this.resizeObserver?.unobserve(existing);
      this.segmentElements.delete(key);
    }
  };

  selectSegment = (key: string | number): void => {
    if (this.isDisabled) return;
    if (key === this.activeKey) return;
    this.args.onChange?.({ activeKey: key });
  };

  onSegmentKeyDown = (event: KeyboardEvent, _key: string | number): void => {
    const target = event.target as HTMLElement;
    const parent = target.parentElement;
    if (!parent) return;

    const segments = Array.from(
      parent.querySelectorAll<HTMLElement>('[role="option"]'),
    ).filter((el) => !(el as HTMLButtonElement).disabled);
    if (segments.length <= 1) return;

    const idx = segments.indexOf(target);
    if (idx === -1) return;

    let next: HTMLElement | null = null;
    if (event.key === 'ArrowLeft') {
      next = segments[idx - 1] ?? segments[segments.length - 1] ?? null;
    } else if (event.key === 'ArrowRight') {
      next = segments[idx + 1] ?? segments[0] ?? null;
    }
    if (!next) return;

    event.preventDefault();
    next.focus();
    if (this.activateOnFocus) next.click();
  };


  // -- Styles ----------------------------------------------------------------

  get rootSizeStyle() {
    switch (this.size) {
      case 'small': return rootStyles.sizeSmall;
      case 'large': return rootStyles.sizeLarge;
      default: return rootStyles.sizeMedium;
    }
  }

  get segmentListSizeStyle() {
    switch (this.size) {
      case 'small': return segmentListStyles.sizeSmall;
      case 'large': return segmentListStyles.sizeLarge;
      default: return segmentListStyles.sizeMedium;
    }
  }

  get activeSizeStyle() {
    switch (this.size) {
      case 'small': return activeStyles.sizeSmall;
      case 'large': return activeStyles.sizeLarge;
      default: return activeStyles.sizeMedium;
    }
  }

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(rootStyles.base, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      this.rootSizeStyle,
      this.fill === 'intrinsic' && rootStyles.intrinsic,
    );
    return className || undefined;
  }

  get rootStyle(): string {
    const w = this.args.width ?? 'fit-content';
    const h = this.args.height ?? 'fit-content';
    return htmlSafe(`width:${w};height:${h}`).toString();
  }

  get segmentListClassName(): string | undefined {
    const resolved = resolveOverride(
      segmentListStyles.base,
      this.args.overrides,
      'segmentList',
    );
    const { className } = stylex.props(...resolved, this.segmentListSizeStyle);
    return className || undefined;
  }

  get activeClassName(): string | undefined {
    const resolved = resolveOverride(activeStyles.base, this.args.overrides, 'active');
    const { className } = stylex.props(
      ...resolved,
      this.activeSizeStyle,
      this.shouldAnimate && activeStyles.animate,
    );
    return className || undefined;
  }

  get activeStyle(): string {
    return htmlSafe(`width:${this.highlightLength}px;transform:translateX(${this.highlightDistance}px)`).toString();
  }

  // -- Yielded context -------------------------------------------------------

  get context(): SegmentedControlContext {
    return {
      activeKey: this.activeKey,
      disabled: this.isDisabled,
      fill: this.fill,
      size: this.size,
      activateOnFocus: this.activateOnFocus,
      registerSegment: this.registerSegment,
      selectSegment: this.selectSegment,
      onSegmentKeyDown: this.onSegmentKeyDown,
    };
  }


  <template>
    <div
      class={{this.rootClassName}}
      style={{this.rootStyle}}
      ...attributes
      data-basestrom="segmented-control"
    >
      <div
        class={{this.segmentListClassName}}
        role="listbox"
        aria-label="segmented control"
        data-basestrom="segment-list"
        {{bstOnArgsChange this.onActiveKeyChange this.activeKey}}
      >
        {{yield this.context}}
        <div
          class={{this.activeClassName}}
          style={{this.activeStyle}}
          aria-hidden="true"
          role="presentation"
          data-basestrom="segment-highlight"
        ></div>
      </div>
    </div>
  </template>
}


// --- Segment ----------------------------------------------------------------

export class Segment extends Component<SegmentSignature> {
  @tracked private isFocusVisible = false;

  // -- Resolved state --------------------------------------------------------

  get isActive(): boolean {
    return this.args.group?.activeKey === this.args.key;
  }

  get isDisabled(): boolean {
    if (this.args.disabled) return true;
    // Match baseweb: disabled prop on segments only takes effect on
    // non-active segments when group is disabled.
    if (!this.isActive && this.args.group?.disabled) return true;
    return false;
  }

  get tabIndex(): number {
    return this.isActive ? 0 : -1;
  }


  // -- Styles ----------------------------------------------------------------

  get segmentSizeStyle() {
    switch (this.args.group?.size) {
      case 'small': return segmentStyles.sizeSmall;
      case 'large': return segmentStyles.sizeLarge;
      default: return segmentStyles.sizeMedium;
    }
  }

  get labelSizeStyle() {
    switch (this.args.group?.size) {
      case 'small': return labelStyles.sizeSmall;
      case 'large': return labelStyles.sizeLarge;
      default: return labelStyles.sizeMedium;
    }
  }

  get descriptionSizeStyle() {
    switch (this.args.group?.size) {
      case 'small': return descriptionStyles.sizeSmall;
      case 'large': return descriptionStyles.sizeLarge;
      default: return descriptionStyles.sizeMedium;
    }
  }

  get artworkSizeStyle() {
    switch (this.args.group?.size) {
      case 'small': return artworkContainerStyles.sizeSmall;
      case 'large': return artworkContainerStyles.sizeLarge;
      default: return artworkContainerStyles.sizeMedium;
    }
  }

  get segmentClassName(): string | undefined {
    const resolved = resolveOverride(segmentStyles.base, this.args.overrides, 'segment');
    const { className } = stylex.props(
      ...resolved,
      this.segmentSizeStyle,
      this.isActive && segmentStyles.active,
      this.isDisabled && segmentStyles.disabled,
      this.isFocusVisible && segmentStyles.focusVisible,
      this.args.group?.fill === 'fixed' && segmentStyles.fillFixed,
    );
    return className || undefined;
  }

  get labelBlockClassName(): string | undefined {
    const resolved = resolveOverride(labelBlockStyles.base, this.args.overrides, 'labelBlock');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get artworkContainerClassName(): string | undefined {
    const resolved = resolveOverride(
      artworkContainerStyles.base,
      this.args.overrides,
      'artworkContainer',
    );
    const { className } = stylex.props(...resolved, this.artworkSizeStyle);
    return className || undefined;
  }

  get labelClassName(): string | undefined {
    const resolved = resolveOverride(labelStyles.base, this.args.overrides, 'label');
    const { className } = stylex.props(...resolved, this.labelSizeStyle);
    return className || undefined;
  }

  get descriptionClassName(): string | undefined {
    const resolved = resolveOverride(descriptionStyles.base, this.args.overrides, 'description');
    const { className } = stylex.props(...resolved, this.descriptionSizeStyle);
    return className || undefined;
  }

  get badgeClassName(): string | undefined {
    const resolved = resolveOverride(badgeStyles.base, this.args.overrides, 'badge');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get badgeHintClassName(): string | undefined {
    const resolved = resolveOverride(badgeHintStyles.base, this.args.overrides, 'badgeHint');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }


  // -- Refs / handlers -------------------------------------------------------

  /** Render-modifier ref callback. */
  captureElement = (el: Element | null) => {
    this.args.group?.registerSegment(this.args.key, (el as HTMLElement | null) ?? null);
  };

  handleClick = () => {
    if (this.isDisabled) return;
    this.args.group?.selectSegment(this.args.key);
  };

  handleKeyDown = (event: KeyboardEvent) => {
    this.args.group?.onSegmentKeyDown(event, this.args.key);
  };

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
    {{! template-lint-disable no-positive-tabindex }}
    <button
      type="button"
      class={{this.segmentClassName}}
      role="option"
      aria-selected={{if this.isActive "true" "false"}}
      tabindex={{this.tabIndex}}
      disabled={{this.isDisabled}}
      ...attributes
      data-basestrom="segment"
      {{bstRef this.captureElement}}
      {{on "click" this.handleClick}}
      {{on "keydown" this.handleKeyDown}}
      {{on "focus" this.handleFocus}}
      {{on "blur" this.handleBlur}}
    >
      <span class={{this.labelBlockClassName}}>
        {{#if (has-block "artwork")}}
          <span class={{this.artworkContainerClassName}}>
            {{yield to="artwork"}}
          </span>
        {{/if}}
        {{#if @label}}
          <span class={{this.labelClassName}}>{{@label}}</span>
        {{/if}}
        {{#if @badge}}
          <span class={{this.badgeClassName}}>{{@badge}}</span>
        {{/if}}
        {{#if @badgeHint}}
          <span class={{this.badgeHintClassName}}></span>
        {{/if}}
      </span>
      {{#if @description}}
        <span class={{this.descriptionClassName}}>{{@description}}</span>
      {{/if}}
    </button>
  </template>
}
