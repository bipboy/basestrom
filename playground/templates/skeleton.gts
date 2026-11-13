import Skeleton from '../../src/components/skeleton/index.gts';
import { HeadingSmall, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>Skeleton</HeadingXLarge>
  <ParagraphSmall>Loading placeholder with optional shimmer animation.</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">3 rows, no animation</HeadingSmall>
  <Skeleton @rows={{3}} />

  <HeadingSmall style="margin-top:32px">4 rows, animated</HeadingSmall>
  <Skeleton @rows={{4}} @animation={{true}} />

  <HeadingSmall style="margin-top:32px">Fixed size block</HeadingSmall>
  <Skeleton @rows={{0}} @height="120px" @width="300px" @animation={{true}} />
</template>
