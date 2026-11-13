/**
 * Responsive helpers.
 * Utilities for working with breakpoints and media queries.
 */
import type { Breakpoints } from "../themes/types";

/**
 * Generate a media query string from a breakpoint value.
 * @example getMediaQuery(600) => '@media screen and (min-width: 600px)'
 */
export function getMediaQuery(breakpoint: number): string {
	return `@media screen and (min-width: ${breakpoint}px)`;
}

/**
 * Generate an array of media query strings from a breakpoints object,
 * sorted by breakpoint value ascending.
 */
export function getMediaQueries(breakpoints: Breakpoints): string[] {
	return Object.values(breakpoints)
		.sort((a, b) => a - b)
		.map(getMediaQuery);
}
