import { Cell, Grid } from '../../src/components/grid/index.gts';
import { HeadingMedium, HeadingXLarge, LabelSmall, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

const span4 = [4, 4, 4] as const;
const spanSidebar = [4, 2, 3] as const;
const spanContent = [4, 6, 9] as const;
const spanCenter = [4, 4, 6] as const;
const skipCenter = [0, 2, 3] as const;
const spanHalf = [4, 4, 6] as const;
const spanThird = [4, 4, 4] as const;
const orderFirst = [0, 0, 2] as const;
const orderSecond = [0, 0, 1] as const;
const orderThird = [0, 0, 0] as const;
const spanFull = [4, 8, 12] as const;
const spanSidebarComplex = [4, 2, 3] as const;
const spanMain = [4, 4, 6] as const;
const spanAside = [4, 2, 3] as const;

<template>
  <HeadingXLarge>Grid</HeadingXLarge>
  <ParagraphSmall>Responsive 4/8/12 column layout grid. Resize the browser to see breakpoints at 600px and 1136px.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Equal Columns</HeadingMedium>
  <Grid>
    <Cell @span={{span4}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>4/12</LabelSmall></div></Cell>
    <Cell @span={{span4}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>4/12</LabelSmall></div></Cell>
    <Cell @span={{span4}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>4/12</LabelSmall></div></Cell>
  </Grid>

  <HeadingMedium style="margin-top:32px">Sidebar + Content</HeadingMedium>
  <Grid>
    <Cell @span={{spanSidebar}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Sidebar (4/2/3)</LabelSmall></div></Cell>
    <Cell @span={{spanContent}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Content (4/6/9)</LabelSmall></div></Cell>
  </Grid>

  <HeadingMedium style="margin-top:32px">With Offset (skip)</HeadingMedium>
  <Grid>
    <Cell @span={{spanCenter}} @skip={{skipCenter}}><div style="background:#FDF2DC;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Centered (skip 0/2/3, span 4/4/6)</LabelSmall></div></Cell>
  </Grid>

  <HeadingMedium style="margin-top:32px">Behavior: Fixed</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Grid container is centered with max-width 800px.</ParagraphXSmall>
  <div style="background:#f9f9f9;padding:16px 0;border:1px dashed #ccc">
    <Grid @behavior="fixed" @maxWidth={{800}}>
      <Cell @span={{spanHalf}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Left</LabelSmall></div></Cell>
      <Cell @span={{spanHalf}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Right</LabelSmall></div></Cell>
    </Grid>
  </div>

  <HeadingMedium style="margin-top:32px">Cell Order</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">On large screens, items reorder: C first, B second, A third.</ParagraphXSmall>
  <Grid>
    <Cell @span={{spanThird}} @order={{orderFirst}}><div style="background:#FFE8C4;padding:16px;text-align:center;border-radius:4px"><LabelSmall>A (order 0/0/2)</LabelSmall></div></Cell>
    <Cell @span={{spanThird}} @order={{orderSecond}}><div style="background:#FDF2DC;padding:16px;text-align:center;border-radius:4px"><LabelSmall>B (order 0/0/1)</LabelSmall></div></Cell>
    <Cell @span={{spanThird}} @order={{orderThird}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px"><LabelSmall>C (order 0/0/0)</LabelSmall></div></Cell>
  </Grid>

  <HeadingMedium style="margin-top:32px">Alignment</HeadingMedium>
  <Grid @align="center">
    <Cell @span={{spanThird}}><div style="background:#EFF4FE;padding:32px 16px;text-align:center;border-radius:4px"><LabelSmall>Tall</LabelSmall></div></Cell>
    <Cell @span={{spanThird}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>Short</LabelSmall></div></Cell>
    <Cell @span={{spanThird}}><div style="background:#EFF4FE;padding:48px 16px;text-align:center;border-radius:4px"><LabelSmall>Tallest</LabelSmall></div></Cell>
  </Grid>
  <ParagraphXSmall style="color:#727272;margin-top:4px">Grid align="center" - cells are vertically centered.</ParagraphXSmall>

  <HeadingMedium style="margin-top:32px">Complex Layout</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Header / sidebar / main / aside / footer.</ParagraphXSmall>
  <Grid>
    <Cell @span={{spanFull}}><div style="background:#276EF1;color:white;padding:16px;text-align:center;border-radius:4px"><LabelSmall style="color:white">Header</LabelSmall></div></Cell>
    <Cell @span={{spanSidebarComplex}}><div style="background:#D3EFDA;padding:16px;text-align:center;border-radius:4px;min-height:80px"><LabelSmall>Sidebar</LabelSmall></div></Cell>
    <Cell @span={{spanMain}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px;min-height:80px"><LabelSmall>Main</LabelSmall></div></Cell>
    <Cell @span={{spanAside}}><div style="background:#FDF2DC;padding:16px;text-align:center;border-radius:4px;min-height:80px"><LabelSmall>Aside</LabelSmall></div></Cell>
    <Cell @span={{spanFull}}><div style="background:#4B4B4B;color:white;padding:16px;text-align:center;border-radius:4px"><LabelSmall style="color:white">Footer</LabelSmall></div></Cell>
  </Grid>
</template>
