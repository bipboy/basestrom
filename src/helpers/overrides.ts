/**
 * Override system for basestrom components.
 *
 * Each component defines its subcomponent keys (e.g., 'root', 'content', 'spinner').
 * Consumers pass an overrides object mapping those keys to StyleX style arrays.
 * The component merges base styles with override styles via stylex.props().
 *
 * Example usage in a component:
 *
 * ```ts
 * import { resolveOverride } from 'basestrom/helpers/overrides';
 * import * as stylex from '@stylexjs/stylex';
 *
 * const styles = stylex.create({
 *   root: { display: 'flex' },
 *   content: { padding: '8px' },
 * });
 *
 * // In template:
 * // <div {{stylex (resolveOverride styles.root @overrides "root")}}>
 * ```
 *
 * Example usage by a consumer:
 *
 * ```ts
 * import * as stylex from '@stylexjs/stylex';
 *
 * const buttonOverrides = stylex.create({
 *   root: { backgroundColor: 'red' },
 *   content: { fontWeight: 'bold' },
 * });
 *
 * // <Bst::Button @overrides={{buttonOverrides}} />
 * ```
 */
import type { StyleXStyles } from "@stylexjs/stylex";

/**
 * A single override entry - a StyleX style or array of styles.
 * Matches what stylex.create() returns for each key.
 */
export type StyleOverride =
	| StyleXStyles
	| ReadonlyArray<StyleXStyles | false | null | undefined>;

/**
 * An overrides map: keys are subcomponent names, values are StyleX styles.
 * Generic parameter K constrains which keys are valid for a given component.
 */
export type Overrides<K extends string = string> = {
	readonly [key in K]?: StyleOverride;
};

/**
 * Resolve the final style array for a subcomponent.
 *
 * Returns an array suitable for spreading into stylex.props():
 * - Always includes the base style
 * - Appends the override style if present
 *
 * @param base - The component's default StyleX style for this subcomponent
 * @param overrides - The overrides object passed by the consumer (may be undefined)
 * @param key - The subcomponent key to look up in overrides
 * @returns Array of StyleX styles to pass to stylex.props()
 */
export function resolveOverride<K extends string>(
	base: StyleXStyles,
	overrides: Overrides<K> | undefined | null,
	key: K,
): ReadonlyArray<StyleXStyles | false | null | undefined> {
	const override = overrides?.[key];
	if (!override) {
		return [base];
	}
	if (Array.isArray(override)) {
		return [base, ...override];
	}
	return [base, override];
}

/**
 * Merge two override objects together.
 *
 * Use this when a wrapper component wants to apply its own overrides
 * but still allow the consumer to override further.
 *
 * The consumer's overrides take precedence (applied last in the style array).
 *
 * @param target - The wrapper's overrides (applied first, lower priority)
 * @param source - The consumer's overrides (applied last, higher priority)
 * @returns A merged overrides object
 *
 * @example
 * ```ts
 * // A "Card" component that wraps Block with some default overrides
 * // but allows the consumer to override further:
 *
 * const cardDefaults = stylex.create({
 *   root: { borderRadius: '8px', boxShadow: '0 2px 8px rgba(0,0,0,0.1)' },
 * });
 *
 * // In Card component:
 * const merged = mergeOverrides(cardDefaults, @overrides);
 * // Pass `merged` to the inner Block component
 * ```
 */
export function mergeOverrides<K extends string>(
	target: Overrides<K> | undefined | null,
	source: Overrides<K> | undefined | null,
): Overrides<K> {
	if (!target && !source) return {};
	if (!target) return source ?? {};
	if (!source) return target ?? {};

	const allKeys = new Set([
		...(Object.keys(target) as K[]),
		...(Object.keys(source) as K[]),
	]);

	const merged = {} as Record<K, StyleOverride>;

	for (const key of allKeys) {
		const targetStyle = target[key];
		const sourceStyle = source[key];

		if (!targetStyle && !sourceStyle) continue;
		if (!targetStyle) {
			merged[key] = sourceStyle!;
			continue;
		}
		if (!sourceStyle) {
			merged[key] = targetStyle;
			continue;
		}

		// Both exist - combine into an array (target first, source wins)
		const targetArr = Array.isArray(targetStyle) ? targetStyle : [targetStyle];
		const sourceArr = Array.isArray(sourceStyle) ? sourceStyle : [sourceStyle];
		merged[key] = [...targetArr, ...sourceArr];
	}

	return merged;
}
