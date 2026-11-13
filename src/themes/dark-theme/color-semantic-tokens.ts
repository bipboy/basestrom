import type {
  FoundationColors,
  CoreSemanticColors,
  CoreExtensionSemanticColors,
  SemanticColors,
  HoveredAndPressedSemanticColors,
} from '../types';
import defaultFoundationColors from './color-foundation-tokens';
import { hexToRgb as hexToRgba } from '../utils';
import { primitiveLightColors, primitiveDarkColors } from '../../tokens/color-primitive-tokens';

export default (foundation: FoundationColors = defaultFoundationColors): SemanticColors => {
  const core: CoreSemanticColors = {
    // Background
    backgroundPrimary: foundation.primaryB,
    backgroundSecondary: primitiveDarkColors.gray100Dark,
    backgroundTertiary: primitiveDarkColors.gray200Dark,
    backgroundInversePrimary: primitiveDarkColors.gray800Dark,
    backgroundInverseSecondary: primitiveDarkColors.gray700Dark,

    // Content
    contentPrimary: foundation.primaryA,
    contentSecondary: primitiveDarkColors.gray800Dark,
    contentTertiary: primitiveDarkColors.gray700Dark,
    contentInversePrimary: primitiveDarkColors.black,
    contentInverseSecondary: primitiveDarkColors.gray200Dark,
    contentInverseTertiary: primitiveDarkColors.gray300Dark,

    // Border
    borderOpaque: primitiveDarkColors.gray100Dark,
    borderTransparent: hexToRgba(foundation.primaryA, '0.08') || '',
    borderSelected: foundation.primaryA,
    borderInverseOpaque: primitiveDarkColors.gray300Dark,
    borderInverseTransparent: hexToRgba(foundation.primaryB, '0.2') || '',
    borderInverseSelected: foundation.primaryB,

    // Brand
    brandBackgroundPrimary: primitiveDarkColors.brandDefault500Dark,
    brandBackgroundSecondary: primitiveDarkColors.brandDefault100Dark,
    brandBackgroundTertiary: primitiveDarkColors.white,
    brandBackgroundDisabled: primitiveDarkColors.brandDefault100Dark,
    brandContentPrimary: primitiveDarkColors.brandDefault600Dark,
    brandContentOnPrimary: primitiveDarkColors.white,
    brandContentOnSecondary: primitiveDarkColors.brandDefault700Dark,
    brandContentOnTertiary: primitiveDarkColors.black,
    brandContentOnGradient: primitiveDarkColors.white,
    brandContentDisabled: primitiveDarkColors.brandDefault400Dark,
    brandBorderAccessible: primitiveDarkColors.brandDefault600Dark,
    brandBorderSubtle: primitiveDarkColors.brandDefault400Dark,
  };

  const coreExtensions: CoreExtensionSemanticColors = {
    // Backgrounds
    backgroundStateDisabled: primitiveDarkColors.gray100Dark,
    backgroundOverlay: hexToRgba(primitiveDarkColors.black, '0.7') || '',
    backgroundOverlayArt: hexToRgba(primitiveDarkColors.black, '0.16') || '',
    backgroundAccent: foundation.accent,
    backgroundNegative: foundation.negative,
    backgroundWarning: foundation.warning,
    backgroundPositive: foundation.positive,
    backgroundAccentLight: primitiveDarkColors.blue100Dark,
    backgroundPositiveLight: primitiveDarkColors.green100Dark,
    backgroundNegativeLight: primitiveDarkColors.red100Dark,
    backgroundWarningLight: primitiveDarkColors.yellow100Dark,
    backgroundAlwaysDark: primitiveDarkColors.gray100Dark,
    backgroundAlwaysLight: primitiveDarkColors.gray900Dark,

    // Content
    contentStateDisabled: primitiveDarkColors.gray400Dark,
    contentAccent: primitiveDarkColors.blue600Dark,
    contentOnColor: primitiveDarkColors.gray900Dark,
    contentOnColorInverse: primitiveDarkColors.black,
    contentNegative: primitiveDarkColors.red600Dark,
    contentWarning: primitiveDarkColors.yellow600Dark,
    contentPositive: primitiveDarkColors.green600Dark,

    // Border
    borderStateDisabled: primitiveDarkColors.gray100Dark,
    borderAccent: primitiveDarkColors.blue500Dark,
    borderAccentLight: primitiveDarkColors.blue400Dark,
    borderNegative: primitiveDarkColors.red500Dark,
    borderNegativeLight: primitiveDarkColors.red400Dark,
    borderWarning: primitiveDarkColors.yellow500Dark,
    borderWarningLight: primitiveDarkColors.yellow400Dark,
    borderPositive: primitiveDarkColors.green500Dark,
    borderPositiveLight: primitiveDarkColors.green400Dark,

    // Programs
    safety: primitiveLightColors.blue600,
    eatsGreen400: primitiveLightColors.green600,
    freightBlue400: primitiveLightColors.blue400,
    rewardsTier1: primitiveLightColors.blue600,
    rewardsTier2: primitiveLightColors.yellow300,
    rewardsTier3: primitiveLightColors.gray400,
    rewardsTier4: primitiveLightColors.black,
    membership: primitiveLightColors.yellow600,
  };

  const hoveredAndPressedColors: HoveredAndPressedSemanticColors = {
    hoverOverlayInverseAlpha: 'rgba(0, 0, 0, 0.04)',
    hoverOverlayAlpha: 'rgba(255, 255, 255, 0.1)',
    hoverNegativeAlpha: 'rgba(163, 44, 52, 0.4)',
    pressedOverlayAlpha: 'rgba(255, 255, 255, 0.15)',
    pressedOverlayInverseAlpha: 'rgba(0, 0, 0, 0.08)',
    pressedNegativeAlpha: 'rgba(163, 44, 52, 0.6)',
  };

  return {
    ...core,
    ...coreExtensions,
    ...hoveredAndPressedColors,
  };
};
