/**
 * Deep merge utility.
 * Recursively merges source objects into target.
 * Arrays and plain objects are cloned, primitives are overwritten.
 */
export default function deepMerge<T extends object>(
	target?: T | null,
	...sources: Array<Partial<T> | null | undefined>
): T {
	const result = (target || {}) as Record<string, unknown>;
	for (const source of sources) {
		if (!source) continue;
		for (const key of Object.keys(source)) {
			const value = (source as Record<string, unknown>)[key];
			if (isCloneable(value)) {
				result[key] = deepMerge(
					(result[key] as object) || (Array.isArray(value) ? [] : {}),
					value as object,
				);
			} else {
				result[key] = value;
			}
		}
	}
	return result as T;
}

function isCloneable(obj: unknown): obj is object {
	return (
		Array.isArray(obj) ||
		Object.prototype.toString.call(obj) === "[object Object]"
	);
}
