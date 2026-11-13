import type {
  FoundationColors,
  CoreSemanticColors,
  CoreExtensionSemanticColors,
  SemanticColors,
  HoveredAndPressedSemanticColors,
} from '../types';
import defaultFoundationColors from './color-foundation-tokens';
import { hexToRgb as hexToRgba } from '../utils';
import { primitiveLightColors } from '../../tokens';

export default (
  foundation: FoundationColors = defaultFoundationColors,
): SemanticColors => {
  const core: CoreSemanticColors = {
    // Background
    backgroundPrimary: foundation.primaryB,
    backgroundSecondary: primitiveLightColors.gray50,
    backgroundTertiary: primitiveLightColors.gray100,
    backgroundInversePrimary: foundation.primaryA,
    backgroundInverseSecondary: primitiveLightColors.gray900,

    // Content
    contentPrimary: foundation.primaryA,
    contentSecondary: primitiveLightColors.gray800,
    contentTertiary: primitiveLightColors.gray700,
    contentInversePrimary: foundation.primaryB,
    contentInverseSecondary: primitiveLightColors.gray200,
    contentInverseTertiary: primitiveLightColors.gray400,

    // Border
    borderOpaque: primitiveLightColors.gray50,
    borderTransparent:
      hexToRgba(foundation.primaryA, '0.08') ||
      hexToRgba(defaultFoundationColors.primaryA, '0.08') ||
      '',
    borderSelected: foundation.primaryA,
    borderInverseOpaque: primitiveLightColors.gray800,
    borderInverseTransparent:
      hexToRgba(foundation.primaryB, '0.2') ||
      hexToRgba(defaultFoundationColors.primaryB, '0.2') ||
      '',
    borderInverseSelected: foundation.primaryB,

    // Brand
    brandBackgroundPrimary: primitiveLightColors.brandDefault600,
    brandBackgroundSecondary: primitiveLightColors.brandDefault50,
    brandBackgroundTertiary: primitiveLightColors.white,
    brandBackgroundDisabled: primitiveLightColors.brandDefault50,
    brandContentPrimary: primitiveLightColors.brandDefault600,
    brandContentOnPrimary: primitiveLightColors.white,
    brandContentOnSecondary: primitiveLightColors.brandDefault700,
    brandContentOnTertiary: primitiveLightColors.black,
    brandContentOnGradient: primitiveLightColors.white,
    brandContentDisabled: primitiveLightColors.brandDefault300,
    brandBorderAccessible: primitiveLightColors.brandDefault600,
    brandBorderSubtle: primitiveLightColors.brandDefault100,
  };

  const coreExtensions: CoreExtensionSemanticColors = {
    // Backgrounds
    backgroundStateDisabled: primitiveLightColors.gray50,
    backgroundOverlay: hexToRgba(primitiveLightColors.black, '0.5') || '',
    backgroundOverlayArt: hexToRgba(primitiveLightColors.black, '0.00') || '',
    backgroundAccent: foundation.accent,
    backgroundNegative: foundation.negative,
    backgroundWarning: foundation.warning,
    backgroundPositive: foundation.positive,
    backgroundAccentLight: primitiveLightColors.blue50,
    backgroundNegativeLight: primitiveLightColors.red50,
    backgroundWarningLight: primitiveLightColors.yellow50,
    backgroundPositiveLight: primitiveLightColors.green50,
    backgroundAlwaysDark: primitiveLightColors.black,
    backgroundAlwaysLight: primitiveLightColors.white,

    // Content
    contentStateDisabled: primitiveLightColors.gray400,
    contentOnColor: primitiveLightColors.white,
    contentOnColorInverse: primitiveLightColors.black,
    contentAccent: primitiveLightColors.blue600,
    contentNegative: primitiveLightColors.red600,
    contentWarning: primitiveLightColors.yellow600,
    contentPositive: primitiveLightColors.green600,

    // Border
    borderStateDisabled: primitiveLightColors.gray50,
    borderAccent: primitiveLightColors.blue600,
    borderAccentLight: primitiveLightColors.blue300,
    borderNegative: primitiveLightColors.red600,
    borderNegativeLight: primitiveLightColors.red300,
    borderWarning: primitiveLightColors.yellow600,
    borderWarningLight: primitiveLightColors.yellow200,
    borderPositive: primitiveLightColors.green600,
    borderPositiveLight: primitiveLightColors.green300,

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
    hoverOverlayInverseAlpha: 'rgba(255, 255, 255, 0.1)',
    hoverOverlayAlpha: 'rgba(0, 0, 0, 0.04)',
    hoverNegativeAlpha: 'rgba(222, 17, 53, 0.1)',
    pressedOverlayAlpha: 'rgba(0, 0, 0, 0.08)',
    pressedOverlayInverseAlpha: 'rgba(255, 255, 255, 0.2)',
    pressedNegativeAlpha: 'rgba(222, 17, 53, 0.15)',
  };

  return {
    ...core,
    ...coreExtensions,
    ...hoveredAndPressedColors,
  };
};
