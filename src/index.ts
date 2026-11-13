/**
 * basestrom - Ember v2 addon with StyleX
 *
 * Component library implementing the Base design language.
 * Ported from baseweb (React/Styletron) to Ember Octane + StyleX.
 */

// ─── Components (Bst-prefixed for strict mode templates) ────────────────────────

export { default as BstAspectRatioBox } from "./components/aspect-ratio-box/index.gts";
// Feedback
export { default as BstBanner } from "./components/banner/index.gts";
// Layout
export { default as BstBlock } from "./components/block/index.gts";
export { default as BstButton } from "./components/button/index.gts";
// Actions
export { default as BstButtonDock } from "./components/button-dock/index.gts";
export {
  default as BstButtonGroup,
  StatefulButtonGroup as BstStatefulButtonGroup
} from "./components/button-group/index.gts";
export { default as BstButtonTimed } from "./components/button-timed/index.gts";
// Content
export { default as BstCard } from "./components/card/index.gts";
export { default as BstCheckbox } from "./components/checkbox/index.gts";
export { default as BstCombobox } from "./components/combobox/index.gts";
export { default as BstDialog } from "./components/dialog/index.gts";
export { default as BstDivider } from "./components/divider/index.gts";
export { default as BstDrawer } from "./components/drawer/index.gts";
export { default as BstFileUploader } from "./components/file-uploader/index.gts";
export {
  FlexGrid as BstFlexGrid,
  FlexGridItem as BstFlexGridItem
} from "./components/flex-grid/index.gts";
export { default as BstFormControl } from "./components/form-control/index.gts";
export { Cell as BstCell, Grid as BstGrid } from "./components/grid/index.gts";
export { default as BstHeading } from "./components/heading/index.gts";
export {
  Alert as BstIconAlert,
  ArrowDownLeft as BstIconArrowDownLeft,
  ArrowUpLeft as BstIconArrowUpLeft,
  ArrowUpRight as BstIconArrowUpRight,
  Caret as BstIconCaret,
  Check as BstIconCheck,
  ChevronDown as BstIconChevronDown,
  ChevronLeft as BstIconChevronLeft,
  ChevronRight as BstIconChevronRight,
  ChevronUp as BstIconChevronUp,
  CloudLightning as BstIconCloudLightning,
  CloudLock as BstIconCloudLock,
  Delete as BstIconDelete,
  DeleteAlt as BstIconDeleteAlt,
  Edit as BstIconEdit,
  Hide as BstIconHide,
  Info as BstIconInfo,
  Plus as BstIconPlus,
  Search as BstIconSearch,
  Settings as BstIconSettings,
  Show as BstIconShow,
  TrashCanFilled as BstIconTrashCanFilled,
  Upload as BstIconUpload,
  Wand as BstIconWand
} from "./components/icon/glyphs.gts";
// Iconography
export { default as BstIcon } from "./components/icon/index.gts";
// Form
export { default as BstInput } from "./components/input/index.gts";
export {
  LayoutCell as BstLayoutCell,
  LayoutGrid as BstLayoutGrid
} from "./components/layout-grid/index.gts";
export { default as BstLink } from "./components/link/index.gts";
export { default as BstModal } from "./components/modal/index.gts";
export {
  default as BstPagination,
  StatefulPagination as BstStatefulPagination
} from "./components/pagination/index.gts";
export {
  Popover as BstPopover,
  ACCESSIBILITY_TYPE as BstPopoverAccessibilityType,
  PLACEMENT as BstPopoverPlacement,
  TRIGGER_TYPE as BstPopoverTriggerType,
  default as BstStatefulPopover
} from "./components/popover/index.gts";
export {
  Radio as BstRadio,
  RadioGroup as BstRadioGroup
} from "./components/radio/index.gts";
export {
  Segment as BstSegment,
  SegmentedControl as BstSegmentedControl
} from "./components/segmented-control/index.gts";
export {
  SelectBase as BstSelectBase,
  SelectField as BstSelectField
} from "./components/select/index.gts";
export { default as BstSkeleton } from "./components/skeleton/index.gts";
export {
  default as BstSlider,
  StatefulSlider as BstStatefulSlider
} from "./components/slider/index.gts";
export { default as BstSlidingButton } from "./components/sliding-button/index.gts";
export {
  SnackbarContainer as BstSnackbarContainer,
  SnackbarElement as BstSnackbarElement
} from "./components/snackbar/index.gts";
export {
  default as BstSpinner,
  SIZE as BstSpinnerSize
} from "./components/spinner/index.gts";
export { default as BstSwitch } from "./components/switch/index.gts";
export { SystemBanner as BstSystemBanner } from "./components/system-banner/index.gts";
export { default as BstTextarea } from "./components/textarea/index.gts";

// Typography
export {
  DisplayLarge as BstDisplayLarge,
  DisplayMedium as BstDisplayMedium,
  DisplaySmall as BstDisplaySmall,
  DisplayXSmall as BstDisplayXSmall,
  HeadingLarge as BstHeadingLarge,
  HeadingLevel as BstHeadingLevel,
  HeadingMedium as BstHeadingMedium,
  HeadingSmall as BstHeadingSmall,
  HeadingXLarge as BstHeadingXLarge,
  HeadingXSmall as BstHeadingXSmall,
  HeadingXXLarge as BstHeadingXXLarge,
  LabelLarge as BstLabelLarge,
  LabelMedium as BstLabelMedium,
  LabelSmall as BstLabelSmall,
  LabelXSmall as BstLabelXSmall,
  MonoDisplayLarge as BstMonoDisplayLarge,
  MonoDisplayMedium as BstMonoDisplayMedium,
  MonoDisplaySmall as BstMonoDisplaySmall,
  MonoDisplayXSmall as BstMonoDisplayXSmall,
  MonoHeadingLarge as BstMonoHeadingLarge,
  MonoHeadingMedium as BstMonoHeadingMedium,
  MonoHeadingSmall as BstMonoHeadingSmall,
  MonoHeadingXLarge as BstMonoHeadingXLarge,
  MonoHeadingXSmall as BstMonoHeadingXSmall,
  MonoHeadingXXLarge as BstMonoHeadingXXLarge,
  MonoLabelLarge as BstMonoLabelLarge,
  MonoLabelMedium as BstMonoLabelMedium,
  MonoLabelSmall as BstMonoLabelSmall,
  MonoLabelXSmall as BstMonoLabelXSmall,
  MonoParagraphLarge as BstMonoParagraphLarge,
  MonoParagraphMedium as BstMonoParagraphMedium,
  MonoParagraphSmall as BstMonoParagraphSmall,
  MonoParagraphXSmall as BstMonoParagraphXSmall,
  ParagraphLarge as BstParagraphLarge,
  ParagraphMedium as BstParagraphMedium,
  ParagraphSmall as BstParagraphSmall,
  ParagraphXSmall as BstParagraphXSmall
} from "./components/typography/index.gts";

// ─── Utilities ──────────────────────────────────────────────────────────────────

// A11y
export { generateId, prefersReducedMotion, ROLE, trapFocus } from "./a11y";
export type {
  BannerOverrides,
  BannerSignature
} from "./components/banner/index.gts";
// ─── Type exports ───────────────────────────────────────────────────────────────
export type {
  BlockOverrides,
  BlockSignature
} from "./components/block/index.gts";
export type {
  ButtonOverrides,
  ButtonSignature
} from "./components/button/index.gts";
export type { CardOverrides, CardSignature } from "./components/card/index.gts";
export type {
  ComboboxOverrides,
  ComboboxSignature,
  ComboboxSize
} from "./components/combobox/index.gts";
export type {
  DialogOverrides,
  DialogSignature
} from "./components/dialog/index.gts";
export type {
  FormControlCounter,
  FormControlOverrides,
  FormControlSignature,
  FormControlYieldedState
} from "./components/form-control/index.gts";
export type {
  HeadingOverrides,
  HeadingSignature
} from "./components/heading/index.gts";
export type {
  IconOverrides,
  IconSignature
} from "./components/icon/index.gts";
export type {
  InputOverrides,
  InputSignature
} from "./components/input/index.gts";
export type { InteractiveSignature } from "./components/interactive/index.gts";
export type {
  ModalCloseSource,
  ModalOverrides,
  ModalRole,
  ModalSignature,
  ModalSize
} from "./components/modal/index.gts";
export type {
  PaginationOverrides,
  PaginationSignature
} from "./components/pagination/index.gts";
export type {
  AccessibilityType as PopoverAccessibilityType,
  PopoverOverrides,
  PopoverPlacement,
  PopoverSignature,
  TriggerType as PopoverTriggerType,
  StatefulPopoverSignature
} from "./components/popover/index.gts";
export type {
  SliderOverrides,
  SliderSignature
} from "./components/slider/index.gts";
export type { SnackbarOverrides } from "./components/snackbar/index.gts";
export type {
  SpinnerOverrides,
  SpinnerSignature
} from "./components/spinner/index.gts";
export type { Overrides, StyleOverride } from "./helpers/overrides";

// Helpers (Override system)
export { mergeOverrides, resolveOverride } from "./helpers/overrides";
// Locale
export { en_US, ru_RU } from "./locale";
export type { Locale } from "./locale/types";
// Modifiers
export {
  bstClipboard,
  bstOnArgsChange,
  bstRef,
  bstScrollIntoView,
  type BstClipboardModifierSignature,
  type BstOnArgsChangeModifierSignature,
  type BstRefModifierSignature,
  type BstScrollIntoViewModifierSignature
} from "./modifiers";

// Theme
export { default as ThemeService } from "./services/theme";
export {
  createDarkTheme,
  createLightTheme,
  createTheme,
  DarkTheme,
  darkThemePrimitives,
  LightTheme,
  lightThemePrimitives
} from "./themes";
export type { Theme } from "./themes/theme-type";
export type {
  Animation,
  Border,
  Borders,
  Breakpoints,
  CoreExtensionSemanticColors,
  CoreSemanticColors,
  Font,
  FontTokens,
  FoundationColors,
  Grid,
  HoveredAndPressedSemanticColors,
  Lighting,
  MediaQuery,
  Primitives,
  SemanticColors,
  Sizing,
  Typography
} from "./themes/types";
// Tokens
export {
  primitiveColors,
  primitiveDarkColors,
  primitiveLightColors
} from "./tokens";
export type {
  PrimitiveColors,
  PrimitiveDarkColors,
  PrimitiveLightColors
} from "./tokens/types";
// Utils
export {
  camelToKebab,
  deepMerge,
  getMediaQueries,
  getMediaQuery,
  ownerDocument
} from "./utils";

