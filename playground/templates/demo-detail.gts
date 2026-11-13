/**
 * Single-segment dynamic route. URL: /demo/:id
 * Used by Button @route + @model demos. The URL itself proves the wiring;
 * we just render confirmation text here.
 */
import { LinkTo } from '@ember/routing';
import { HeadingMedium, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingMedium>Demo detail</HeadingMedium>
  <ParagraphSmall>Single dynamic segment via @model.</ParagraphSmall>
  <ParagraphSmall>Check the URL: it should be /demo/&lt;id&gt;.</ParagraphSmall>
  <ParagraphSmall><LinkTo @route="button">← Back to Button</LinkTo></ParagraphSmall>
</template>
