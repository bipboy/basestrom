import BasicDropdownWormhole from 'ember-basic-dropdown/components/basic-dropdown-wormhole';
import { pageTitle } from 'ember-page-title';
import { LayoutCell, LayoutGrid } from '../../src/components/layout-grid/index.gts';
import Link from '../../src/components/link/index.gts';
import { LabelXSmall } from '../../src/components/typography/index.gts';

const spanNav = [4, 2, 2] as const;
const spanMain = [4, 6, 10] as const;
const zeroes = [0, 0, 0] as const;
const cols = [4, 8, 12] as const;

<template>
  {{pageTitle "basestrom"}}
  <LayoutGrid
    @behavior="fluid"
    @gridMaxWidth={{1440}}
    @gridGutters={{zeroes}}
    @gridMargins={{zeroes}}
    @gridGaps={{zeroes}}
    @gridColumns={{cols}}
    as |ctx|
  >
    <LayoutCell @ctx={{ctx}} @span={{spanNav}}>
      <nav style="position:sticky;top:0;height:100vh;overflow-y:auto;padding:16px;border-right:1px solid #e8e8e8;background:#f9f9f9">
        <LabelXSmall style="margin:0 0 16px;text-transform:uppercase;color:#727272">Components</LabelXSmall>
        <ul style="list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:4px">
          <li style="padding:4px 8px"><Link @route="block">Block</Link></li>
          <li style="padding:4px 8px"><Link @route="typography">Typography</Link></li>
          <li style="padding:4px 8px"><Link @route="divider">Divider</Link></li>
          <li style="padding:4px 8px"><Link @route="skeleton">Skeleton</Link></li>
          <li style="padding:4px 8px"><Link @route="aspect-ratio-box">AspectRatioBox</Link></li>
          <li style="padding:4px 8px"><Link @route="layout-grid">LayoutGrid</Link></li>
          <li style="padding:4px 8px"><Link @route="grid">Grid (simple)</Link></li>
          <li style="padding:4px 8px"><Link @route="flex-grid">FlexGrid</Link></li>
          <li style="padding:4px 8px"><Link @route="link">Link</Link></li>
          <li style="padding:4px 8px"><Link @route="checkbox">Checkbox</Link></li>
          <li style="padding:4px 8px"><Link @route="radio">Radio</Link></li>
          <li style="padding:4px 8px"><Link @route="switch">Switch</Link></li>
          <li style="padding:4px 8px"><Link @route="segmented-control">SegmentedControl</Link></li>
          <li style="padding:4px 8px"><Link @route="file-uploader">FileUploader</Link></li>
          <li style="padding:4px 8px"><Link @route="input">Input</Link></li>
          <li style="padding:4px 8px"><Link @route="textarea">Textarea</Link></li>
          <li style="padding:4px 8px"><Link @route="combobox">Combobox</Link></li>
          <li style="padding:4px 8px"><Link @route="select">Select</Link></li>
          <li style="padding:4px 8px"><Link @route="form-control">FormControl</Link></li>
          <li style="padding:4px 8px"><Link @route="slider">Slider</Link></li>
          <li style="padding:4px 8px"><Link @route="spinner">Spinner</Link></li>
          <li style="padding:4px 8px"><Link @route="icon">Icon</Link></li>
          <li style="padding:4px 8px"><Link @route="banner">Banner</Link></li>
          <li style="padding:4px 8px"><Link @route="system-banner">SystemBanner</Link></li>
          <li style="padding:4px 8px"><Link @route="snackbar">Snackbar</Link></li>
          <li style="padding:4px 8px"><Link @route="dialog">Dialog</Link></li>
          <li style="padding:4px 8px"><Link @route="drawer">Drawer</Link></li>
          <li style="padding:4px 8px"><Link @route="modal">Modal</Link></li>
          <li style="padding:4px 8px"><Link @route="popover">Popover</Link></li>
          <li style="padding:4px 8px"><Link @route="pagination">Pagination</Link></li>
          <li style="padding:4px 8px"><Link @route="card">Card</Link></li>
          <li style="padding:4px 8px"><Link @route="heading">Heading</Link></li>
          <li style="padding:4px 8px"><Link @route="button">Button</Link></li>
          <li style="padding:4px 8px"><Link @route="button-group">ButtonGroup</Link></li>
          <li style="padding:4px 8px"><Link @route="button-timed">ButtonTimed</Link></li>
          <li style="padding:4px 8px"><Link @route="button-dock">ButtonDock</Link></li>
          <li style="padding:4px 8px"><Link @route="sliding-button">SlidingButton</Link></li>
        </ul>
      </nav>
    </LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanMain}}>
      <main style="padding:32px;overflow-y:auto;min-height:100vh">
        {{outlet}}
      </main>
    </LayoutCell>
  </LayoutGrid>

  <BasicDropdownWormhole />
</template>
