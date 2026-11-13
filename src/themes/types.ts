/**
 * Theme type definitions.
 * Direct port from baseweb/themes/types.ts
 */

export type Responsive<T> = T | T[];

export type CSSLengthUnit = "px" | "em" | "rem" | "vh" | "vw" | "%";

export type FoundationColors = {
	// Primary Palette
	primaryA: string;
	primaryB: string;
	primary: string;
	primary50: string;
	primary100: string;
	primary200: string;
	primary300: string;
	primary400: string;
	primary500: string;
	primary600: string;
	primary700: string;

	// Accent Palette
	accent: string;
	accent50: string;
	accent100: string;
	accent200: string;
	accent300: string;
	accent400: string;
	accent500: string;
	accent600: string;
	accent700: string;

	// Negative Palette
	negative: string;
	negative50: string;
	negative100: string;
	negative200: string;
	negative300: string;
	negative400: string;
	negative500: string;
	negative600: string;
	negative700: string;

	// Warning Palette
	warning: string;
	warning50: string;
	warning100: string;
	warning200: string;
	warning300: string;
	warning400: string;
	warning500: string;
	warning600: string;
	warning700: string;

	// Positive Palette
	positive: string;
	positive50: string;
	positive100: string;
	positive200: string;
	positive300: string;
	positive400: string;
	positive500: string;
	positive600: string;
	positive700: string;

	// Monochrome Palette
	white: string;
	black: string;
	mono100: string;
	mono200: string;
	mono300: string;
	mono400: string;
	mono500: string;
	mono600: string;
	mono700: string;
	mono800: string;
	mono900: string;
	mono1000: string;
};

export type CoreSemanticColors = {
	// Background
	backgroundPrimary: string;
	backgroundSecondary: string;
	backgroundTertiary: string;
	backgroundInversePrimary: string;
	backgroundInverseSecondary: string;
	// Content
	contentPrimary: string;
	contentSecondary: string;
	contentTertiary: string;
	contentInversePrimary: string;
	contentInverseSecondary: string;
	contentInverseTertiary: string;
	// Border
	borderOpaque: string;
	borderTransparent: string;
	borderSelected: string;
	borderInverseOpaque: string;
	borderInverseTransparent: string;
	borderInverseSelected: string;
	// Brand
	brandBackgroundPrimary: string;
	brandBackgroundSecondary: string;
	brandBackgroundTertiary: string;
	brandBackgroundDisabled: string;
	brandContentPrimary: string;
	brandContentOnPrimary: string;
	brandContentOnSecondary: string;
	brandContentOnTertiary: string;
	brandContentOnGradient: string;
	brandContentDisabled: string;
	brandBorderAccessible: string;
	brandBorderSubtle: string;
};

export type CoreExtensionSemanticColors = {
	// Backgrounds
	backgroundStateDisabled: string;
	backgroundOverlay: string;
	backgroundOverlayArt: string;
	backgroundAccent: string;
	backgroundNegative: string;
	backgroundWarning: string;
	backgroundPositive: string;
	backgroundAccentLight: string;
	backgroundPositiveLight: string;
	backgroundNegativeLight: string;
	backgroundWarningLight: string;
	backgroundAlwaysDark: string;
	backgroundAlwaysLight: string;
	// Content
	contentStateDisabled: string;
	contentAccent: string;
	contentOnColor: string;
	contentOnColorInverse: string;
	contentNegative: string;
	contentWarning: string;
	contentPositive: string;
	// Border
	borderStateDisabled: string;
	borderAccent: string;
	borderAccentLight: string;
	borderNegative: string;
	borderWarning: string;
	borderPositive: string;
	borderNegativeLight: string;
	borderWarningLight: string;
	borderPositiveLight: string;
	// Programs
	safety: string;
	eatsGreen400: string;
	freightBlue400: string;
	rewardsTier1: string;
	rewardsTier2: string;
	rewardsTier3: string;
	rewardsTier4: string;
	membership: string;
};

export type HoveredAndPressedSemanticColors = {
	hoverOverlayInverseAlpha: string;
	pressedOverlayInverseAlpha: string;
	hoverOverlayAlpha: string;
	pressedOverlayAlpha: string;
	hoverNegativeAlpha: string;
	pressedNegativeAlpha: string;
};

export type SemanticColors = CoreSemanticColors &
	CoreExtensionSemanticColors &
	HoveredAndPressedSemanticColors;

export type FontTokens = {
	primaryFontFamily: string;
	secondaryFontFamily: string;
	monoFontFamily: string;
};

export type Primitives = FoundationColors & FontTokens;

export type Font = {
	fontFamily: string;
	fontWeight: "bold" | "normal" | "bolder" | "lighter" | number;
	fontSize: string;
	lineHeight: string | number;
};

export type Typography = {
	font100: Font;
	font150: Font;
	font200: Font;
	font250: Font;
	font300: Font;
	font350: Font;
	font400: Font;
	font450: Font;
	font550: Font;
	font650: Font;
	font750: Font;
	font850: Font;
	font950: Font;
	font1050: Font;
	font1150: Font;
	font1250: Font;
	font1350: Font;
	font1450: Font;
	ParagraphXSmall: Font;
	ParagraphSmall: Font;
	ParagraphMedium: Font;
	ParagraphLarge: Font;
	LabelXSmall: Font;
	LabelSmall: Font;
	LabelMedium: Font;
	LabelLarge: Font;
	HeadingXSmall: Font;
	HeadingSmall: Font;
	HeadingMedium: Font;
	HeadingLarge: Font;
	HeadingXLarge: Font;
	HeadingXXLarge: Font;
	DisplayXSmall: Font;
	DisplaySmall: Font;
	DisplayMedium: Font;
	DisplayLarge: Font;
	MonoParagraphXSmall: Font;
	MonoParagraphSmall: Font;
	MonoParagraphMedium: Font;
	MonoParagraphLarge: Font;
	MonoLabelXSmall: Font;
	MonoLabelSmall: Font;
	MonoLabelMedium: Font;
	MonoLabelLarge: Font;
	MonoHeadingXSmall: Font;
	MonoHeadingSmall: Font;
	MonoHeadingMedium: Font;
	MonoHeadingLarge: Font;
	MonoHeadingXLarge: Font;
	MonoHeadingXXLarge: Font;
	MonoDisplayXSmall: Font;
	MonoDisplaySmall: Font;
	MonoDisplayMedium: Font;
	MonoDisplayLarge: Font;
};

export type Sizing = {
	scale0: string;
	scale100: string;
	scale200: string;
	scale300: string;
	scale400: string;
	scale500: string;
	scale550: string;
	scale600: string;
	scale650: string;
	scale700: string;
	scale750: string;
	scale800: string;
	scale850: string;
	scale900: string;
	scale950: string;
	scale1000: string;
	scale1200: string;
	scale1400: string;
	scale1600: string;
	scale2400: string;
	scale3200: string;
	scale4800: string;
};

export type Breakpoints = {
	small: number;
	medium: number;
	large: number;
};

export type MediaQuery = {
	small: string;
	medium: string;
	large: string;
};

export type Lighting = {
	shadow400: string;
	shadow500: string;
	shadow600: string;
	shadow700: string;
	overlay0: string;
	overlay100: string;
	overlay200: string;
	overlay300: string;
	overlay400: string;
	overlay500: string;
	overlay600: string;
	shallowAbove: string;
	shallowBelow: string;
	deepAbove: string;
	deepBelow: string;
};

export type Animation = {
	timing0: string;
	timing100: string;
	timing150: string;
	timing200: string;
	timing250: string;
	timing300: string;
	timing400: string;
	timing500: string;
	timing600: string;
	timing700: string;
	timing800: string;
	timing900: string;
	timing1000: string;
	timing1500: string;
	timing3000: string;
	timing5000: string;
	timing7000: string;
	easeOutCurve: string;
	easeInCurve: string;
	easeInOutCurve: string;
	easeInQuinticCurve: string;
	easeOutQuinticCurve: string;
	easeInOutQuinticCurve: string;
	linearCurve: string;
	easeLinear: string;
	easeDecelerate: string;
	easeAccelerate: string;
	easeAccelerateDecelerate: string;
	easeResponsiveAccelerate: string;
};

export type Border = {
	borderColor: string;
	borderStyle: string;
	borderWidth: string;
};

export type Borders = {
	border100: Border;
	border200: Border;
	border300: Border;
	border400: Border;
	border500: Border;
	border600: Border;
	radius100: string;
	radius200: string;
	radius300: string;
	radius400: string;
	radius500: string;
	useRoundedCorners: boolean;
	buttonBorderRadius: string;
	buttonBorderRadiusMini: string;
	checkboxBorderRadius: string;
	surfaceBorderRadius: string;
	inputBorderRadius: string;
	inputBorderRadiusMini: string;
	popoverBorderRadius: string;
	tagBorderRadius: string;
};

export type Grid = {
	columns: Responsive<number>;
	gutters: Responsive<number>;
	margins: Responsive<number>;
	gaps: Responsive<number>;
	maxWidth: number;
	unit: CSSLengthUnit;
};
