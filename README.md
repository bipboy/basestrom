# basestrom

![Experimental](https://img.shields.io/badge/STATUS-EXPERIMENTAL_%2F_NOT_ACTIVELY_MAINTAINED-red?style=for-the-badge)

**Component library implementing the Base design language - Ember v2 addon with StyleX, Glimmer, and strict-mode `.gts` templates.**

This repository is a prototype and is not actively maintained. Use at your own risk.
Port of [Base Web](https://baseweb.design) to Ember (v2 addon). Built with Glimmer components, TypeScript (Glint), and StyleX.
Strict mode only: Designed exclusively for `.gts` template imports. Loose-mode `.hbs` resolution is unsupported.

---

## Installation

```bash
npm install basestrom
# or
pnpm add basestrom
```

### Peer dependencies

```bash
npm install @stylexjs/stylex @glimmer/component @glimmer/tracking ember-modifier
```

### ember-basic-dropdown setup

`ember-basic-dropdown` is installed automatically as a transitive dependency of basestrom - no separate install needed.

To allow portaled overlays (Popover, Combobox) to render, add a wormhole destination element to your app's root template:

```hbs
{{! app/templates/application.hbs (or root .gts) }}
<div id='ember-basic-dropdown-wormhole'></div>
```

### Build configuration

```js
// babel.config.cjs (or equivalent)
module.exports = {
  plugins: [
    [
      '@stylexjs/babel-plugin',
      {
        dev: process.env.NODE_ENV !== 'production',
        runtimeInjection: process.env.NODE_ENV !== 'production',
        unstable_moduleResolution: {
          type: 'commonJS',
          rootDir: __dirname,
          // MUST match basestrom - generates stable CSS variable names
          // for *.stylex.{ts,js} files across packages.
          themeFileExtension: '.stylex',
        },
      },
    ],
  ],
};
```

For production bundling, mirror the same option in the StyleX bundler plugin:

```js
import stylex from '@stylexjs/unplugin';

stylex.rollup({
  useCSSLayers: true,
  dev: false,
  unstable_moduleResolution: {
    type: 'commonJS',
    rootDir: __dirname,
    themeFileExtension: '.stylex',
  },
});
```

### Global styles (CSS variables)

```ts
// app.ts or app.gts (your Ember app entry point)
import 'basestrom/themes/vars.stylex';
import 'basestrom/styles.css';
```

## Development

```bash
# Install dependencies
pnpm install

# Start playground (Vite dev server)
npm start

# Type-check
pnpm run lint:types

# Lint everything
pnpm run lint

# Build addon
npm run build

# Run tests
npm run test
```

The `playground/` directory is a live demo app with a route per component.
