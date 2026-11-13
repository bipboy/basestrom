import Service from "@ember/service";
import { tracked } from "@glimmer/tracking";
import * as stylex from "@stylexjs/stylex";
import { DarkTheme } from "../themes/dark-theme/dark-theme";
import { darkColorTheme } from "../themes/dark.stylex";
import { LightTheme } from "../themes/light-theme/light-theme";
import type { Theme } from "../themes/theme-type";

/**
 * ThemeService manages the active theme for basestrom components.
 *
 * It applies the StyleX theme class to the document root, which switches
 * all CSS custom properties defined via `stylex.defineVars` to the active theme's values.
 *
 * Usage in an Ember app:
 *
 * ```ts
 * import { service } from '@ember/service';
 * import type ThemeService from 'basestrom/services/theme';
 *
 * export default class MyComponent extends Component {
 *   @service('basestrom/theme') declare theme: ThemeService;
 * }
 * ```
 */
export default class ThemeService extends Service {
	@tracked currentTheme: Theme = LightTheme;

	/**
	 * The currently applied StyleX theme className on the root element.
	 * Tracked so components can react to theme changes.
	 */
	@tracked private _appliedClassName: string | null = null;

	get isDark(): boolean {
		return this.currentTheme.name === "dark-theme";
	}

	/**
	 * The current theme's data object - for programmatic access to token values.
	 */
	get theme(): Theme {
		return this.currentTheme;
	}

	setTheme(theme: Theme): void {
		this.currentTheme = theme;
		this.applyThemeToDOM();
	}

	useLightTheme(): void {
		this.setTheme(LightTheme);
	}

	useDarkTheme(): void {
		this.setTheme(DarkTheme);
	}

	/**
	 * Applies the StyleX theme class to the document root.
	 *
	 * Light theme = no extra class (it's the default in defineVars).
	 * Dark theme = apply the darkColorTheme class.
	 */
	private applyThemeToDOM(): void {
		if (typeof document === "undefined") return;

		const root = document.documentElement;

		// Remove previous theme class
		if (this._appliedClassName) {
			root.classList.remove(this._appliedClassName);
			this._appliedClassName = null;
		}

		// Apply new theme class (light theme needs no class - it's the default)
		if (this.currentTheme.name === "dark-theme") {
			const { className } = stylex.props(darkColorTheme);
			if (className) {
				root.classList.add(className);
				this._appliedClassName = className;
			}
		}
	}
}
