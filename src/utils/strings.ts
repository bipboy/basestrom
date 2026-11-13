/**
 * String utilities.
 */

/** Convert camelCase to kebab-case */
export function camelToKebab(s: string): string {
	return s.replace(/([a-z0-9])([A-Z])/g, "$1-$2").toLowerCase();
}
