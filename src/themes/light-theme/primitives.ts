import defaultFoundationColors from './color-foundation-tokens';
import { fontTokens } from '../shared/typography';
import type { Primitives } from '../types';

const primitives: Primitives = {
  ...defaultFoundationColors,
  ...fontTokens,
};

export default primitives;
