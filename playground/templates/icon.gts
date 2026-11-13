import {
  Alert,
  ArrowDownLeft,
  ArrowUpLeft,
  ArrowUpRight,
  Check,
  ChevronRight,
  CloudLightning,
  Delete,
  DeleteAlt,
  Edit,
  Hide,
  Plus,
  Search,
  Show,
  TrashCanFilled,
  Upload
} from '../../src/components/icon/glyphs.gts';
import Icon from '../../src/components/icon/index.gts';
import {
  HeadingMedium,
  HeadingSmall,
  HeadingXLarge,
  ParagraphSmall,
} from '../../src/components/typography/index.gts';

<template>
  <HeadingXLarge>Icon</HeadingXLarge>
  <ParagraphSmall>SVG glyphs that inherit text color via <code>currentColor</code>. Pass <code>@size</code> as any CSS length and <code>@color</code> as any CSS color. Decorative by default; pass <code>@title</code> to expose to assistive tech.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Glyphs</HeadingMedium>
  <div style="display:grid;grid-template-columns:repeat(auto-fill,minmax(96px,1fr));gap:16px;margin-top:8px">
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Hide @size="24px" />
      <ParagraphSmall>Hide</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Show @size="24px" />
      <ParagraphSmall>Show</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <TrashCanFilled @size="24px" />
      <ParagraphSmall>TrashCanFilled</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Plus @size="24px" />
      <ParagraphSmall>Plus</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Search @size="24px" />
      <ParagraphSmall>Search</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Alert @size="24px" />
      <ParagraphSmall>Alert</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Check @size="24px" />
      <ParagraphSmall>Check</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Delete @size="24px" />
      <ParagraphSmall>Delete</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <DeleteAlt @size="24px" />
      <ParagraphSmall>DeleteAlt</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <ChevronRight @size="24px" />
      <ParagraphSmall>ChevronRight</ParagraphSmall>
    </div>
    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Upload @size="24px" />
      <ParagraphSmall>Upload</ParagraphSmall>
    </div>

    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <Edit @size="24px" />
      <ParagraphSmall>Edit</ParagraphSmall>
    </div>

    <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <CloudLightning @size="24px" />
      <ParagraphSmall>CloudLightning</ParagraphSmall>
    </div>

        <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <ArrowDownLeft @size="24px" />
      <ParagraphSmall>ArrowDownLeft</ParagraphSmall>
    </div>

        <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <ArrowUpLeft @size="24px" />
      <ParagraphSmall>ArrowUpLeft</ParagraphSmall>
    </div>

        <div style="display:flex;flex-direction:column;align-items:center;gap:6px;padding:16px;border:1px solid #f3f3f3;border-radius:8px">
      <ArrowUpRight @size="24px" />
      <ParagraphSmall>ArrowUpRight</ParagraphSmall>
    </div>
  </div>

  <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
  <div style="display:flex;gap:16px;align-items:center;flex-wrap:wrap">
    <Plus @size="12px" />
    <Plus @size="16px" />
    <Plus @size="20px" />
    <Plus @size="24px" />
    <Plus @size="32px" />
    <Plus @size="48px" />
  </div>

  <HeadingMedium style="margin-top:24px">Colors</HeadingMedium>
  <ParagraphSmall>By default the icon inherits <code>currentColor</code>. Wrap it in any element with a <code>color</code> rule, or pass <code>@color</code> directly.</ParagraphSmall>
  <div style="display:flex;gap:16px;align-items:center;flex-wrap:wrap;margin-top:8px">
    <span style="color:#DE1135"><TrashCanFilled @size="24px" /></span>
    <span style="color:#276EF1"><Hide @size="24px" /></span>
    <span style="color:#0E8345"><Show @size="24px" /></span>
    <TrashCanFilled @size="24px" @color="#9F6402" />
    <Plus @size="24px" @color="#944DE7" />
  </div>

  <HeadingMedium style="margin-top:24px">Inside a Button enhancer</HeadingMedium>
  <ParagraphSmall>Icons compose naturally with Button start/end enhancers, inheriting the button's text color.</ParagraphSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center;margin-top:8px">
    {{!-- Inline use; see Button page for full demo --}}
  </div>

  <HeadingMedium style="margin-top:24px">Custom path via base Icon</HeadingMedium>
  <ParagraphSmall>The base <code>&lt;Bst::Icon&gt;</code> wraps any <code>&lt;path&gt;</code>. Useful for one-off glyphs.</ParagraphSmall>
  <div style="margin-top:8px">
    <Icon @size="32px" @title="Heart">
      <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z" />
    </Icon>
  </div>

  <HeadingSmall style="margin-top:24px">Accessibility</HeadingSmall>
  <ParagraphSmall>Without <code>@title</code> the icon is decorative: <code>role="presentation"</code>, <code>aria-hidden="true"</code>. With <code>@title</code> it becomes <code>role="img"</code> with both <code>&lt;title&gt;</code> and <code>aria-label</code>. <code>focusable="false"</code> is always set to keep IE/old browsers from focusing the SVG.</ParagraphSmall>
</template>
