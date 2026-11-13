/**
 * ButtonTimed styles - exact port from baseweb button-timed.
 *
 * The progress bar is a ::after pseudo-element with a CSS animation.
 * The animation uses CSS custom properties set via inline style:
 * - --bst-timer-duration: the FULL initialTime (set once, never changes)
 * - --bst-timer-delay: negative offset representing elapsed time (set once at mount)
 *
 * The animation runs for the full initialTime duration with a simple
 * from (full bar) to (empty bar) sweep. A negative animation-delay
 * offsets the start position so the bar begins at the correct point
 * if the component mounts mid-countdown (e.g. after pause/resume).
 *
 * IMPORTANT: The inline style must NOT change on every tick. Only the
 * countdown text updates every 100ms. The CSS animation properties are
 * static after initial render, which prevents the browser from restarting
 * the animation on each re-render (an Ember-specific issue where changing
 * the style attribute string causes animation restart).
 */
import * as stylex from "@stylexjs/stylex";
import { colors } from "../../themes/vars.stylex";

/**
 * Keyframes: sweeps from full bar to empty.
 * Simple linear sweep - no CSS custom properties needed in keyframes.
 */
const timerSweep = stylex.keyframes({
	from: {
		transform: "translateX(0%) scaleX(100%)",
	},
	to: {
		transform: "translateX(100%) scaleX(0%)",
	},
});

export const styles = stylex.create({
	root: {
		position: "relative",
		overflow: "hidden",
	},

	timerOverlay: {
		"::after": {
			content: '""',
			display: "inline-block",
			width: "100%",
			height: "100%",
			zIndex: 1,
			position: "absolute",
			top: 0,
			left: 0,
			backgroundColor: `color-mix(in srgb, ${colors.backgroundPrimary} 20%, transparent)`,
			transformOrigin: "left",
			animationName: timerSweep,
			animationTimingFunction: "linear",
			animationFillMode: "forwards",
			animationDuration: "var(--bst-timer-duration, 0s)",
			animationDelay: "var(--bst-timer-delay, 0s)",
		},
	},

	timerPaused: {
		"::after": {
			animationPlayState: "paused",
		},
	},

	timerRunning: {
		"::after": {
			animationPlayState: "running",
		},
	},

	timerContainer: {
		minWidth: "53px",
		display: "inline-block",
	},
});
