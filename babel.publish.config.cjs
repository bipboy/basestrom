/**
 * This babel.config is only used for publishing.
 *
 * For local dev experience, see the babel.config
 *
 * NOTE: StyleX transformation is handled by @stylexjs/unplugin in rolldown.config.mjs,
 * not here. This config only handles TypeScript and Ember template compilation.
 */
module.exports = {
	plugins: [
		[
			"@babel/plugin-transform-typescript",
			{
				allExtensions: true,
				allowDeclareFields: true,
				onlyRemoveTypeImports: true,
			},
		],
		[
			"babel-plugin-ember-template-compilation",
			{
				targetFormat: "hbs",
				transforms: [],
			},
		],
		[
			"module:decorator-transforms",
			{
				runtime: {
					import: "decorator-transforms/runtime-esm",
				},
			},
		],
	],

	generatorOpts: {
		compact: false,
	},
};
