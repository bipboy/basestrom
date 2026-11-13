export default {
	extends: "recommended",
	overrides: [
		{
			files: ["playground/**/*.gts", "playground/**/*.hbs"],
			rules: {
				// Playground demos use inline styles for layout convenience.
				"no-inline-styles": "off",
				"no-unused-block-params": "off",
				"no-yield-to-default": "off",
				"no-positive-tabindex": "off",
				"no-invalid-interactive": "off",
				"no-autofocus-attribute": "off",
				"no-whitespace-for-layout": "off",
			},
		},
	],
};
