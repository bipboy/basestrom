/** @type {import("prettier").Config} */
export default {
	singleQuote: true,
	trailingComma: "es5",
	printWidth: 100,
	overrides: [
		{
			files: "*.{gts,gjs}",
			options: {
				parser: "ember-template-tag",
			},
		},
	],
};
