import type { Borders } from '../types';
import sharedBorders from '../shared/borders';

/**
 * Dark theme border overrides.
 * Border colors are inverted for dark backgrounds.
 */
const borders: Borders = {
  ...sharedBorders,
  border100: {
    borderColor: 'hsla(0, 0%, 100%, 0.04)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
  border200: {
    borderColor: 'hsla(0, 0%, 100%, 0.08)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
  border300: {
    borderColor: 'hsla(0, 0%, 100%, 0.12)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
  border400: {
    borderColor: 'hsla(0, 0%, 100%, 0.16)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
  border500: {
    borderColor: 'hsla(0, 0%, 100%, 0.2)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
  border600: {
    borderColor: 'hsla(0, 0%, 100%, 0.24)',
    borderStyle: 'solid',
    borderWidth: '1px',
  },
};

export default borders;
