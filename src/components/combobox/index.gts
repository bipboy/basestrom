/**
 * Combobox component - port from baseweb combobox.
 *
 * A text-input-with-listbox component built on ember-basic-dropdown.
 * Pairs the reused Input component with a filterable option listbox
 * that supports keyboard navigation and selection.
 *
 * Usage:
 * ```hbs
 * <Bst::Combobox
 *   @value={{this.value}}
 *   @options={{this.options}}
 *   @mapOptionToString={{this.mapOptionToString}}
 *   @onChange={{this.handleChange}}
 * />
 * ```
 */
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import BasicDropdown from 'ember-basic-dropdown/components/basic-dropdown';
import { generateId } from '../../a11y/index';
import { resolveOverride } from '../../helpers/overrides';
import { bstRef } from '../../modifiers';
import Input from '../input/index.gts';
import { scrollItemIntoView } from './scroll-into-view';
import { styles } from './styles.stylex';
import {
    SIZE,
    type ComboboxOverrides,
    type ComboboxSignature,
    type ComboboxSize,
} from './types';

// Re-export types and constants
export {
    SIZE, type ComboboxOverrides,
    type ComboboxSignature, type ComboboxSize
};

// Make modifier available in strict-mode template with original name
const ref = bstRef;

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Combobox<Option = unknown> extends Component<ComboboxSignature<Option>> {
  @tracked selectionIndex = -1;
  @tracked tempValue: string | null = null;

  private listboxEl: HTMLElement | null = null;
  private optionEls = new Map<number, HTMLElement>();
  private readonly listboxId = generateId('combobox-listbox');
  private readonly activeBaseId = generateId('combobox-option');

  // ─── Computed properties ────────────────────────────────────────────────────

  get size(): ComboboxSize { return this.args.size ?? 'default'; }
  get disabled(): boolean { return this.args.disabled ?? false; }
  get autocomplete(): boolean { return this.args.autocomplete ?? true; }

  get optionCount(): number {
    return this.filteredOptions.length;
  }

  get filteredOptions(): Option[] {
    const { options, mapOptionToString, value } = this.args;
    if (!mapOptionToString || !options || options.length === 0) {
      return [];
    }
    const query = (value ?? '').toLowerCase();
    if (!query) return options;
    return options.filter(
      (opt) => mapOptionToString(opt).toLowerCase().includes(query),
    );
  }

  /**
   * Clamped selection index that guards against stale out-of-range values.
   * When `filteredOptions` shrinks (e.g., user types more characters),
   * the raw `selectionIndex` may exceed `optionCount - 1`. This getter
   * clamps it to `-1` in that case, ensuring ARIA and display logic
   * never reference a non-existent option.
   */
  get clampedSelectionIndex(): number {
    const idx = this.selectionIndex;
    if (idx < 0) return -1;
    if (idx >= this.optionCount) return -1;
    return idx;
  }

  /**
   * The value displayed in the Input.
   * Priority:
   * 1. If `tempValue` is not null (explicitly set during navigation), use it.
   * 2. If autocomplete is enabled and a valid option is highlighted,
   *    show that option's string as a preview.
   * 3. Otherwise, show the committed value.
   */
  get displayValue(): string {
    if (this.tempValue != null) return this.tempValue;
    const idx = this.clampedSelectionIndex;
    if (this.autocomplete && idx >= 0) {
      const option = this.filteredOptions[idx];
      if (option !== undefined) {
        return this.args.mapOptionToString?.(option) ?? '';
      }
    }
    return this.args.value ?? '';
  }

  get activeDescendantId(): string | undefined {
    const idx = this.clampedSelectionIndex;
    if (idx >= 0) {
      return this.optionId(idx);
    }
    return undefined;
  }

  // ─── Style computations ───────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'Root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get listBoxClassName(): string | undefined {
    const resolved = resolveOverride(styles.listBox, this.args.overrides, 'ListBox');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  // ─── Helper methods ───────────────────────────────────────────────────────

  optionId = (index: number): string => {
    return `${this.activeBaseId}-${index}`;
  };

  optionString = (option: Option): string => {
    return this.args.mapOptionToString?.(option) ?? '';
  };

  listItemClassName = (index: number): string | undefined => {
    const sizeStyle = this.listItemSizeStyle;
    const isSelected = index === this.clampedSelectionIndex;
    const resolved = resolveOverride(styles.listItem, this.args.overrides, 'ListItem');
    const { className } = stylex.props(
      ...resolved,
      sizeStyle,
      isSelected && styles.listItemSelected,
      this.disabled && styles.listItemDisabled,
    );
    return className || undefined;
  };

  get listItemSizeStyle() {
    switch (this.size) {
      case 'mini': return styles.listItemMini;
      case 'compact': return styles.listItemCompact;
      case 'large': return styles.listItemLarge;
      default: return styles.listItemDefault;
    }
  }

  // ─── Element capture ──────────────────────────────────────────────────────

  captureListbox = (el: Element | null): void => {
    this.listboxEl = el as HTMLElement | null;
  };

  captureOption = (index: number, el: Element | null): void => {
    if (el) {
      this.optionEls.set(index, el as HTMLElement);
    } else {
      this.optionEls.delete(index);
    }
  };

  // ─── Event handlers ────────────────────────────────────────────────────────

  handleInputChange = (dd: { isOpen: boolean; actions: { open: () => void; close: () => void; toggle: () => void } }, event: Event): void => {
    if (this.disabled) return;
    const newValue = (event.target as HTMLInputElement).value;
    this.selectionIndex = -1;
    this.tempValue = null;
    if (!dd.isOpen) {
      dd.actions.open();
    }
    this.args.onChange(newValue, null);
  };

  handleFocus = (_event: FocusEvent): void => {
    this.args.onFocus?.(_event);
  };

  handleBlur = (event: FocusEvent): void => {
    const relatedTarget = event.relatedTarget as Node | null;
    if (relatedTarget && this.listboxEl?.contains(relatedTarget)) {
      return;
    }
    this.selectionIndex = -1;
    this.tempValue = null;
    this.args.onBlur?.(event);
  };

  handleKeyDown = (dd: { isOpen: boolean; actions: { open: () => void; close: () => void; toggle: () => void } }, event: KeyboardEvent): void => {
    if (this.disabled) return;

    const { key } = event;
    const { optionCount } = this;

    if (key === 'ArrowDown') {
      event.preventDefault();

      if (!dd.isOpen) {
        dd.actions.open();
      }

      if (optionCount === 0) {
        this.selectionIndex = -1;
        return;
      }

      let next = this.selectionIndex + 1;
      if (next > optionCount - 1) next = -1;
      this.selectionIndex = next;

      this.scrollToSelection(next, optionCount);
      return;
    }

    if (key === 'ArrowUp') {
      event.preventDefault();

      if (optionCount === 0) {
        this.selectionIndex = -1;
        return;
      }

      let next = this.selectionIndex - 1;
      if (next < -1) next = optionCount - 1;
      this.selectionIndex = next;

      this.scrollToSelection(next, optionCount);
      return;
    }

    if (key === 'Enter') {
      const idx = this.clampedSelectionIndex;
      if (idx >= 0) {
        const option = this.filteredOptions[idx];
        dd.actions.close();
        this.selectionIndex = -1;
        this.tempValue = null;
        if (option !== undefined) {
          this.args.onChange(this.args.mapOptionToString(option), option);
        }
      } else if (this.args.onSubmit) {
        this.args.onSubmit({ closeListbox: () => dd.actions.close(), value: this.args.value });
      }
      return;
    }

    if (key === 'Escape') {
      if (dd.isOpen) {
        dd.actions.close();
        this.selectionIndex = -1;
        this.tempValue = null;
      }
      return;
    }
  };

  private scrollToSelection(index: number, optionCount: number): void {
    if (index >= 0 && this.listboxEl) {
      const optionEl = this.optionEls.get(index);
      scrollItemIntoView(
        optionEl,
        this.listboxEl,
        index === 0,
        index === optionCount - 1,
      );
    }
  }

  handleOptionClick = (dd: { actions: { close: () => void } }, index: number): void => {
    if (this.disabled) return;
    const option = this.filteredOptions[index];
    if (option === undefined) return;
    dd.actions.close();
    this.selectionIndex = -1;
    this.tempValue = null;
    this.args.onChange(this.args.mapOptionToString(option), option);
  };

  <template>
    {{! template-lint-disable no-autofocus-attribute require-presentational-children }}
    <div
      class={{this.rootClassName}}
      data-basestrom="combobox"
      ...attributes
    >
      <BasicDropdown
        @renderInPlace={{false}}
        @matchTriggerWidth={{true}}
        @verticalPosition="below"
        @horizontalPosition="left"
        @disabled={{this.disabled}}
        as |dd|
      >
        <dd.Trigger
          role="combobox"
          aria-expanded={{if dd.isOpen "true" "false"}}
          aria-haspopup="listbox"
          aria-owns={{this.listboxId}}
          aria-controls={{if dd.isOpen this.listboxId}}
        >
          {{#if (has-block "startEnhancer")}}
            <Input
              @value={{this.displayValue}}
              @size={{this.size}}
              @clearable={{@clearable}}
              @disabled={{@disabled}}
              @error={{@error}}
              @positive={{@positive}}
              @id={{@id}}
              @name={{@name}}
              @role="combobox"
              @aria-autocomplete="list"
              @aria-activedescendant={{this.activeDescendantId}}
              @aria-controls={{if dd.isOpen this.listboxId}}
              @aria-haspopup="listbox"
              @onChange={{fn this.handleInputChange dd}}
              @onFocus={{this.handleFocus}}
              @onBlur={{this.handleBlur}}
              @onKeyDown={{fn this.handleKeyDown dd}}
            >
              <:startEnhancer>{{yield to="startEnhancer"}}</:startEnhancer>
            </Input>
          {{else}}
            <Input
              @value={{this.displayValue}}
              @size={{this.size}}
              @clearable={{@clearable}}
              @disabled={{@disabled}}
              @error={{@error}}
              @positive={{@positive}}
              @id={{@id}}
              @name={{@name}}
              @role="combobox"
              @aria-autocomplete="list"
              @aria-activedescendant={{this.activeDescendantId}}
              @aria-controls={{if dd.isOpen this.listboxId}}
              @aria-haspopup="listbox"
              @onChange={{fn this.handleInputChange dd}}
              @onFocus={{this.handleFocus}}
              @onBlur={{this.handleBlur}}
              @onKeyDown={{fn this.handleKeyDown dd}}
            />
          {{/if}}
        </dd.Trigger>

        <dd.Content>
          <ul
            role="listbox"
            id={{this.listboxId}}
            aria-label={{@listBoxLabel}}
            tabindex="-1"
            class={{this.listBoxClassName}}
            {{bstRef this.captureListbox}}
          >
            {{#each this.filteredOptions as |option index|}}
              <li
                role="option"
                id={{this.optionId index}}
                aria-selected={{if (this.isSelected index) "true" "false"}}
                class={{this.listItemClassName index}}
                {{on "click" (fn this.handleOptionClick dd index)}}
                {{bstRef (fn this.captureOption index)}}
              >
                {{! Custom option rendering - OptionNode provides visual content only }}
                {{#if @mapOptionToNode}}
                  {{#let @mapOptionToNode as |OptionNode|}}
                    <span role="presentation"><OptionNode @option={{option}} @isSelected={{this.isSelected index}} /></span>
                  {{/let}}
                {{else}}
                  {{this.optionString option}}
                {{/if}}
              </li>
            {{/each}}
          </ul>
        </dd.Content>
      </BasicDropdown>
    </div>
  </template>

  // ─── Template helpers ─────────────────────────────────────────────────────

  isSelected = (index: number): boolean => {
    return this.clampedSelectionIndex === index;
  };
}
