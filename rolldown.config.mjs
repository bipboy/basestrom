import { Addon } from "@embroider/addon-dev/rollup";
import { babel } from "@rollup/plugin-babel";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";

const addon = new Addon({
  srcDir: "src",
  destDir: "dist",
});

const rootDirectory = dirname(fileURLToPath(import.meta.url));
const babelConfig = resolve(rootDirectory, "./babel.publish.config.cjs");
const tsConfig = resolve(rootDirectory, "./tsconfig.publish.json");

export default {
  output: {
    ...addon.output(),
    preserveModules: true,
  },

  plugins: [
    addon.publicEntrypoints(["**/*.js", "index.js", "template-registry.js"]),
    addon.appReexports([
      "components/**/*.js",
      "helpers/**/*.js",
      "modifiers/**/*.js",
      "services/**/*.js",
    ]),
    addon.dependencies(),
    addon.gjs(),
    babel({
      extensions: [".js", ".gjs", ".ts", ".gts"],
      babelHelpers: "bundled",
      configFile: babelConfig,
    }),
    addon.declarations(
      "declarations",
      `npx ember-tsc --declaration --project ${tsConfig}`,
    ),

    addon.keepAssets(["**/*.css"]),
    addon.clean(),
  ],
};
