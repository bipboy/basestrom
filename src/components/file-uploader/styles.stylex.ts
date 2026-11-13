/**
 * FileUploader styles - port from baseweb file-uploader-basic.
 *
 * Minor naming differences from baseweb:
 * - baseweb has component-level theme tokens
 *   (`fileUploaderBorderColorDefault`, `fileUploaderBackgroundColor`,
 *   `fileUploaderMessageColor`) that we don't expose. We map them to
 *   the closest semantic foundation tokens:
 *     fileUploaderBorderColorDefault -> contentTertiary (visible dash)
 *     fileUploaderBackgroundColor    -> backgroundSecondary
 *     fileUploaderMessageColor       -> contentSecondary
 */
import * as stylex from "@stylexjs/stylex";
import { colors, radii, sizing, typography } from "../../themes/vars.stylex";

// --- Root --------------------------------------------------------------------

export const rootStyles = stylex.create({
	base: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		lineHeight: "20px",
		color: colors.contentSecondary,
	},
});

// --- Drop zone --------------------------------------------------------------

export const dropzoneStyles = stylex.create({
	base: {
		alignItems: "center",
		backgroundColor: colors.backgroundSecondary,
		borderTopWidth: sizing.scale0,
		borderRightWidth: sizing.scale0,
		borderBottomWidth: sizing.scale0,
		borderLeftWidth: sizing.scale0,
		borderTopStyle: "dashed",
		borderRightStyle: "dashed",
		borderBottomStyle: "dashed",
		borderLeftStyle: "dashed",
		borderTopColor: colors.contentTertiary,
		borderRightColor: colors.contentTertiary,
		borderBottomColor: colors.contentTertiary,
		borderLeftColor: colors.contentTertiary,
		borderRadius: radii.radius400,
		boxSizing: "border-box",
		display: "flex",
		flexDirection: "column",
		outlineStyle: "none",
		outlineWidth: 0,
		paddingTop: sizing.scale900,
		paddingRight: sizing.scale800,
		paddingBottom: sizing.scale900,
		paddingLeft: sizing.scale800,
		width: "100%",
	},
	afterFileDrop: {
		// baseweb sets borderStyle:'none' and a smaller bottom padding
		// after a file has been dropped to leave room for action buttons.
		borderTopStyle: "none",
		borderRightStyle: "none",
		borderBottomStyle: "none",
		borderLeftStyle: "none",
		paddingBottom: sizing.scale300,
	},
	dragActive: {
		borderTopColor: colors.borderAccent,
		borderRightColor: colors.borderAccent,
		borderBottomColor: colors.borderAccent,
		borderLeftColor: colors.borderAccent,
		backgroundColor: colors.backgroundAccentLight,
	},
	disabled: {
		opacity: 0.5,
		cursor: "not-allowed",
	},
});

// --- Content message --------------------------------------------------------

export const contentMessageStyles = stylex.create({
	// LabelSmall - 14/16/500
	base: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "14px",
		fontWeight: 500,
		lineHeight: "16px",
		// In idle state baseweb leaves color unset so it inherits from Root
		// (contentSecondary). We mirror that with `inherit`.
		color: "inherit",
	},
	// LabelMedium - 16/20/500 in afterFileDrop state, with vertical margins.
	afterFileDrop: {
		fontSize: "16px",
		lineHeight: "20px",
		color: colors.contentPrimary,
		marginTop: sizing.scale100,
		marginBottom: sizing.scale100,
	},
	dragActive: {
		color: colors.contentAccent,
	},
});

// --- Error message ----------------------------------------------------------

export const errorMessageStyles = stylex.create({
	// LabelMedium - 16/20/500
	base: {
		fontFamily: typography.primaryFontFamily,
		fontSize: "16px",
		fontWeight: 500,
		lineHeight: "20px",
		color: colors.contentNegative,
		marginTop: sizing.scale100,
		marginBottom: sizing.scale100,
	},
});

// --- Button row -------------------------------------------------------------

export const buttonRowStyles = stylex.create({
	base: {
		display: "flex",
		flexDirection: "row",
		gap: sizing.scale300,
		marginTop: sizing.scale500,
		alignItems: "center",
	},
});

// --- Hidden file input ------------------------------------------------------

export const hiddenInputStyles = stylex.create({
	base: {
		// Visually hidden but still focusable.
		position: "absolute",
		width: "1px",
		height: "1px",
		padding: 0,
		margin: "-1px",
		overflow: "hidden",
		clip: "rect(0, 0, 0, 0)",
		whiteSpace: "nowrap",
		borderTopWidth: 0,
		borderRightWidth: 0,
		borderBottomWidth: 0,
		borderLeftWidth: 0,
	},
});

// --- Progress bar -----------------------------------------------------------

export const progressBarStyles = stylex.create({
	track: {
		width: "100%",
		height: sizing.scale100,
		backgroundColor: colors.backgroundTertiary,
		borderRadius: "999px",
		overflow: "hidden",
		marginTop: sizing.scale300,
		marginBottom: sizing.scale300,
	},
	fill: {
		height: "100%",
		backgroundColor: colors.backgroundAccent,
		borderRadius: "999px",
		transitionProperty: "width",
		transitionDuration: "200ms",
		transitionTimingFunction: "linear",
	},
	fillError: {
		backgroundColor: colors.backgroundNegative,
	},
});
