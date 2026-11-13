/**
 * Two-segment dynamic route. URL: /demo/:org/:invoice
 * Used by Button @route + @models demos.
 */
import { LinkTo } from '@ember/routing';
import { HeadingMedium, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingMedium>Demo pair</HeadingMedium>
  <ParagraphSmall>Two dynamic segments via @models.</ParagraphSmall>
  <ParagraphSmall>Check the URL: it should be /demo/&lt;org&gt;/&lt;invoice&gt;.</ParagraphSmall>
  <ParagraphSmall><LinkTo @route="button">← Back to Button</LinkTo></ParagraphSmall>
</template>
