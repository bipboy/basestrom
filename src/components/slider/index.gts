/**
 * Slider component - complete port from baseweb slider.
 *
 * Supports: single thumb, range (two thumbs), min/max/step, marks,
 * persistentThumb (always show label), valueToLabel formatting,
 * disabled state, keyboard navigation (Arrow keys, Home, End),
 * full a11y (role=slider, aria-valuemin/max/now/text).
 *
 * Usage:
 * ```hbs
 * <Bst::Slider @value={{this.sliderValue}} @onChange={{this.handleChange}} />
 *
 * {{! Range slider }}
 * <Bst::Slider @value={{this.rangeValue}} @onChange={{this.handleChange}} @marks={{true}} />
 *
 * {{! Stateful (uncontrolled) }}
 * <Bst::StatefulSlider @initialValue={{this.initial}} @onChange={{this.handleChange}} />
 * ```
 */
import { on } from '@ember/modifier';
import { htmlSafe } from '@ember/template';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride } from '../../helpers/overrides';
import { styles } from './styles.stylex';
import {
  type SliderOverrides,
  type SliderSignature,
  type StatefulSliderSignature,
} from './types';

// Re-export types
export { type SliderOverrides, type SliderSignature, type StatefulSliderSignature };

// ─── Helpers ────────────────────────────────────────────────────────────────────

function clamp(val: number, min: number, max: number): number {
  return Math.min(Math.max(val, min), max);
}

function roundToStep(val: number, step: number, min: number): number {
  const remainder = (val - min) % step;
  if (remainder === 0) return val;
  return remainder >= step / 2 ? val + (step - remainder) : val - remainder;
}

function getPercentage(value: number, min: number, max: number): number {
  if (max === min) return 0;
  return ((value - min) / (max - min)) * 100;
}

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Slider extends Component<SliderSignature> {
  @tracked private isDragging = false;
  @tracked private dragIndex = -1;
  @tracked private isHovered0 = false;
  @tracked private isHovered1 = false;
  @tracked private isFocusVisible = false;
  @tracked private focusedThumbIndex = -1;

  private trackElement: HTMLElement | null = null;

  // ─── Computed ───────────────────────────────────────────────────────────────

  get min(): number { return this.args.min ?? 0; }
  get max(): number { return this.args.max ?? 100; }
  get step(): number { return this.args.step ?? 1; }
  get disabled(): boolean { return this.args.disabled ?? false; }
  get marks(): boolean { return this.args.marks ?? false; }
  get persistentThumb(): boolean { return this.args.persistentThumb ?? false; }

  get value(): number[] {
    const v = this.args.value;
    if (!v || v.length === 0) return [this.min];
    if (v.length > 2) return [v[0]!, v[1]!];
    return v;
  }

  get isRange(): boolean { return this.value.length === 2; }

  get value0(): number { return this.value[0] ?? this.min; }
  get value1(): number { return this.value[1] ?? this.max; }

  get valueToLabel(): (value: number) => string {
    return this.args.valueToLabel ?? ((v: number) => String(v));
  }

  // Thumb 0 display label
  get showLabel0(): boolean {
    if (this.disabled) return false;
    if (this.persistentThumb) return true;
    return this.isHovered0 || (this.isDragging && this.dragIndex === 0);
  }

  // Thumb 1 display label
  get showLabel1(): boolean {
    if (this.disabled) return false;
    if (this.persistentThumb) return true;
    return this.isHovered1 || (this.isDragging && this.dragIndex === 1);
  }

  // Percentage positions
  get thumb0Percent(): number {
    return getPercentage(this.value[0]!, this.min, this.max);
  }

  get thumb1Percent(): number {
    if (!this.isRange) return 0;
    return getPercentage(this.value[1]!, this.min, this.max);
  }

  // Track gradient (inline style for dynamic coloring)
  // baseweb uses react-range's getTrackBackground which generates a linear-gradient.
  // Single thumb: [borderSelected(active), borderOpaque(inactive)] - active LEFT of thumb
  // Range: [borderOpaque(inactive), borderSelected(active), borderOpaque(inactive)]
  // Colors: active=#000000 (borderSelected), inactive=#F3F3F3 (borderOpaque)
  // Disabled: active=#F3F3F3 (borderOpaque), inactive=#F3F3F3 (borderStateDisabled)
  get trackGradient(): string {
    const active = this.disabled ? '#F3F3F3' : '#000000';
    const inactive = this.disabled ? '#F3F3F3' : '#F3F3F3';

    if (this.isRange) {
      const left = this.thumb0Percent;
      const right = this.thumb1Percent;
      // [inactive | active | inactive]
      return `linear-gradient(to right, ${inactive} ${left}%, ${active} ${left}%, ${active} ${right}%, ${inactive} ${right}%)`;
    }
    const pos = this.thumb0Percent;
    // [active | inactive] - active is to the LEFT of thumb
    return `linear-gradient(to right, ${active} ${pos}%, ${inactive} ${pos}%)`;
  }

  // Marks array
  get markPositions(): number[] {
    if (!this.marks) return [];
    const positions: number[] = [];
    for (let i = this.min; i <= this.max; i += this.step) {
      positions.push(i);
    }
    return positions;
  }

  // ─── Style class names ────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get trackClassName(): string | undefined {
    const resolved = resolveOverride(styles.track, this.args.overrides, 'track');
    const { className } = stylex.props(
      ...resolved,
      this.disabled && styles.trackDisabled,
      this.isDragging && styles.trackDragging,
    );
    return className || undefined;
  }

  get innerTrackClassName(): string | undefined {
    const resolved = resolveOverride(styles.innerTrack, this.args.overrides, 'innerTrack');
    const { className } = stylex.props(
      ...resolved,
      this.disabled && styles.innerTrackDisabled,
    );
    return className || undefined;
  }

  get tickBarClassName(): string | undefined {
    const resolved = resolveOverride(styles.tickBar, this.args.overrides, 'tickBar');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get tickClassName(): string | undefined {
    const resolved = resolveOverride(styles.tick, this.args.overrides, 'tick');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // Thumb classnames are computed per-thumb in template helpers
  thumbClassName(index: number): string | undefined {
    const isFocused = this.isFocusVisible && this.focusedThumbIndex === index;
    const resolved = resolveOverride(styles.thumb, this.args.overrides, 'thumb');
    const { className } = stylex.props(
      ...resolved,
      this.disabled && styles.thumbDisabled,
      this.isDragging && this.dragIndex === index && styles.thumbDragging,
      isFocused && styles.thumbFocusVisible,
    );
    return className || undefined;
  }

  get thumb0ClassName(): string | undefined { return this.thumbClassName(0); }
  get thumb1ClassName(): string | undefined { return this.thumbClassName(1); }

  get thumbValueClassName(): string | undefined {
    const resolved = resolveOverride(styles.thumbValue, this.args.overrides, 'thumbValue');
    const { className } = stylex.props(
      ...resolved,
      this.disabled && styles.thumbValueDisabled,
    );
    return className || undefined;
  }

  get innerThumbClassName(): string | undefined {
    const resolved = resolveOverride(styles.innerThumb, this.args.overrides, 'innerThumb');
    const { className } = stylex.props(
      ...resolved,
      this.disabled && styles.innerThumbDisabled,
    );
    return className || undefined;
  }

  get markClassName(): string | undefined {
    const resolved = resolveOverride(styles.mark, this.args.overrides, 'mark');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // ─── Inline styles (dynamic positioning) ──────────────────────────────────

  get thumb0Style(): string {
    return htmlSafe(`top: 50%; left: ${this.thumb0Percent}%; transform: translate(-50%, -50%)`).toString();
  }

  get thumb1Style(): string {
    return htmlSafe(`top: 50%; left: ${this.thumb1Percent}%; transform: translate(-50%, -50%)`).toString();
  }

  get innerTrackStyle(): string {
    return htmlSafe(`background: ${this.trackGradient}`).toString();
  }

  // ─── Value from pointer position ──────────────────────────────────────────

  private getValueFromPointer(clientX: number): number {
    const track = this.trackElement;
    if (!track) return this.min;
    const rect = track.getBoundingClientRect();
    const percent = clamp((clientX - rect.left) / rect.width, 0, 1);
    const raw = this.min + percent * (this.max - this.min);
    return clamp(roundToStep(raw, this.step, this.min), this.min, this.max);
  }

  private getClosestThumbIndex(clientX: number): number {
    if (!this.isRange) return 0;
    const newVal = this.getValueFromPointer(clientX);
    const dist0 = Math.abs(newVal - this.value[0]!);
    const dist1 = Math.abs(newVal - this.value[1]!);
    return dist0 <= dist1 ? 0 : 1;
  }

  // ─── Event handlers ───────────────────────────────────────────────────────

  handleTrackPointerDown = (event: PointerEvent) => {
    if (this.disabled) return;
    event.preventDefault();
    const target = event.currentTarget as HTMLElement;
    this.trackElement = target.querySelector('[data-slider-inner-track]') ?? target;

    const index = this.getClosestThumbIndex(event.clientX);
    this.dragIndex = index;
    this.isDragging = true;

    const newVal = this.getValueFromPointer(event.clientX);
    this.updateValue(index, newVal);

    target.setPointerCapture(event.pointerId);
  };

  handleTrackPointerMove = (event: PointerEvent) => {
    if (!this.isDragging || this.disabled) return;
    event.preventDefault();
    const newVal = this.getValueFromPointer(event.clientX);
    this.updateValue(this.dragIndex, newVal);
  };

  handleTrackPointerUp = (event: PointerEvent) => {
    if (!this.isDragging) return;
    this.isDragging = false;
    const target = event.currentTarget as HTMLElement;
    target.releasePointerCapture(event.pointerId);
    this.args.onFinalChange?.({ value: [...this.value] });
    this.dragIndex = -1;
  };

  // Keyboard navigation
  handleThumbKeyDown = (index: number, event: KeyboardEvent) => {
    if (this.disabled) return;
    const { key } = event;
    let newVal = this.value[index]!;

    switch (key) {
      case 'ArrowRight':
      case 'ArrowUp':
        newVal = clamp(newVal + this.step, this.min, this.max);
        event.preventDefault();
        break;
      case 'ArrowLeft':
      case 'ArrowDown':
        newVal = clamp(newVal - this.step, this.min, this.max);
        event.preventDefault();
        break;
      case 'Home':
        newVal = this.min;
        event.preventDefault();
        break;
      case 'End':
        newVal = this.max;
        event.preventDefault();
        break;
      default:
        return;
    }

    this.updateValue(index, newVal);
    this.args.onFinalChange?.({ value: [...this.value] });
  };

  handleThumb0KeyDown = (event: KeyboardEvent) => {
    this.handleThumbKeyDown(0, event);
  };

  handleThumb1KeyDown = (event: KeyboardEvent) => {
    this.handleThumbKeyDown(1, event);
  };

  // Focus visibility
  handleThumbFocus = (index: number, event: FocusEvent) => {
    const target = event.target as HTMLElement;
    if (target.matches(':focus-visible')) {
      this.isFocusVisible = true;
    }
    this.focusedThumbIndex = index;
  };

  handleThumb0Focus = (event: FocusEvent) => { this.handleThumbFocus(0, event); };
  handleThumb1Focus = (event: FocusEvent) => { this.handleThumbFocus(1, event); };

  handleThumbBlur = () => {
    this.isFocusVisible = false;
    this.focusedThumbIndex = -1;
  };

  // Hover
  handleThumb0MouseEnter = () => { this.isHovered0 = true; };
  handleThumb0MouseLeave = () => { this.isHovered0 = false; };
  handleThumb1MouseEnter = () => { this.isHovered1 = true; };
  handleThumb1MouseLeave = () => { this.isHovered1 = false; };

  // ─── Value update logic ───────────────────────────────────────────────────

  private updateValue(index: number, newVal: number): void {
    const current = [...this.value];

    if (this.isRange) {
      // Prevent thumbs from crossing
      if (index === 0) {
        newVal = Math.min(newVal, current[1]!);
      } else {
        newVal = Math.max(newVal, current[0]!);
      }
    }

    current[index] = newVal;
    this.args.onChange?.({ value: current });
  }

  // ─── Mark position helper ─────────────────────────────────────────────────

  markStyle = (markValue: number): string => {
    const pct = getPercentage(markValue, this.min, this.max);
    return htmlSafe(`left: ${pct}%`).toString();
  };

  <template>
    {{! template-lint-disable no-pointer-down-event-binding }}
    <div
      class={{this.rootClassName}}
      data-basestrom="slider"
      ...attributes
    >
      {{! Track area (pointer events) }}
      <div
        class={{this.trackClassName}}
        {{on "pointerdown" this.handleTrackPointerDown}}
        {{on "pointermove" this.handleTrackPointerMove}}
        {{on "pointerup" this.handleTrackPointerUp}}
      >
        {{! Inner track (the colored line) }}
        <div
          class={{this.innerTrackClassName}}
          style={{this.innerTrackStyle}}
          data-slider-inner-track
        >
          {{! Marks }}
          {{#if this.marks}}
            {{#each this.markPositions as |markVal|}}
              <div
                class={{this.markClassName}}
                style={{this.markStyle markVal}}
              ></div>
            {{/each}}
          {{/if}}

          {{! Thumb 0 }}
          <div
            class={{this.thumb0ClassName}}
            style={{this.thumb0Style}}
            role="slider"
            tabindex={{if this.disabled "-1" "0"}}
            aria-valuemin={{this.min}}
            aria-valuemax={{if this.isRange this.value1 this.max}}
            aria-valuenow={{this.value0}}
            aria-valuetext={{this.valueToLabel this.value0}}
            aria-disabled={{if this.disabled "true"}}
            aria-label="Slider thumb"
            {{on "keydown" this.handleThumb0KeyDown}}
            {{on "focus" this.handleThumb0Focus}}
            {{on "blur" this.handleThumbBlur}}
            {{on "mouseenter" this.handleThumb0MouseEnter}}
            {{on "mouseleave" this.handleThumb0MouseLeave}}
          >
            {{#if this.showLabel0}}
              <div class={{this.thumbValueClassName}}>
                {{this.valueToLabel this.value0}}
              </div>
              <div class={{this.innerThumbClassName}}></div>
            {{/if}}
          </div>

          {{! Thumb 1 (range mode) }}
          {{#if this.isRange}}
            <div
              class={{this.thumb1ClassName}}
              style={{this.thumb1Style}}
              role="slider"
              tabindex={{if this.disabled "-1" "0"}}
              aria-valuemin={{this.value0}}
              aria-valuemax={{this.max}}
              aria-valuenow={{this.value1}}
              aria-valuetext={{this.valueToLabel this.value1}}
              aria-disabled={{if this.disabled "true"}}
              aria-label="Slider thumb"
              {{on "keydown" this.handleThumb1KeyDown}}
              {{on "focus" this.handleThumb1Focus}}
              {{on "blur" this.handleThumbBlur}}
              {{on "mouseenter" this.handleThumb1MouseEnter}}
              {{on "mouseleave" this.handleThumb1MouseLeave}}
            >
              {{#if this.showLabel1}}
                <div class={{this.thumbValueClassName}}>
                  {{this.valueToLabel this.value1}}
                </div>
                <div class={{this.innerThumbClassName}}></div>
              {{/if}}
            </div>
          {{/if}}
        </div>
      </div>

      {{! Tick bar (min/max labels) }}
      <div class={{this.tickBarClassName}}>
        <div class={{this.tickClassName}}>
          {{this.valueToLabel this.min}}
        </div>
        <div class={{this.tickClassName}}>
          {{this.valueToLabel this.max}}
        </div>
      </div>
    </div>
  </template>
}

// ─── StatefulSlider ─────────────────────────────────────────────────────────────

export class StatefulSlider extends Component<StatefulSliderSignature> {
  @tracked value: number[];

  constructor(owner: any, args: StatefulSliderSignature['Args']) {
    super(owner, args);
    const min = args.min ?? 0;
    const max = args.max ?? 100;
    this.value = args.initialValue ?? [Math.round((max - min) / 2) + min];
  }

  handleChange = (params: { value: number[] }) => {
    this.value = params.value;
    this.args.onChange?.(params);
  };

  handleFinalChange = (params: { value: number[] }) => {
    this.value = params.value;
    this.args.onFinalChange?.(params);
  };

  <template>
    <Slider
      @value={{this.value}}
      @min={{@min}}
      @max={{@max}}
      @step={{@step}}
      @disabled={{@disabled}}
      @marks={{@marks}}
      @persistentThumb={{@persistentThumb}}
      @valueToLabel={{@valueToLabel}}
      @onChange={{this.handleChange}}
      @onFinalChange={{this.handleFinalChange}}
      @overrides={{@overrides}}
      ...attributes
    />
  </template>
}
