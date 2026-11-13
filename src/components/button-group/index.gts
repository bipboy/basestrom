/**
 * ButtonGroup component - complete port from baseweb button-group.
 *
 * Renders a group of Button components with coordinated selection state,
 * keyboard navigation (roving tabindex for radio mode), and propagation
 * of kind, size, shape, and disabled props to child buttons.
 *
 * Supports two selection modes:
 * - `radio`: single selection with arrow-key navigation (radiogroup role)
 * - `checkbox`: multi-selection (group role with checkbox semantics)
 *
 * Also works as a simple clickable button group (no mode, no selected)
 * where buttons are just visually grouped without toggle semantics.
 *
 * Usage (radio mode - single selection):
 * ```hbs
 * <Bst::ButtonGroup
 *   @mode="radio"
 *   @selected={{this.selectedIndex}}
 *   @onClick={{this.handleClick}}
 *   @kind="secondary"
 *   @size="medium"
 *   as |group|
 * >
 *   <group.Button>Option A</group.Button>
 *   <group.Button>Option B</group.Button>
 *   <group.Button>Option C</group.Button>
 * </Bst::ButtonGroup>
 * ```
 *
 * Usage (checkbox mode - multi-selection):
 * ```hbs
 * <Bst::ButtonGroup
 *   @mode="checkbox"
 *   @selected={{array 0 2}}
 *   @onClick={{this.handleClick}}
 *   as |group|
 * >
 *   <group.Button>Bold</group.Button>
 *   <group.Button>Italic</group.Button>
 *   <group.Button>Underline</group.Button>
 * </Bst::ButtonGroup>
 * ```
 *
 * Usage (simple clickable group - no selection):
 * ```hbs
 * <Bst::ButtonGroup @kind="tertiary" @size="small" as |group|>
 *   <group.Button {{on "click" this.doA}}>Action A</group.Button>
 *   <group.Button {{on "click" this.doB}}>Action B</group.Button>
 * </Bst::ButtonGroup>
 * ```
 *
 * Usage (stateful - manages selection internally):
 * ```hbs
 * <Bst::StatefulButtonGroup
 *   @mode="radio"
 *   @initialSelected={{array 0}}
 *   @kind="secondary"
 *   as |group|
 * >
 *   <group.Button>One</group.Button>
 *   <group.Button>Two</group.Button>
 *   <group.Button>Three</group.Button>
 * </Bst::StatefulButtonGroup>
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride, type Overrides } from '../../helpers/overrides';
import Button, { KIND, SHAPE, SIZE, type ButtonKind, type ButtonShape, type ButtonSize } from '../button/index.gts';
import { styles } from './styles.stylex';
import {
  MODE,
  PADDING,
  STATE_CHANGE_TYPE,
  type ButtonGroupMode,
  type ButtonGroupOverrides,
  type ButtonGroupPadding,
  type ButtonGroupSignature,
  type StateReducer,
  type StatefulButtonGroupSignature,
} from './types';

// Re-export types and constants
export {
  KIND, MODE, PADDING, SHAPE,
  SIZE, STATE_CHANGE_TYPE, type ButtonGroupMode, type ButtonGroupOverrides, type ButtonGroupPadding, type ButtonGroupSignature,
  type StateReducer,
  type StatefulButtonGroupSignature
};

// ─── Helper ──────────────────────────────────────────────────────────────────

function isIndexSelected(selected: number | number[] | undefined, index: number): boolean {
  if (selected === undefined || selected === null) return false;
  if (Array.isArray(selected)) return selected.includes(index);
  return selected === index;
}

// ─── GroupButton (yielded child component) ───────────────────────────────────

interface GroupButtonSignature {
  Args: {
    /** Internal: injected by ButtonGroup. Do not set manually. */
    _groupContext?: ButtonGroupContext;
    /** Whether this specific button is disabled (in addition to group disabled). */
    disabled?: boolean;
    /** Override the group's isSelected for this button. */
    isSelected?: boolean;
    /** Per-button click handler (called before group onClick). */
    onClick?: (event: MouseEvent) => void;
    /** Per-button overrides. */
    overrides?: Overrides<string>;
  };
  Blocks: {
    default: [];
    startEnhancer: [];
    endEnhancer: [];
  };
  Element: HTMLButtonElement | HTMLAnchorElement;
}

interface ButtonGroupContext {
  kind: ButtonKind;
  size: ButtonSize;
  shape: ButtonShape;
  disabled: boolean;
  fullWidth: boolean;
  mode?: ButtonGroupMode;
  selected?: number | number[];
  isSimpleClickable: boolean;
  numItems: number;
  onClick?: (event: MouseEvent | KeyboardEvent, index: number) => void;
  childRefs: Map<number, HTMLButtonElement | HTMLAnchorElement | null>;
  registerButton: () => number;
  registerRef: (index: number, el: HTMLButtonElement | HTMLAnchorElement | null) => void;
}

class GroupButton extends Component<GroupButtonSignature> {
  private _index: number | null = null;

  get index(): number {
    if (this._index === null) {
      this._index = this.ctx?.registerButton?.() ?? 0;
    }
    return this._index;
  }

  get ctx(): ButtonGroupContext | undefined {
    return this.args._groupContext;
  }

  get isDisabled(): boolean {
    return this.args.disabled || this.ctx?.disabled || false;
  }

  get isSelected(): boolean | undefined {
    if (this.args.isSelected !== undefined) return this.args.isSelected;
    if (this.ctx?.isSimpleClickable) return undefined;
    return isIndexSelected(this.ctx?.selected, this.index);
  }

  get kind(): ButtonKind {
    return this.ctx?.kind ?? 'secondary';
  }

  get size(): ButtonSize {
    return this.ctx?.size ?? 'medium';
  }

  get shape(): ButtonShape {
    return this.ctx?.shape ?? 'default';
  }

  get fullWidth(): boolean {
    return this.ctx?.fullWidth ?? false;
  }

  get isRadio(): boolean {
    return this.ctx?.mode === MODE.radio;
  }

  get tabIndex(): string {
    if (!this.isRadio) return '0';
    if (this.isSelected) return '0';
    // If nothing is selected, first item is tabbable
    const selected = this.ctx?.selected;
    if (
      !selected ||
      selected === -1 ||
      (Array.isArray(selected) && selected.length === 0)
    ) {
      return this.index === 0 ? '0' : '-1';
    }
    return '-1';
  }

  get role(): string | undefined {
    if (this.isRadio) return 'radio';
    if (!this.ctx?.isSimpleClickable) return 'checkbox';
    return undefined;
  }

  get ariaChecked(): string | undefined {
    if (this.ctx?.isSimpleClickable) return undefined;
    return this.isSelected ? 'true' : 'false';
  }

  handleClick = (event: MouseEvent) => {
    if (this.isDisabled) return;
    // Call per-button onClick first
    this.args.onClick?.(event);
    // Then group onClick
    this.ctx?.onClick?.(event, this.index);
  };

  handleKeyDown = (event: KeyboardEvent) => {
    if (!this.isRadio || !this.ctx) return;

    const numItems = this.ctx.numItems;
    const currentSelected = Number(this.ctx.selected) || 0;

    if (event.key === 'ArrowUp' || event.key === 'ArrowLeft') {
      event.preventDefault();
      const prevIndex = currentSelected - 1 < 0 ? numItems - 1 : currentSelected - 1;
      this.ctx.onClick?.(event, prevIndex);
      const prevEl = this.ctx.childRefs.get(prevIndex);
      prevEl?.focus();
    }

    if (event.key === 'ArrowDown' || event.key === 'ArrowRight') {
      event.preventDefault();
      const nextIndex = currentSelected + 1 > numItems - 1 ? 0 : currentSelected + 1;
      this.ctx.onClick?.(event, nextIndex);
      const nextEl = this.ctx.childRefs.get(nextIndex);
      nextEl?.focus();
    }
  };

  registerElement = (element: Element) => {
    this.ctx?.registerRef(this.index, element as HTMLButtonElement | HTMLAnchorElement);
  };

  <template>
    {{! template-lint-disable no-positive-tabindex }}
    <Button
      @kind={{this.kind}}
      @size={{this.size}}
      @shape={{this.shape}}
      @disabled={{this.isDisabled}}
      @isSelected={{this.isSelected}}
      @fullWidth={{this.fullWidth}}
      @overrides={{@overrides}}
      aria-checked={{this.ariaChecked}}
      role={{this.role}}
      tabindex={{this.tabIndex}}
      {{on "click" this.handleClick}}
      {{on "keydown" this.handleKeyDown}}
      ...attributes
    >
      <:startEnhancer>{{yield to="startEnhancer"}}</:startEnhancer>
      <:default>{{yield}}</:default>
      <:endEnhancer>{{yield to="endEnhancer"}}</:endEnhancer>
    </Button>
  </template>
}

// ─── ButtonGroup ─────────────────────────────────────────────────────────────

export default class ButtonGroup extends Component<ButtonGroupSignature> {
  @tracked private childCount = 0;
  private childRefs = new Map<number, HTMLButtonElement | HTMLAnchorElement | null>();
  private nextIndex = 0;

  get kind(): ButtonKind {
    return this.args.kind ?? 'secondary';
  }

  get size(): ButtonSize {
    return this.args.size ?? 'medium';
  }

  get shape(): ButtonShape {
    return this.args.shape ?? 'default';
  }

  get disabled(): boolean {
    return this.args.disabled ?? false;
  }

  get fullWidth(): boolean {
    return this.args.fullWidth ?? false;
  }

  get padding(): ButtonGroupPadding {
    return this.args.padding ?? 'none';
  }

  get isRadio(): boolean {
    return this.args.mode === MODE.radio;
  }

  get isSimpleClickable(): boolean {
    const mode = this.args.mode;
    const hasMode = mode && Object.values(MODE).includes(mode as any);
    return !hasMode && this.args.selected === undefined;
  }

  get role(): string {
    return this.isRadio ? 'radiogroup' : 'group';
  }

  get ariaLabel(): string {
    return this.args['aria-label'] ?? 'button group';
  }

  // --- Styles ---

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(
      ...resolved,
      (this.size === 'xSmall') && styles.rowGapXSmall,
      this.wrapStyle,
      this.paddingStyle,
      this.fullWidth && styles.fullWidth,
    );
    return className || undefined;
  }

  get wrapStyle() {
    if (typeof this.args.wrap === 'boolean') {
      return this.args.wrap ? styles.wrap : styles.noWrap;
    }
    return null;
  }

  get paddingStyle() {
    switch (this.padding) {
      case 'default': return styles.paddingDefault;
      case 'none': return styles.paddingNone;
      case 'custom':
      default: return null;
    }
  }

  // --- Context for child buttons ---

  registerButton = (): number => {
    return this.nextIndex++;
  };

  registerRef = (index: number, el: HTMLButtonElement | HTMLAnchorElement | null) => {
    this.childRefs.set(index, el);
    this.childCount = this.childRefs.size;
  };

  get context(): ButtonGroupContext {
    return {
      kind: this.kind,
      size: this.size,
      shape: this.shape,
      disabled: this.disabled,
      fullWidth: this.fullWidth,
      mode: this.args.mode,
      selected: this.args.selected,
      isSimpleClickable: this.isSimpleClickable,
      numItems: this.childCount,
      onClick: this.args.onClick,
      childRefs: this.childRefs,
      registerButton: this.registerButton,
      registerRef: this.registerRef,
    };
  }

  <template>
    <div
      class={{this.rootClassName}}
      role={{this.role}}
      aria-label={{this.ariaLabel}}
      aria-labelledby={{@aria-labelledby}}
      aria-describedby={{@aria-describedby}}
      ...attributes
      data-basestrom="button-group"
    >
      {{yield (hash Button=(component GroupButton _groupContext=this.context))}}
    </div>
  </template>
}

// ─── StatefulButtonGroup ─────────────────────────────────────────────────────

function defaultStateReducer(
  _type: (typeof STATE_CHANGE_TYPE)[keyof typeof STATE_CHANGE_TYPE],
  nextState: { selected: number[] },
  _currentState: { selected: number[] },
): { selected: number[] } {
  return nextState;
}

export class StatefulButtonGroup extends Component<StatefulButtonGroupSignature> {
  @tracked selected: number[];

  constructor(owner: any, args: StatefulButtonGroupSignature['Args']) {
    super(owner, args);
    this.selected = args.initialSelected ?? [];
  }

  get stateReducer(): StateReducer {
    return this.args.stateReducer ?? defaultStateReducer;
  }

  private changeState(nextState: { selected: number[] }) {
    const reduced = this.stateReducer(
      STATE_CHANGE_TYPE.change,
      nextState,
      { selected: this.selected },
    );
    this.selected = reduced.selected;
  }

  handleClick = (event: MouseEvent | KeyboardEvent, index: number) => {
    if (this.args.mode === MODE.radio) {
      if (this.selected.length === 0 || this.selected[0] !== index) {
        this.changeState({ selected: [index] });
      } else {
        this.changeState({ selected: [] });
      }
    }

    if (this.args.mode === MODE.checkbox) {
      if (!this.selected.includes(index)) {
        this.changeState({ selected: [...this.selected, index] });
      } else {
        this.changeState({ selected: this.selected.filter((v) => v !== index) });
      }
    }

    this.args.onClick?.(event, index);
  };

  <template>
    <ButtonGroup
      @mode={{@mode}}
      @disabled={{@disabled}}
      @selected={{this.selected}}
      @onClick={{this.handleClick}}
      @kind={{@kind}}
      @size={{@size}}
      @shape={{@shape}}
      @wrap={{@wrap}}
      @fullWidth={{@fullWidth}}
      @padding={{@padding}}
      @overrides={{@overrides}}
      aria-label={{@aria-label}}
      aria-labelledby={{@aria-labelledby}}
      aria-describedby={{@aria-describedby}}
      ...attributes
      as |group|
    >
      {{yield group}}
    </ButtonGroup>
  </template>
}
