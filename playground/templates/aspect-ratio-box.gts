import AspectRatioBox from '../../src/components/aspect-ratio-box/index.gts';
import { HeadingSmall, HeadingXLarge, LabelMedium, ParagraphSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>AspectRatioBox</HeadingXLarge>
  <ParagraphSmall>Maintains a fixed aspect ratio for its content.</ParagraphSmall>

  <HeadingSmall style="margin-top:24px">16:9</HeadingSmall>
  <div style="max-width:400px">
    <AspectRatioBox @aspectRatio={{1.778}}>
      <div style="width:100%;height:100%;background:#276EF1;display:flex;align-items:center;justify-content:center;color:white">
        <LabelMedium style="color:white">16:9</LabelMedium>
      </div>
    </AspectRatioBox>
  </div>

  <HeadingSmall style="margin-top:32px">1:1 (square)</HeadingSmall>
  <div style="max-width:200px">
    <AspectRatioBox @aspectRatio={{1}}>
      <div style="width:100%;height:100%;background:#0E8345;display:flex;align-items:center;justify-content:center;color:white">
        <LabelMedium style="color:white">1:1</LabelMedium>
      </div>
    </AspectRatioBox>
  </div>

  <HeadingSmall style="margin-top:32px">4:3</HeadingSmall>
  <div style="max-width:300px">
    <AspectRatioBox @aspectRatio={{1.333}}>
      <div style="width:100%;height:100%;background:#DE1135;display:flex;align-items:center;justify-content:center;color:white">
        <LabelMedium style="color:white">4:3</LabelMedium>
      </div>
    </AspectRatioBox>
  </div>
</template>
