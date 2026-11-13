import Divider from '../../src/components/divider/index.gts';
import { HeadingSmall, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>Divider</HeadingXLarge>
  <ParagraphSmall>A horizontal separator with size variants.</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">Cell (default)</HeadingSmall>
  <ParagraphSmall>Content above</ParagraphSmall>
  <Divider />
  <ParagraphSmall>Content below</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">Section</HeadingSmall>
  <ParagraphSmall>Content above</ParagraphSmall>
  <Divider @size="section" />
  <ParagraphSmall>Content below</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">Module</HeadingSmall>
  <ParagraphSmall>Content above</ParagraphSmall>
  <Divider @size="module" />
  <ParagraphSmall>Content below</ParagraphSmall>
</template>
