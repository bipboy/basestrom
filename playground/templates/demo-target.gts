/**
 * Sample target route used by Button @route demos. Has no UI - only proves
 * that the routing wiring works: when a Button is clicked, the URL changes
 * to /demo-target.
 */
import { LinkTo } from '@ember/routing';
import { HeadingMedium, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingMedium>Demo target</HeadingMedium>
  <ParagraphSmall>You arrived via a Bst::Button @route navigation.</ParagraphSmall>
  <ParagraphSmall><LinkTo @route="button">← Back to Button</LinkTo></ParagraphSmall>
</template>
