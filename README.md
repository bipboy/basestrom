# basestrom

**Component library implementing the Base design language - Ember v2 addon with StyleX, Glimmer, and strict-mode `.gts` templates.**

A port of [Base Web](https://baseweb.design) (Uber's React design system) to Ember Octane. All components ship as Glimmer components written in TypeScript with Glint, and use StyleX for static, atomic CSS.

> **Strict mode only.** basestrom is designed for `.gts` template imports. Loose-mode `.hbs` resolver names are not part of the public API and not maintained.

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

> **`ember-modifier` is now a runtime dependency of basestrom** (it powers a small set of internal render modifiers). When you install via npm/pnpm normally it is pulled in for you. If you symlink the addon for local development (`file:` / `link:` / pnpm workspaces) and your app already depends on `ember-modifier`, see _Troubleshooting → Duplicate `ember-source`_ at the bottom of this document.

### ember-basic-dropdown setup

`ember-basic-dropdown` is installed automatically as a transitive dependency of basestrom - no separate install needed.

To allow portaled overlays (Popover, Combobox) to render, add a wormhole destination element to your app's root template:

```hbs
{{! app/templates/application.hbs (or root .gts) }}
<div id='ember-basic-dropdown-wormhole'></div>
```

**Stylesheets:** `ember-basic-dropdown` ships only minimal positioning CSS. Visual styling of overlay surfaces is handled entirely by basestrom's StyleX styles - no EBD stylesheet import is required.

**Default destination:** overlays render into the `#ember-basic-dropdown-wormhole` element by default. To portal into a different container, pass `@mountNode` (an `HTMLElement`) or `@destination` (a string id) to the overlay component.

> **Future `Select` component:** a full Select (single/multi with search, tags, and grouping) is **not** part of basestrom. It is planned as a separate package built on `ember-power-select`.

### Build configuration

basestrom uses StyleX for styles. Configure the StyleX Babel plugin **and** the StyleX bundler plugin (rolldown / rollup / vite-plugin) in your app's build. Both must use the same `themeFileExtension` as basestrom - without this, your app references different CSS variable names than the ones basestrom emits, and theme tokens appear unresolved at runtime.

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

basestrom defines theme tokens as CSS custom properties via `stylex.defineVars`. Import the vars entry point and the bundled CSS once in your app's entry file:

```ts
// app.ts or app.gts (your Ember app entry point)
import 'basestrom/themes/vars.stylex';
import 'basestrom/styles.css';
```

This injects `:root` CSS variables for colors, sizing, typography, radii, lighting, and animation, and registers the rules emitted by every basestrom component.

### Overlay components (Popover, Combobox)

`<Popover>` and `<Combobox>` are built on [`ember-basic-dropdown`](https://github.com/mkszepp/ember-basic-dropdown), which is pulled in automatically as a dependency of basestrom. Overlay content is portaled out of the component tree, so two one-time setup steps are required in the consuming app:

1. **Add the portal destination.** Add a wormhole element to your app's root markup (e.g. `index.html` `<body>` or the application template). Without it, overlay content has no mount point and will not render:

   ```html
   <!-- index.html (inside <body>) -->
   <div id="ember-basic-dropdown-wormhole"></div>
   ```

2. **Import the positioning stylesheet** once in your app entry. This provides `position: absolute` and the z-index for portaled content - without it the overlay renders unpositioned (it appears at the bottom of the page instead of anchored to its trigger):

   ```ts
   // app.ts or app.gts
   import 'ember-basic-dropdown/vendor/ember-basic-dropdown.css';
   ```

You can override the destination per-instance with `@mountNode` on `<Popover>`. The default destination id is `ember-basic-dropdown-wormhole`.


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
