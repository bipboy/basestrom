import type { Overrides } from '../../helpers/overrides';

export type PaginationOverrideKeys = 'root' | 'prevButton' | 'nextButton' | 'maxLabel' | 'dropdownContainer' | 'select';
export type PaginationOverrides = Overrides<PaginationOverrideKeys>;

export interface PaginationSignature {
  Args: {
    /** Total number of pages. */
    numPages: number;
    /** Current active page (1-indexed). */
    currentPage: number;
    /** Called when page changes via select or prev/next buttons. */
    onPageChange?: (params: { nextPage: number; prevPage: number }) => void;
    /** Called when prev button is clicked. */
    onPrevClick?: (params: { event: Event }) => void;
    /** Called when next button is clicked. */
    onNextClick?: (params: { event: Event }) => void;
    /** Custom label strings. */
    labels?: { prevButton?: string; nextButton?: string; preposition?: string };
    /** Button size. */
    size?: 'xSmall' | 'small' | 'medium' | 'large';
    /** StyleX overrides. */
    overrides?: PaginationOverrides;
  };
  Element: HTMLDivElement;
}

export const STATE_CHANGE_TYPE = {
  changePage: 'changePage',
} as const;

export type StateReducerFn = (
  changeType: keyof typeof STATE_CHANGE_TYPE,
  nextState: { currentPage: number },
  currentState: { currentPage: number },
) => { currentPage: number };

export interface StatefulPaginationSignature {
  Args: {
    /** Total number of pages. */
    numPages: number;
    /** Initial page (defaults to 1). */
    initialPage?: number;
    /** Called when page changes. */
    onPageChange?: (params: { nextPage: number; prevPage: number }) => void;
    /** Called when prev button is clicked. */
    onPrevClick?: (params: { event: Event }) => void;
    /** Called when next button is clicked. */
    onNextClick?: (params: { event: Event }) => void;
    /** Reducer function to intercept/override state changes. */
    stateReducer?: StateReducerFn;
    /** Custom label strings. */
    labels?: { prevButton?: string; nextButton?: string; preposition?: string };
    /** Button size. */
    size?: 'xSmall' | 'small' | 'medium' | 'large';
    /** StyleX overrides. */
    overrides?: PaginationOverrides;
  };
  Element: HTMLDivElement;
}
