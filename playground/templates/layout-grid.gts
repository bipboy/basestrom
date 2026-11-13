import { LayoutCell, LayoutGrid } from '../../src/components/layout-grid/index.gts';
import { HeadingMedium, HeadingXLarge, LabelSmall, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

const spanFull = [4, 8, 12] as const;
const spanHalf = [4, 4, 6] as const;
const spanThird = [4, 4, 4] as const;
const spanSidebar = [4, 2, 3] as const;
const spanContent = [4, 6, 9] as const;
const spanCenter = [4, 4, 6] as const;
const skipCenter = [0, 2, 3] as const;
const orderFirst = [2, 2, 1] as const;
const orderSecond = [1, 1, 2] as const;
const spanDesktopOnly = [0, 0, 3] as const;
const spanMobileExpand = [4, 8, 9] as const;
const customCols = [2, 4, 6] as const;
const customGutters = [8, 16, 24] as const;
const customMargins = [8, 16, 32] as const;
const customGaps = [16, 16, 16] as const;
const spanCustomA = [1, 2, 2] as const;
const spanCustomB = [1, 2, 2] as const;
const spanCustomC = [2, 4, 2] as const;
const spanCustomD = [2, 2, 3] as const;
const spanCustomE = [2, 2, 3] as const;

<template>
  <HeadingXLarge>LayoutGrid</HeadingXLarge>
  <ParagraphSmall>Full-featured responsive layout grid - a complete port of baseweb's layout-grid.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Basic - Equal Columns</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Three equal columns (4/4/4 on large = 12 total).</ParagraphXSmall>
  <LayoutGrid @gridStyle="compact" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>1/3</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>2/3</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>3/3</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">App Layout</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Header / Sidebar / Content / Footer. On mobile everything stacks.</ParagraphXSmall>
  <LayoutGrid @gridStyle="compact" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanFull}}><div style="background:#276EF1;color:white;padding:16px;text-align:center;border-radius:4px"><LabelSmall style="color:white">Header</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanSidebar}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px;min-height:120px"><LabelSmall>Sidebar</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanContent}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px;min-height:120px"><LabelSmall>Main Content</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanFull}}><div style="background:#4B4B4B;color:white;padding:16px;text-align:center;border-radius:4px"><LabelSmall style="color:white">Footer</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">Behavior: Fixed</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Grid centered with max-width 800px.</ParagraphXSmall>
  <div style="background:#f3f3f3;padding:16px 0;border:1px dashed #ccc">
    <LayoutGrid @behavior="fixed" @gridMaxWidth={{800}} @gridStyle="compact" as |ctx|>
      <LayoutCell @ctx={{ctx}} @span={{spanHalf}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Left</LabelSmall></div></LayoutCell>
      <LayoutCell @ctx={{ctx}} @span={{spanHalf}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Right</LabelSmall></div></LayoutCell>
    </LayoutGrid>
  </div>

  <HeadingMedium style="margin-top:32px">Offset (skip)</HeadingMedium>
  <LayoutGrid @gridStyle="compact" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanCenter}} @skip={{skipCenter}}><div style="background:#FDF2DC;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Centered (skip + span)</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">Responsive Order</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">On large screens "Desktop First" appears first. On mobile "Mobile First" appears first.</ParagraphXSmall>
  <LayoutGrid @gridStyle="compact" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanHalf}} @order={{orderFirst}}><div style="background:#FFE8C4;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Desktop First (order 2/2/1)</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanHalf}} @order={{orderSecond}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Mobile First (order 1/1/2)</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">Hide Cell (span=0)</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Sidebar hidden on mobile/tablet, visible on desktop only.</ParagraphXSmall>
  <LayoutGrid @gridStyle="compact" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanDesktopOnly}}><div style="background:#EAF6ED;padding:16px;text-align:center;border-radius:4px;min-height:80px"><LabelSmall>Desktop-only</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanMobileExpand}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px;min-height:80px"><LabelSmall>Main (full on mobile)</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">Custom Columns &amp; Gutters</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">6-column grid with 24px gutters and 16px row gaps.</ParagraphXSmall>
  <LayoutGrid @gridColumns={{customCols}} @gridGutters={{customGutters}} @gridMargins={{customMargins}} @gridGaps={{customGaps}} as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanCustomA}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>A</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanCustomB}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>B</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanCustomC}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px"><LabelSmall>C</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanCustomD}}><div style="background:#FDF2DC;padding:16px;text-align:center;border-radius:4px"><LabelSmall>D</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanCustomE}}><div style="background:#FFE8C4;padding:16px;text-align:center;border-radius:4px"><LabelSmall>E</LabelSmall></div></LayoutCell>
  </LayoutGrid>

  <HeadingMedium style="margin-top:32px">Vertical Alignment</HeadingMedium>
  <LayoutGrid @gridStyle="compact" @align="center" as |ctx|>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#EFF4FE;padding:32px 16px;text-align:center;border-radius:4px"><LabelSmall>Tall</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Short</LabelSmall></div></LayoutCell>
    <LayoutCell @ctx={{ctx}} @span={{spanThird}}><div style="background:#D3EFDA;padding:48px 16px;text-align:center;border-radius:4px"><LabelSmall>Tallest</LabelSmall></div></LayoutCell>
  </LayoutGrid>
  <ParagraphXSmall style="color:#727272;margin-top:4px">Grid align="center" - all cells vertically centered.</ParagraphXSmall>
</template>
