/**
 * Pagination component - port from baseweb pagination.
 *
 * Provides prev/next navigation and a page dropdown.
 * Layout: [Prev button] [select dropdown] [of N label] [Next button]
 *
 * Usage:
 * ```hbs
 * <BstPagination
 *   @numPages={{10}}
 *   @currentPage={{this.page}}
 *   @onPageChange={{this.handlePageChange}}
 * />
 * ```
 */
import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import * as stylex from '@stylexjs/stylex';
import { resolveOverride, type Overrides } from '../../helpers/overrides';
import Button from '../button/index.gts';
import { ChevronLeft, ChevronRight } from '../icon/glyphs.gts';
import SelectBase from '../select/base.gts';
import { styles } from './styles.stylex';
import {
  STATE_CHANGE_TYPE,
  type PaginationOverrides,
  type PaginationSignature,
  type StateReducerFn,
  type StatefulPaginationSignature,
} from './types';

// Re-export types and constants
export {
  STATE_CHANGE_TYPE,
  type PaginationOverrides,
  type PaginationSignature,
  type StateReducerFn,
  type StatefulPaginationSignature
};

// ─── Helpers ────────────────────────────────────────────────────────────────────

function eq(a: unknown, b: unknown): boolean {
  return a === b;
}

// ─── Component ──────────────────────────────────────────────────────────────────

export default class Pagination extends Component<PaginationSignature> {
  // ─── Resolved props ─────────────────────────────────────────────────────────

  get size() {
    return this.args.size ?? 'medium';
  }

  get prevLabel(): string {
    return this.args.labels?.prevButton ?? 'Prev';
  }

  get nextLabel(): string {
    return this.args.labels?.nextButton ?? 'Next';
  }

  get prepositionLabel(): string {
    return this.args.labels?.preposition ?? 'of';
  }

  get isPrevDisabled(): boolean {
    return this.args.currentPage <= 1;
  }

  get isNextDisabled(): boolean {
    return this.args.currentPage >= this.args.numPages;
  }

  get pageOptions(): number[] {
    const n = this.args.numPages;
    if (n <= 0) return [];
    return Array.from({ length: n }, (_, i) => i + 1);
  }

  // ─── Aria labels ────────────────────────────────────────────────────────────

  get prevAriaLabel(): string {
    return `previous page. current page ${this.args.currentPage} of ${this.args.numPages}`;
  }

  get nextAriaLabel(): string {
    return `next page. current page ${this.args.currentPage} of ${this.args.numPages}`;
  }

  get selectAriaLabel(): string {
    return `page ${this.args.currentPage} of ${this.args.numPages}`;
  }

  // ─── Event handlers ─────────────────────────────────────────────────────────

  handlePrev = (event: Event): void => {
    if (this.isPrevDisabled) return;
    const prevPage = this.args.currentPage;
    const nextPage = prevPage - 1;
    this.args.onPrevClick?.({ event });
    this.args.onPageChange?.({ nextPage, prevPage });
  };

  handleNext = (event: Event): void => {
    if (this.isNextDisabled) return;
    const prevPage = this.args.currentPage;
    const nextPage = prevPage + 1;
    this.args.onNextClick?.({ event });
    this.args.onPageChange?.({ nextPage, prevPage });
  };

  handleSelectChange = (event: Event): void => {
    const select = event.target as HTMLSelectElement;
    const nextPage = parseInt(select.value, 10);
    const prevPage = this.args.currentPage;
    if (nextPage !== prevPage) {
      this.args.onPageChange?.({ nextPage, prevPage });
    }
  };

  // ─── Styles ─────────────────────────────────────────────────────────────────

  get rootClassName(): string | undefined {
    const resolved = resolveOverride(styles.root, this.args.overrides, 'root');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get maxLabelClassName(): string | undefined {
    const resolved = resolveOverride(styles.maxLabel, this.args.overrides, 'maxLabel');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get dropdownContainerClassName(): string | undefined {
    const resolved = resolveOverride(styles.dropdownContainer, this.args.overrides, 'dropdownContainer');
    const { className } = stylex.props(...resolved);
    return className || undefined;
  }

  get prevButtonOverrides(): Overrides<string> | undefined {
    const override = this.args.overrides?.prevButton;
    if (!override) return undefined;
    return { root: override };
  }

  get nextButtonOverrides(): Overrides<string> | undefined {
    const override = this.args.overrides?.nextButton;
    if (!override) return undefined;
    return { root: override };
  }

  <template>
    {{! template-lint-disable no-invalid-interactive }}
    <div
      class={{this.rootClassName}}
      data-basestrom="pagination"
      role="navigation"
      aria-label="pagination"
      ...attributes
    >
      <Button
        @kind="tertiary"
        @size={{this.size}}
        @disabled={{this.isPrevDisabled}}
        @overrides={{this.prevButtonOverrides}}
        aria-label={{this.prevAriaLabel}}
        {{on "click" this.handlePrev}}
      >
        <:startEnhancer>
          <ChevronLeft @size="24" />
        </:startEnhancer>
        <:default>{{this.prevLabel}}</:default>
      </Button>

      <span class={{this.dropdownContainerClassName}}>
        <SelectBase
          @size="compact"
          aria-label={{this.selectAriaLabel}}
          {{on "change" this.handleSelectChange}}
        >
          {{#each this.pageOptions as |page|}}
            <option value={{page}} selected={{eq page @currentPage}}>{{page}}</option>
          {{/each}}
        </SelectBase>
      </span>

      <span class={{this.maxLabelClassName}} aria-hidden="true">
        {{this.prepositionLabel}} {{@numPages}}
      </span>

      <Button
        @kind="tertiary"
        @size={{this.size}}
        @disabled={{this.isNextDisabled}}
        @overrides={{this.nextButtonOverrides}}
        aria-label={{this.nextAriaLabel}}
        {{on "click" this.handleNext}}
      >
        <:default>{{this.nextLabel}}</:default>
        <:endEnhancer>
          <ChevronRight @size="24" />
        </:endEnhancer>
      </Button>
    </div>
  </template>
}

// ─── Stateful Pagination ────────────────────────────────────────────────────────

function defaultStateReducer(
  _type: keyof typeof STATE_CHANGE_TYPE,
  nextState: { currentPage: number },
  _currentState: { currentPage: number },
): { currentPage: number } {
  return nextState;
}

export class StatefulPagination extends Component<StatefulPaginationSignature> {
  @tracked currentPage: number;

  constructor(owner: any, args: StatefulPaginationSignature['Args']) {
    super(owner, args);
    this.currentPage = args.initialPage ?? 1;
  }

  get stateReducer(): StateReducerFn {
    return this.args.stateReducer ?? defaultStateReducer;
  }

  handlePageChange = (params: { nextPage: number; prevPage: number }): void => {
    const clamped = Math.max(1, Math.min(params.nextPage, this.args.numPages));
    const reduced = this.stateReducer(
      STATE_CHANGE_TYPE.changePage,
      { currentPage: clamped },
      { currentPage: this.currentPage },
    );
    this.currentPage = reduced.currentPage;
    this.args.onPageChange?.(params);
  };

  <template>
    <Pagination
      @numPages={{@numPages}}
      @currentPage={{this.currentPage}}
      @onPageChange={{this.handlePageChange}}
      @onPrevClick={{@onPrevClick}}
      @onNextClick={{@onNextClick}}
      @labels={{@labels}}
      @size={{@size}}
      @overrides={{@overrides}}
      ...attributes
    />
  </template>
}
