import {
  DisplayLarge,
  DisplayMedium,
  DisplaySmall,
  DisplayXSmall,
  HeadingLarge,
  HeadingLevel,
  HeadingMedium,
  HeadingSmall,
  HeadingXLarge,
  HeadingXSmall,
  HeadingXXLarge,
  LabelLarge,
  LabelMedium,
  LabelSmall,
  LabelXSmall,
  MonoDisplayLarge,
  MonoDisplayMedium,
  MonoDisplaySmall,
  MonoDisplayXSmall,
  MonoHeadingLarge,
  MonoHeadingMedium,
  MonoHeadingSmall,
  MonoHeadingXLarge,
  MonoHeadingXSmall,
  MonoHeadingXXLarge,
  MonoLabelLarge,
  MonoLabelMedium,
  MonoLabelSmall,
  MonoLabelXSmall,
  MonoParagraphLarge,
  MonoParagraphMedium,
  MonoParagraphSmall,
  MonoParagraphXSmall,
  ParagraphLarge,
  ParagraphMedium,
  ParagraphSmall,
  ParagraphXSmall,
} from '../../src/components/typography/index.gts';

<template>
  <h1>Typography</h1>
  <p>Pre-styled text components mapped to the theme's typography scale. Includes standard and monospace variants.</p>

  <h2>Display</h2>
  <DisplayLarge>Display Large</DisplayLarge>
  <DisplayMedium>Display Medium</DisplayMedium>
  <DisplaySmall>Display Small</DisplaySmall>
  <DisplayXSmall>Display XSmall</DisplayXSmall>

  <hr style="margin:24px 0" />

  <h2>Heading</h2>
  <HeadingXXLarge>Heading XXLarge (h1)</HeadingXXLarge>
  <HeadingXLarge>Heading XLarge (h2)</HeadingXLarge>
  <HeadingLarge>Heading Large (h3)</HeadingLarge>
  <HeadingMedium>Heading Medium (h4)</HeadingMedium>
  <HeadingSmall>Heading Small (h5)</HeadingSmall>
  <HeadingXSmall>Heading XSmall (h6)</HeadingXSmall>

  <hr style="margin:24px 0" />

  <h2>Label</h2>
  <LabelLarge>Label Large</LabelLarge>
  <LabelMedium>Label Medium</LabelMedium>
  <LabelSmall>Label Small</LabelSmall>
  <LabelXSmall>Label XSmall</LabelXSmall>

  <hr style="margin:24px 0" />

  <h2>Paragraph</h2>
  <ParagraphLarge>Paragraph Large - 18px normal weight, 28px line height. Used for body text in larger contexts.</ParagraphLarge>
  <ParagraphMedium>Paragraph Medium - 16px normal weight, 24px line height. The default body text size.</ParagraphMedium>
  <ParagraphSmall>Paragraph Small - 14px normal weight, 20px line height. For secondary content.</ParagraphSmall>
  <ParagraphXSmall>Paragraph XSmall - 12px normal weight, 20px line height. For captions and fine print.</ParagraphXSmall>

  <hr style="margin:32px 0;border-top:3px solid #276EF1" />

  <h2>Mono Display</h2>
  <p style="color:#727272;margin-bottom:12px">Monospace font family - for code, data, and technical content.</p>
  <MonoDisplayLarge>Mono Display Large</MonoDisplayLarge>
  <MonoDisplayMedium>Mono Display Medium</MonoDisplayMedium>
  <MonoDisplaySmall>Mono Display Small</MonoDisplaySmall>
  <MonoDisplayXSmall>Mono Display XSmall</MonoDisplayXSmall>

  <hr style="margin:24px 0" />

  <h2>Mono Heading</h2>
  <MonoHeadingXXLarge>Mono Heading XXLarge (h1)</MonoHeadingXXLarge>
  <MonoHeadingXLarge>Mono Heading XLarge (h2)</MonoHeadingXLarge>
  <MonoHeadingLarge>Mono Heading Large (h3)</MonoHeadingLarge>
  <MonoHeadingMedium>Mono Heading Medium (h4)</MonoHeadingMedium>
  <MonoHeadingSmall>Mono Heading Small (h5)</MonoHeadingSmall>
  <MonoHeadingXSmall>Mono Heading XSmall (h6)</MonoHeadingXSmall>

  <hr style="margin:24px 0" />

  <h2>Mono Label</h2>
  <MonoLabelLarge>MonoLabelLarge - 18px 500</MonoLabelLarge>
  <MonoLabelMedium>MonoLabelMedium - 16px 500</MonoLabelMedium>
  <MonoLabelSmall>MonoLabelSmall - 14px 500</MonoLabelSmall>
  <MonoLabelXSmall>MonoLabelXSmall - 12px 500</MonoLabelXSmall>

  <hr style="margin:24px 0" />

  <h2>Mono Paragraph</h2>
  <MonoParagraphLarge>MonoParagraphLarge - monospace body text at 18px.</MonoParagraphLarge>
  <MonoParagraphMedium>MonoParagraphMedium - monospace body text at 16px.</MonoParagraphMedium>
  <MonoParagraphSmall>MonoParagraphSmall - monospace body text at 14px.</MonoParagraphSmall>
  <MonoParagraphXSmall>MonoParagraphXSmall - monospace body text at 12px.</MonoParagraphXSmall>

  <hr style="margin:32px 0;border-top:3px solid #0E8345" />

  <h2>HeadingLevel Context</h2>
  <p style="color:#727272;margin-bottom:12px">Automatic heading level nesting. Each nested <code>HeadingLevel</code> increments the semantic heading element (h1→h2→h3...).</p>

  <div style="border:1px solid #e8e8e8;padding:16px;border-radius:8px">
    <HeadingLevel as |H1 nextLevel|>
      <H1>Level 1 - renders as h1</H1>
      <ParagraphSmall>Content under the first heading.</ParagraphSmall>

      <HeadingLevel @level={{nextLevel}} as |H2 nextLevel2|>
        <H2>Level 2 - renders as h2</H2>
        <ParagraphSmall>Content under the second heading.</ParagraphSmall>

        <HeadingLevel @level={{nextLevel2}} as |H3 nextLevel3|>
          <H3>Level 3 - renders as h3</H3>
          <ParagraphSmall>Content under the third heading.</ParagraphSmall>

          <HeadingLevel @level={{nextLevel3}} as |H4 nextLevel4|>
            <H4>Level 4 - renders as h4</H4>
            <ParagraphSmall>Content under the fourth heading.</ParagraphSmall>

            <HeadingLevel @level={{nextLevel4}} as |H5 nextLevel5|>
              <H5>Level 5 - renders as h5</H5>

              <HeadingLevel @level={{nextLevel5}} as |H6 _|>
                <H6>Level 6 - renders as h6 (max)</H6>
              </HeadingLevel>
            </HeadingLevel>
          </HeadingLevel>
        </HeadingLevel>
      </HeadingLevel>
    </HeadingLevel>
  </div>
</template>
