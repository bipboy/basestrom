import * as stylex from '@stylexjs/stylex';
import Block from '../../src/components/block/index.gts';
import { HeadingSmall, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';
import { colors, sizing } from '../../src/themes/vars.stylex';

const cardStyles = stylex.create({
  root: {
    backgroundColor: colors.backgroundSecondary,
    padding: sizing.scale600,
    borderRadius: '8px',
    marginBottom: sizing.scale600,
  },
});

const accentStyles = stylex.create({
  root: {
    backgroundColor: colors.backgroundAccent,
    color: colors.contentOnColor,
    padding: sizing.scale800,
    borderRadius: '12px',
    marginBottom: sizing.scale600,
  },
});

const flexStyles = stylex.create({
  root: {
    display: 'flex',
    gap: sizing.scale400,
    alignItems: 'center',
    padding: sizing.scale600,
    backgroundColor: colors.backgroundTertiary,
    borderRadius: '8px',
  },
});

<template>
  <HeadingXLarge>Block</HeadingXLarge>
  <ParagraphSmall>A utility layout primitive. Renders a div with StyleX overrides.</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">Card-like block</HeadingSmall>
  <Block @overrides={{cardStyles}}>
    <ParagraphSmall>This is a Block with card-like styling via overrides.</ParagraphSmall>
  </Block>

  <HeadingSmall style="margin-top:24px">Accent block</HeadingSmall>
  <Block @overrides={{accentStyles}}>
    <ParagraphSmall style="color:white">Block with accent background and white text.</ParagraphSmall>
  </Block>

  <HeadingSmall style="margin-top:24px">Flex layout block</HeadingSmall>
  <Block @overrides={{flexStyles}}>
    <ParagraphSmall>Item 1</ParagraphSmall>
    <ParagraphSmall>Item 2</ParagraphSmall>
    <ParagraphSmall>Item 3</ParagraphSmall>
  </Block>
</template>
