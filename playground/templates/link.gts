import Link from '../../src/components/link/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall, ParagraphXSmall } from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>Link</HeadingXLarge>
  <ParagraphSmall>Styled anchor with animated underline, focus-visible, and Ember router integration.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Basic</HeadingMedium>
  <div style="display:flex;flex-direction:column;gap:8px">
    <Link @href="https://example.com">Default link</Link>
    <Link @href="https://example.com" @target="_blank">Opens in new tab (auto rel="noopener noreferrer")</Link>
  </div>

  <HeadingMedium style="margin-top:24px">Animated Underline</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Hover to see the underline animate in from left to right.</ParagraphXSmall>
  <div style="display:flex;flex-direction:column;gap:8px">
    <Link @href="https://example.com" @animateUnderline={{true}}>Animated underline link</Link>
    <Link @href="https://example.com" @animateUnderline={{true}}>Another animated link</Link>
  </div>

  <HeadingMedium style="margin-top:24px">Ember Route Links</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Uses Ember's LinkTo under the hood for client-side navigation.</ParagraphXSmall>
  <div style="display:flex;flex-direction:column;gap:8px">
    <Link @route="typography">Go to Typography page</Link>
    <Link @route="button" @animateUnderline={{true}}>Go to Button page (animated)</Link>
    <Link @route="checkbox">Go to Checkbox page</Link>
  </div>

  <HeadingMedium style="margin-top:24px">Disabled</HeadingMedium>
  <div style="display:flex;flex-direction:column;gap:8px">
    <Link @href="https://example.com" @disabled={{true}}>Disabled external link</Link>
    <Link @route="button" @disabled={{true}}>Disabled route link</Link>
  </div>

  <HeadingMedium style="margin-top:24px">In Context</HeadingMedium>
  <ParagraphSmall>
    This is a paragraph with an <Link @href="https://example.com">inline link</Link> that inherits the surrounding font size and line height. You can also use <Link @href="https://example.com" @animateUnderline={{true}}>animated links</Link> inline.
  </ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Focus Visible</HeadingMedium>
  <ParagraphXSmall style="color:#727272;margin-bottom:8px">Tab to the links below to see the focus outline.</ParagraphXSmall>
  <div style="display:flex;gap:16px">
    <Link @href="https://example.com">Link 1</Link>
    <Link @href="https://example.com">Link 2</Link>
    <Link @href="https://example.com">Link 3</Link>
  </div>

  <HeadingMedium style="margin-top:24px">Sizes (inherits from parent)</HeadingMedium>
  <div style="font-size:12px;margin-bottom:8px"><Link @href="#">12px context</Link></div>
  <div style="font-size:16px;margin-bottom:8px"><Link @href="#">16px context</Link></div>
  <div style="font-size:24px;margin-bottom:8px"><Link @href="#">24px context</Link></div>
  <div style="font-size:32px"><Link @href="#">32px context</Link></div>
</template>
