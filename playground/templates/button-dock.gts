import ButtonDock from '../../src/components/button-dock/index.gts';
import Button from '../../src/components/button/index.gts';
import Divider from '../../src/components/divider/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>ButtonDock</HeadingXLarge>
  <ParagraphSmall>A responsive action button container that stacks vertically on narrow viewports and arranges horizontally when wider than 600px.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Primary Action Only</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Minimal usage with just a primary action button.</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:primaryAction>
        <Button @kind="primary">Submit</Button>
      </:primaryAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Primary + Dismissive</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Common pattern for confirm/cancel dialogs.</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:primaryAction>
        <Button @kind="primary">Confirm</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Cancel</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>With Secondary Actions</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Two secondary actions alongside primary and dismissive.</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:secondaryActions>
        <Button @kind="secondary">Save Draft</Button>
        <Button @kind="secondary">Preview</Button>
      </:secondaryActions>
      <:primaryAction>
        <Button @kind="primary">Publish</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Discard</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>With Top Accessory</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Content above the action buttons (e.g., helper text, progress indicator).</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:topAccessory>
        <ParagraphSmall style="margin:0;color:#666">Review your selections before continuing.</ParagraphSmall>
      </:topAccessory>
      <:primaryAction>
        <Button @kind="primary">Continue</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Go Back</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Full Example (all slots)</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">All four slots populated - top accessory, secondary actions, primary, and dismissive.</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:topAccessory>
        <div style="background:#f0f0f0;padding:8px 12px;border-radius:4px">
          <ParagraphXSmall style="margin:0">Step 3 of 4 - Payment Details</ParagraphXSmall>
        </div>
      </:topAccessory>
      <:secondaryActions>
        <Button @kind="secondary">Save & Exit</Button>
        <Button @kind="secondary">Reset Form</Button>
      </:secondaryActions>
      <:primaryAction>
        <Button @kind="primary">Pay Now</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Cancel Order</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Responsive Behavior</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Narrow container (stacked layout):</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:350px">
    <ButtonDock>
      <:secondaryActions>
        <Button @kind="secondary">Secondary</Button>
      </:secondaryActions>
      <:primaryAction>
        <Button @kind="primary">Primary</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Dismiss</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <ParagraphXSmall style="margin-top:16px;margin-bottom:8px">Wide container (inline layout):</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:800px">
    <ButtonDock>
      <:secondaryActions>
        <Button @kind="secondary">Secondary</Button>
      </:secondaryActions>
      <:primaryAction>
        <Button @kind="primary">Primary</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Dismiss</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Danger Actions</HeadingMedium>
  <ParagraphXSmall style="margin-bottom:8px">Using danger button kinds for destructive operations.</ParagraphXSmall>
  <div style="border:1px dashed #ccc;max-width:600px">
    <ButtonDock>
      <:topAccessory>
        <ParagraphSmall style="margin:0;color:#E11900">⚠️ This action cannot be undone.</ParagraphSmall>
      </:topAccessory>
      <:primaryAction>
        <Button @kind="dangerPrimary">Delete Account</Button>
      </:primaryAction>
      <:dismissiveAction>
        <Button @kind="tertiary">Keep Account</Button>
      </:dismissiveAction>
    </ButtonDock>
  </div>
</template>
