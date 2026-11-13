/**
 * Modal styles - port from baseweb modal styled-components.
 *
 * Architecture (matches baseweb):
 * - Root: fixed full-viewport overlay container (handles scroll)
 * - DialogContainer: centers the dialog with backdrop (rgba black)
 * - Dialog: the actual modal panel (white rounded card)
 * - Close: absolute top-right close button
 * - ModalHeader / ModalBody / ModalFooter: layout slots
 *
 * Sizes:
 * - default: 500px width
 * - full: 100% (alignSelf: stretch)
 * - auto: width by content
 *
 * Animation: fade in/out for container; fade + translateY for dialog.
 */
import * as stylex from "@stylexjs/stylex";
import {
	animation,
	colors,
	radii,
	sizing,
	typography,
} from "../../themes/vars.stylex";

// --- Keyframes --------------------------------------------------------------

const containerFadeIn = stylex.keyframes({
	from: { opacity: 0 },
	to: { opacity: 1 },
});

const dialogSlideIn = stylex.keyframes({
	from: { opacity: 0, transform: "translateY(20px)" },
	to: { opacity: 1, transform: "translateY(0)" },
});

// --- Styles -----------------------------------------------------------------

export const styles = stylex.create({
	// --- Root: full-viewport fixed container ---------------------------------
	root: {
		position: "fixed",
		top: 0,
		right: 0,
		bottom: 0,
		left: 0,
		overflowX: "auto",
		overflowY: "auto",
		zIndex: 1000,
	},
	rootClosed: {
		pointerEvents: "none",
	},

	// --- DialogContainer: backdrop + centering -------------------------------
	dialogContainer: {
		display: "flex",
		alignItems: "center",
		justifyContent: "center",
		width: "100%",
		minHeight: "100%",
		userSelect: "none",
		pointerEvents: "auto",
		backgroundColor: colors.backgroundOverlay,
		WebkitTapHighlightColor: "transparent",
	},
	dialogContainerAnimated: {
		animationName: containerFadeIn,
		animationDuration: animation.timing400,
		animationTimingFunction: animation.easeOutCurve,
		animationFillMode: "forwards",
	},

	// --- Dialog: the modal panel --------------------------------------------
	dialog: {
		position: "relative",
		backgroundColor: colors.backgroundPrimary,
		borderTopLeftRadius: radii.radius500,
		borderTopRightRadius: radii.radius500,
		borderBottomRightRadius: radii.radius500,
		borderBottomLeftRadius: radii.radius500,
		marginTop: sizing.scale600,
		marginRight: sizing.scale600,
		marginBottom: sizing.scale600,
		marginLeft: sizing.scale600,
		maxWidth: "100%",
		userSelect: "text",
		outlineStyle: "none",
		outlineWidth: 0,
	},
	dialogAnimated: {
		animationName: dialogSlideIn,
		animationDuration: animation.timing400,
		animationTimingFunction: animation.easeOutCurve,
		animationFillMode: "forwards",
	},

	// --- Sizes (width) -------------------------------------------------------
	sizeDefault: {
		width: "500px",
	},
	sizeFull: {
		width: "100%",
		alignSelf: "stretch",
	},
	sizeAuto: {
		width: "auto",
	},

	// --- Close button --------------------------------------------------------
	close: {
		position: "absolute",
		top: sizing.scale500,
		right: sizing.scale500,
		width: sizing.scale800,
		height: sizing.scale800,
		display: "flex",
		justifyContent: "center",
		alignItems: "center",
		cursor: "pointer",

		// Reset button styles
		backgroundColor: "transparent",
		paddingTop: 0,
		paddingRight: 0,
		paddingBottom: 0,
		paddingLeft: 0,

		// Border (transparent so focus-visible can highlight)
		borderTopWidth: "1px",
		borderRightWidth: "1px",
		borderBottomWidth: "1px",
		borderLeftWidth: "1px",
		borderTopStyle: "solid",
		borderRightStyle: "solid",
		borderBottomStyle: "solid",
		borderLeftStyle: "solid",
		borderTopColor: "transparent",
		borderRightColor: "transparent",
		borderBottomColor: "transparent",
		borderLeftColor: "transparent",

		color: colors.contentTertiary,
		transitionProperty: "color, border-color",
		transitionDuration: animation.timing200,
		transitionTimingFunction: animation.easeOutCurve,

		outlineStyle: "none",
		outlineWidth: 0,
	},
	closeHover: {
		color: {
			default: colors.contentTertiary,
			":hover": colors.contentPrimary,
		},
	},
	closeFocusVisible: {
		outlineStyle: "solid",
		outlineWidth: "3px",
		outlineColor: colors.borderAccent,
	},

	// --- Header --------------------------------------------------------------
	header: {
		fontFamily: typography.primaryFontFamily,
		// font550: 20/28/500
		fontSize: "20px",
		fontWeight: 500,
		lineHeight: "28px",
		color: colors.contentPrimary,
		marginTop: sizing.scale900,
		marginLeft: sizing.scale800,
		// Slightly more right margin to leave room for close button
		marginRight: sizing.scale900,
		marginBottom: sizing.scale600,
	},

	// --- Body ---------------------------------------------------------------
	body: {
		fontFamily: typography.primaryFontFamily,
		// font200: 14/20/normal
		fontSize: "14px",
		fontWeight: "normal",
		lineHeight: "20px",
		color: colors.contentSecondary,
		marginTop: sizing.scale600,
		marginLeft: sizing.scale800,
		marginRight: sizing.scale800,
		marginBottom: sizing.scale700,
	},

	// --- Footer -------------------------------------------------------------
	footer: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: "normal",
		lineHeight: "20px",
		marginTop: sizing.scale700,
		marginLeft: sizing.scale800,
		marginRight: sizing.scale800,
		paddingTop: sizing.scale500,
		paddingBottom: sizing.scale500,
		textAlign: "right",
	},
});
