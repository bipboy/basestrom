import Card from '../../src/components/card/index.gts';
import { HeadingXLarge, LabelMedium, ParagraphMedium, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <div style="margin-bottom:32px">
    <HeadingXLarge>basestrom</HeadingXLarge>
    <ParagraphMedium>Component library implementing the Base design language - Ember v2 addon with StyleX.</ParagraphMedium>
  </div>

  <div style="margin-bottom:24px">
    <LabelMedium>Getting Started</LabelMedium>
    <ParagraphSmall>Select a component from the sidebar to see it in action.</ParagraphSmall>
  </div>

  <div style="display:grid;grid-template-columns:1fr 1fr;gap:16px;max-width:600px">
    <Card @title="Layout">
      <:body>Block, Grid, FlexGrid, LayoutGrid, AspectRatioBox</:body>
    </Card>
    <Card @title="Inputs">
      <:body>Input, Textarea, Checkbox, Radio, Slider, Switch, SegmentedControl, FileUploader, FormControl, Combobox</:body>
    </Card>
    <Card @title="Actions">
      <:body>Button, ButtonGroup, ButtonTimed, ButtonDock, SlidingButton</:body>
    </Card>
    <Card @title="Feedback">
      <:body>Banner, SystemBanner, Snackbar, Spinner, Dialog, Modal, Drawer, Popover</:body>
    </Card>
    <Card @title="Content">
      <:body>Card, Typography, Heading, Link, Divider, Skeleton</:body>
    </Card>
    <Card @title="Iconography">
      <:body>Icon (base), Hide, Show, TrashCanFilled, Plus, Search</:body>
    </Card>
  </div>
</template>
