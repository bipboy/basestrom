import Spinner from '../../src/components/spinner/index.gts';
import {
    HeadingMedium,
    HeadingSmall,
    HeadingXLarge,
    ParagraphSmall,
} from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>Spinner</HeadingXLarge>
  <ParagraphSmall>Circular loading indicator. Top arc uses theme accent; remaining arcs use a muted track. Three named sizes plus arbitrary box/border via inline style.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
  <div style="display:flex;gap:24px;align-items:center;flex-wrap:wrap">
    <div style="display:flex;flex-direction:column;align-items:center;gap:8px">
      <Spinner @size="small" />
      <ParagraphSmall>small</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:8px">
      <Spinner @size="medium" />
      <ParagraphSmall>medium (default)</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:8px">
      <Spinner @size="large" />
      <ParagraphSmall>large</ParagraphSmall>
    </div>
  </div>

  <HeadingMedium style="margin-top:24px">Custom dimensions</HeadingMedium>
  <ParagraphSmall>Pass <code>@boxSize</code> and <code>@borderWidth</code> for arbitrary sizing.</ParagraphSmall>
  <div style="display:flex;gap:24px;align-items:center;flex-wrap:wrap;margin-top:8px">
    <Spinner @boxSize="48px" @borderWidth="6px" />
    <Spinner @boxSize="64px" @borderWidth="8px" />
    <Spinner @boxSize="14px" @borderWidth="2px" />
  </div>

  <HeadingMedium style="margin-top:24px">Custom colors</HeadingMedium>
  <ParagraphSmall>Pass <code>@color</code> with any CSS color string.</ParagraphSmall>
  <div style="display:flex;gap:24px;align-items:center;flex-wrap:wrap;margin-top:8px">
    <Spinner @color="#DE1135" />
    <Spinner @color="#0E8345" />
    <Spinner @color="#F6BC2F" />
    <Spinner @color="#944DE7" />
  </div>

  <HeadingMedium style="margin-top:24px">In context: dark surface</HeadingMedium>
  <div style="background:#000;padding:24px;border-radius:8px;display:flex;gap:16px;align-items:center">
    <Spinner @color="#FFFFFF" @size="medium" />
    <Spinner @color="#FFFFFF" @size="large" />
  </div>

  <HeadingSmall style="margin-top:24px">Accessibility</HeadingSmall>
  <ParagraphSmall>Renders <code>role="progressbar"</code>, <code>aria-busy="true"</code>, and <code>aria-label="loading"</code> by default. Override the label via <code>aria-label="..."</code>.</ParagraphSmall>
</template>
