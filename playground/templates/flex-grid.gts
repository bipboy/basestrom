import { FlexGrid, FlexGridItem } from '../../src/components/flex-grid/index.gts';
import { HeadingSmall, HeadingXLarge, LabelSmall, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>FlexGrid</HeadingXLarge>
  <ParagraphSmall>Equal-width flex layout with proper CSS calc-based column widths. Uses column-gap on the container and calc((100% - (n-1) * gap) / n) per item.</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">3 columns, 16px gap</HeadingSmall>
  <FlexGrid @columnCount={{3}} @columnGap="16px" @rowGap="16px" as |grid|>
    <FlexGridItem @grid={{grid}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>1</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>2</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EFF4FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>3</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>4</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>5</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#DEE9FE;padding:16px;text-align:center;border-radius:4px"><LabelSmall>6</LabelSmall></div></FlexGridItem>
  </FlexGrid>

  <HeadingSmall style="margin-top:32px">4 columns, 8px gap</HeadingSmall>
  <FlexGrid @columnCount={{4}} @columnGap="8px" @rowGap="8px" as |grid|>
    <FlexGridItem @grid={{grid}}><div style="background:#D3EFDA;padding:12px;text-align:center;border-radius:4px"><LabelSmall>A</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#D3EFDA;padding:12px;text-align:center;border-radius:4px"><LabelSmall>B</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#D3EFDA;padding:12px;text-align:center;border-radius:4px"><LabelSmall>C</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#D3EFDA;padding:12px;text-align:center;border-radius:4px"><LabelSmall>D</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EAF6ED;padding:12px;text-align:center;border-radius:4px"><LabelSmall>E</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EAF6ED;padding:12px;text-align:center;border-radius:4px"><LabelSmall>F</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EAF6ED;padding:12px;text-align:center;border-radius:4px"><LabelSmall>G</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#EAF6ED;padding:12px;text-align:center;border-radius:4px"><LabelSmall>H</LabelSmall></div></FlexGridItem>
  </FlexGrid>

  <HeadingSmall style="margin-top:32px">2 columns, 24px gap</HeadingSmall>
  <FlexGrid @columnCount={{2}} @columnGap="24px" @rowGap="24px" as |grid|>
    <FlexGridItem @grid={{grid}}><div style="background:#FDF2DC;padding:24px;text-align:center;border-radius:4px"><LabelSmall>Left</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#FDF2DC;padding:24px;text-align:center;border-radius:4px"><LabelSmall>Right</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#FFE8C4;padding:24px;text-align:center;border-radius:4px"><LabelSmall>Bottom Left</LabelSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#FFE8C4;padding:24px;text-align:center;border-radius:4px"><LabelSmall>Bottom Right</LabelSmall></div></FlexGridItem>
  </FlexGrid>

  <HeadingSmall style="margin-top:32px">Single column (default)</HeadingSmall>
  <FlexGrid @columnCount={{1}} @rowGap="8px" as |grid|>
    <FlexGridItem @grid={{grid}}><div style="background:#F3F3F3;padding:12px;border-radius:4px"><ParagraphSmall>Full width row 1</ParagraphSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#F3F3F3;padding:12px;border-radius:4px"><ParagraphSmall>Full width row 2</ParagraphSmall></div></FlexGridItem>
    <FlexGridItem @grid={{grid}}><div style="background:#F3F3F3;padding:12px;border-radius:4px"><ParagraphSmall>Full width row 3</ParagraphSmall></div></FlexGridItem>
  </FlexGrid>
</template>
