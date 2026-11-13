/**
 * Template registry for Glint type-checking.
 * All public components are registered here.
 */

import type AspectRatioBox from "./components/aspect-ratio-box/index.gts";
import type Banner from "./components/banner/index.gts";
import type Block from "./components/block/index.gts";
import type ButtonDock from "./components/button-dock/index.gts";
import type ButtonGroup from "./components/button-group/index.gts";
import type { StatefulButtonGroup } from "./components/button-group/index.gts";
import type ButtonTimed from "./components/button-timed/index.gts";
import type Button from "./components/button/index.gts";
import type Card from "./components/card/index.gts";
import type Checkbox from "./components/checkbox/index.gts";
import type Combobox from "./components/combobox/index.gts";
import type Dialog from "./components/dialog/index.gts";
import type Divider from "./components/divider/index.gts";
import type Drawer from "./components/drawer/index.gts";
import type FileUploader from "./components/file-uploader/index.gts";
import type { FlexGrid, FlexGridItem } from "./components/flex-grid/index.gts";
import type FormControl from "./components/form-control/index.gts";
import type { Cell, Grid } from "./components/grid/index.gts";
import type Heading from "./components/heading/index.gts";
import type {
	Alert,
	Check,
	ChevronRight,
	Delete,
	DeleteAlt,
	Hide,
	Plus,
	Search,
	Show,
	TrashCanFilled,
} from "./components/icon/glyphs.gts";
import type Icon from "./components/icon/index.gts";
import type Input from "./components/input/index.gts";
import type Interactive from "./components/interactive/index.gts";
import type {
	LayoutCell,
	LayoutGrid,
} from "./components/layout-grid/index.gts";
import type Link from "./components/link/index.gts";
import type Pagination from "./components/pagination/index.gts";
import type { StatefulPagination } from "./components/pagination/index.gts";
import type StatefulPopover from "./components/popover/index.gts";
import type { Popover } from "./components/popover/index.gts";
import type { Radio, RadioGroup } from "./components/radio/index.gts";
import type {
	Segment,
	SegmentedControl,
} from "./components/segmented-control/index.gts";
import type Skeleton from "./components/skeleton/index.gts";
import type Slider from "./components/slider/index.gts";
import type { StatefulSlider } from "./components/slider/index.gts";
import type SlidingButton from "./components/sliding-button/index.gts";
import type {
	SnackbarContainer,
	SnackbarElement,
} from "./components/snackbar/index.gts";
import type Spinner from "./components/spinner/index.gts";
import type Switch from "./components/switch/index.gts";
import type { SystemBanner } from "./components/system-banner/index.gts";
import type Textarea from "./components/textarea/index.gts";
import type {
	DisplayLarge,
	DisplayMedium,
	DisplaySmall,
	DisplayXSmall,
	HeadingLarge,
	HeadingLevel,
	HeadingMedium,
	HeadingSmall,
	HeadingXLarge,
	HeadingXSmall,
	HeadingXXLarge,
	LabelLarge,
	LabelMedium,
	LabelSmall,
	LabelXSmall,
	MonoDisplayLarge,
	MonoDisplayMedium,
	MonoDisplaySmall,
	MonoDisplayXSmall,
	MonoHeadingLarge,
	MonoHeadingMedium,
	MonoHeadingSmall,
	MonoHeadingXLarge,
	MonoHeadingXSmall,
	MonoHeadingXXLarge,
	MonoLabelLarge,
	MonoLabelMedium,
	MonoLabelSmall,
	MonoLabelXSmall,
	MonoParagraphLarge,
	MonoParagraphMedium,
	MonoParagraphSmall,
	MonoParagraphXSmall,
	ParagraphLarge,
	ParagraphMedium,
	ParagraphSmall,
	ParagraphXSmall,
} from "./components/typography/index.gts";

export default interface BasestromRegistry {
	// Core
	BstInteractive: typeof Interactive;

	// Layout
	BstBanner: typeof Banner;
	BstBlock: typeof Block;
	BstButton: typeof Button;
	BstButtonGroup: typeof ButtonGroup;
	BstStatefulButtonGroup: typeof StatefulButtonGroup;
	BstButtonTimed: typeof ButtonTimed;
	BstButtonDock: typeof ButtonDock;
	BstSlidingButton: typeof SlidingButton;
	BstSpinner: typeof Spinner;
	BstGrid: typeof Grid;
	BstCell: typeof Cell;
	BstLayoutGrid: typeof LayoutGrid;
	BstLayoutCell: typeof LayoutCell;
	BstFlexGrid: typeof FlexGrid;
	BstFlexGridItem: typeof FlexGridItem;
	BstFormControl: typeof FormControl;

	// Utility
	BstAspectRatioBox: typeof AspectRatioBox;
	BstCard: typeof Card;
	BstDialog: typeof Dialog;
	BstDrawer: typeof Drawer;
	BstDivider: typeof Divider;
	BstHeading: typeof Heading;
	BstPagination: typeof Pagination;
	BstStatefulPagination: typeof StatefulPagination;
	BstPopover: typeof Popover;
	BstStatefulPopover: typeof StatefulPopover;
	BstIcon: typeof Icon;
	BstIconAlert: typeof Alert;
	BstIconCheck: typeof Check;
	BstIconChevronRight: typeof ChevronRight;
	BstIconDelete: typeof Delete;
	BstIconDeleteAlt: typeof DeleteAlt;
	BstIconHide: typeof Hide;
	BstIconPlus: typeof Plus;
	BstIconSearch: typeof Search;
	BstIconShow: typeof Show;
	BstIconTrashCanFilled: typeof TrashCanFilled;
	BstLink: typeof Link;
	BstSkeleton: typeof Skeleton;

	// Form
	BstCheckbox: typeof Checkbox;
	BstCombobox: typeof Combobox;
	BstInput: typeof Input;
	BstSlider: typeof Slider;
	BstStatefulSlider: typeof StatefulSlider;
	BstSnackbarElement: typeof SnackbarElement;
	BstSnackbarContainer: typeof SnackbarContainer;
	BstSwitch: typeof Switch;
	BstSystemBanner: typeof SystemBanner;
	BstTextarea: typeof Textarea;
	BstRadio: typeof Radio;
	BstRadioGroup: typeof RadioGroup;
	BstSegmentedControl: typeof SegmentedControl;
	BstSegment: typeof Segment;
	BstFileUploader: typeof FileUploader;

	// Typography
	BstDisplayLarge: typeof DisplayLarge;
	BstDisplayMedium: typeof DisplayMedium;
	BstDisplaySmall: typeof DisplaySmall;
	BstDisplayXSmall: typeof DisplayXSmall;
	BstHeadingXXLarge: typeof HeadingXXLarge;
	BstHeadingXLarge: typeof HeadingXLarge;
	BstHeadingLarge: typeof HeadingLarge;
	BstHeadingMedium: typeof HeadingMedium;
	BstHeadingSmall: typeof HeadingSmall;
	BstHeadingXSmall: typeof HeadingXSmall;
	BstLabelLarge: typeof LabelLarge;
	BstLabelMedium: typeof LabelMedium;
	BstLabelSmall: typeof LabelSmall;
	BstLabelXSmall: typeof LabelXSmall;
	BstParagraphLarge: typeof ParagraphLarge;
	BstParagraphMedium: typeof ParagraphMedium;
	BstParagraphSmall: typeof ParagraphSmall;
	BstParagraphXSmall: typeof ParagraphXSmall;

	// Typography - Mono
	BstMonoDisplayLarge: typeof MonoDisplayLarge;
	BstMonoDisplayMedium: typeof MonoDisplayMedium;
	BstMonoDisplaySmall: typeof MonoDisplaySmall;
	BstMonoDisplayXSmall: typeof MonoDisplayXSmall;
	BstMonoHeadingXXLarge: typeof MonoHeadingXXLarge;
	BstMonoHeadingXLarge: typeof MonoHeadingXLarge;
	BstMonoHeadingLarge: typeof MonoHeadingLarge;
	BstMonoHeadingMedium: typeof MonoHeadingMedium;
	BstMonoHeadingSmall: typeof MonoHeadingSmall;
	BstMonoHeadingXSmall: typeof MonoHeadingXSmall;
	BstMonoLabelLarge: typeof MonoLabelLarge;
	BstMonoLabelMedium: typeof MonoLabelMedium;
	BstMonoLabelSmall: typeof MonoLabelSmall;
	BstMonoLabelXSmall: typeof MonoLabelXSmall;
	BstMonoParagraphLarge: typeof MonoParagraphLarge;
	BstMonoParagraphMedium: typeof MonoParagraphMedium;
	BstMonoParagraphSmall: typeof MonoParagraphSmall;
	BstMonoParagraphXSmall: typeof MonoParagraphXSmall;

	// Typography - HeadingLevel context
	BstHeadingLevel: typeof HeadingLevel;
}
