/**
 * ButtonGroup styles - complete port from baseweb button-group styled-components.
 *
 * Provides flex layout with gap-based spacing, optional wrapping,
 * and configurable horizontal padding.
 */
import * as stylex from "@stylexjs/stylex";
import { sizing } from "../../themes/vars.stylex";

export const styles = stylex.create({
	/**
	 * Root container - flex row with column gap.
	 * Row gap varies by size (xSmall/mini use scale500, others use scale300).
	 */
	root: {
		display: "flex",
		columnGap: sizing.scale300,
		rowGap: sizing.scale300,
	},

	/** Row gap override for xSmall size buttons. */
	rowGapXSmall: {
		rowGap: sizing.scale500,
	},

	// --- Wrap styles ---

	/** Allow buttons to wrap to next line. */
	wrap: {
		flexWrap: "wrap",
	},

	/** Prevent wrapping; overflow scrolls horizontally with hidden scrollbar. */
	noWrap: {
		overflowX: "auto",
		scrollbarWidth: "none",
	},

	// --- Padding styles ---

	/** Default padding: 16px horizontal. */
	paddingDefault: {
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
	},

	/** No padding. */
	paddingNone: {
		paddingLeft: 0,
		paddingRight: 0,
	},

	/** Stretch group to full width; children use flex: 1. */
	fullWidth: {
		width: "100%",
	},
});
