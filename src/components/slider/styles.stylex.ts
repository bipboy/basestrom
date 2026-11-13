/**
 * Slider styles - port from baseweb slider styled-components.
 *
 * Key mappings:
 * - sliderTrackFill → transparent (track bg is the gradient)
 * - sliderHandleFill → contentPrimary (#000000)
 * - sliderHandleFillDisabled → borderStateDisabled (#F3F3F3)
 * - sliderHandleInnerFill → contentPrimary (#000000)
 * - borderSelected → #000000 (active track fill)
 * - borderOpaque → #F3F3F3 (inactive track fill)
 * - borderStateDisabled → #F3F3F3 (disabled track)
 * - borderAccent → #276EF1 (focus ring)
 *
 * Visual structure:
 *   Root
 *   ├── Track (padding area, captures pointer events)
 *   │   └── InnerTrack (2px colored line, position:relative)
 *   │       ├── Mark[] (step indicators)
 *   │       └── Thumb (24px circle, position:absolute, centered on track)
 *   │           ├── ThumbValue (pill label, floats above)
 *   │           └── InnerThumb (vertical bar connecting label to thumb)
 *   └── TickBar (min/max labels)
 */
import * as stylex from "@stylexjs/stylex";
import { colors, radii, sizing, typography } from "../../themes/vars.stylex";

export const styles = stylex.create({
	// ─── Root ───────────────────────────────────────────────────────────────────
	root: {
		position: "relative",
		width: "100%",
		outline: "none",
		overflow: "visible",
	},

	// ─── Track (outer clickable area) ───────────────────────────────────────────
	// In baseweb: padding 16px all sides, display flex
	track: {
		paddingTop: sizing.scale600,
		paddingBottom: sizing.scale600,
		paddingRight: sizing.scale600,
		paddingLeft: sizing.scale600,
		display: "flex",
		cursor: "pointer",
		overflow: "visible",
	},
	trackDisabled: {
		cursor: "not-allowed",
	},
	trackDragging: {
		cursor: "grabbing",
	},

	// ─── InnerTrack (the 2px line) ──────────────────────────────────────────────
	// position:relative is needed as containing block for thumbs
	innerTrack: {
		borderTopLeftRadius: radii.radius100,
		borderTopRightRadius: radii.radius100,
		borderBottomLeftRadius: radii.radius100,
		borderBottomRightRadius: radii.radius100,
		height: "2px",
		width: "100%",
		alignSelf: "center",
		position: "relative",
		overflow: "visible",
	},
	innerTrackDisabled: {
		cursor: "not-allowed",
	},

	// ─── Thumb ──────────────────────────────────────────────────────────────────
	// 24x24 circle, absolutely positioned within InnerTrack.
	// Vertical and horizontal centering done via inline style:
	// `top: 50%; left: X%; transform: translate(-50%, -50%)`
	thumb: {
		height: "24px",
		width: "24px",
		borderTopLeftRadius: "24px",
		borderTopRightRadius: "24px",
		borderBottomLeftRadius: "24px",
		borderBottomRightRadius: "24px",
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		backgroundColor: colors.contentPrimary,
		outline: "none",
		boxShadow: "0 1px 4px rgba(0, 0, 0, 0.12)",
		position: "absolute",
		cursor: "grab",
		touchAction: "none",
		userSelect: "none",
	},
	thumbDisabled: {
		backgroundColor: colors.borderStateDisabled,
		cursor: "not-allowed",
	},
	thumbDragging: {
		cursor: "grabbing",
	},
	thumbFocusVisible: {
		boxShadow: `0 0 0 3px ${colors.borderAccent}`,
	},

	// ─── InnerThumb (the vertical bar connecting label to thumb) ─────────────────
	// position:absolute relative to Thumb.
	// top: -16px means it starts 16px above the thumb's top edge.
	// height: 20px means it extends 4px into the thumb (20 - 16 = 4px overlap).
	innerThumb: {
		position: "absolute",
		top: "-16px",
		width: "4px",
		height: "20px",
		backgroundColor: colors.contentPrimary,
	},
	innerThumbDisabled: {
		backgroundColor: colors.borderStateDisabled,
	},

	// ─── ThumbValue (the label bubble above thumb) ──────────────────────────────
	// position:absolute relative to Thumb.
	// top: -scale1400 (-56px) positions it well above the thumb.
	// The pill shape with large border-radius creates the bubble look.
	thumbValue: {
		position: "absolute",
		top: `-56px`,
		fontSize: "12px",
		fontWeight: "normal" as const,
		lineHeight: "20px",
		fontFamily: typography.primaryFontFamily,
		backgroundColor: colors.contentPrimary,
		color: colors.contentInversePrimary,
		paddingLeft: sizing.scale600,
		paddingRight: sizing.scale600,
		paddingTop: sizing.scale500,
		paddingBottom: sizing.scale500,
		borderBottomLeftRadius: "48px",
		borderBottomRightRadius: "48px",
		borderTopLeftRadius: "48px",
		borderTopRightRadius: "48px",
		whiteSpace: "nowrap",
	},
	thumbValueDisabled: {
		backgroundColor: colors.borderStateDisabled,
	},

	// ─── Mark (step indicators) ─────────────────────────────────────────────────
	mark: {
		width: "4px",
		height: "4px",
		backgroundColor: colors.backgroundPrimary,
		position: "absolute",
		top: "50%",
		transform: "translate(-50%, -50%)",
	},

	// ─── TickBar (min/max labels container) ─────────────────────────────────────
	tickBar: {
		display: "flex",
		justifyContent: "space-between",
		alignItems: "center",
		paddingRight: sizing.scale600,
		paddingLeft: sizing.scale600,
		paddingBottom: sizing.scale400,
	},

	// ─── Tick (min/max label text) ──────────────────────────────────────────────
	tick: {
		fontSize: "12px",
		fontWeight: "normal" as const,
		lineHeight: "20px",
		fontFamily: typography.primaryFontFamily,
		color: colors.contentPrimary,
	},
});
