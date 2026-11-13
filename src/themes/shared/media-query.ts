import breakpoints from './breakpoints';
import type { MediaQuery } from '../types';

function getMediaQuery(breakpoint: number): string {
  return `@media screen and (min-width: ${breakpoint}px)`;
}

const mediaQuery: MediaQuery = {
  small: getMediaQuery(breakpoints.small),
  medium: getMediaQuery(breakpoints.medium),
  large: getMediaQuery(breakpoints.large),
};

export default mediaQuery;
