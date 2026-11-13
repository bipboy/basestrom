/**
 * Select component - re-exports Base and Field.
 *
 * - `SelectBase` - bare native <select> with styling (use standalone or in custom layouts)
 * - `SelectField` - SelectBase + FormControl (label, caption, error)
 *
 * @module basestrom/components/select
 */
export { default as SelectBase } from './base.gts';
export { default as SelectField } from './field.gts';
export { SIZE, type SelectBaseSignature, type SelectFieldSignature, type SelectOverrides, type SelectSize } from './types';

