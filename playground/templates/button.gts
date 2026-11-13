import { hash } from '@ember/helper';
import Button from '../../src/components/button/index.gts';
import Divider from '../../src/components/divider/index.gts';
import { Hide, Plus, Search, Show, TrashCanFilled } from '../../src/components/icon/glyphs.gts';
import {
    HeadingMedium,
    HeadingSmall,
    HeadingXLarge,
    ParagraphSmall,
} from '../../src/components/typography/index.gts';

const customPurple = { backgroundColor: '#944DE7', color: '#FFFFFF' };
const customGreen = { backgroundColor: '#06C167', color: '#FFFFFF' };

// Sample table data for the @route + @models section
const rows = [
  { id: 'usr-1', name: 'Ada Lovelace' },
  { id: 'usr-2', name: 'Alan Turing' },
  { id: 'usr-3', name: 'Grace Hopper' },
];

const invoiceParams = ['acme', 'INV-42'];

<template>
  <HeadingXLarge>Button</HeadingXLarge>
  <ParagraphSmall>Primary action component with multiple kinds, sizes, shapes, and states. Renders as <code>&lt;button&gt;</code>, <code>&lt;a&gt;</code>, or <code>&lt;LinkTo&gt;</code> depending on which arg is provided.</ParagraphSmall>

  <HeadingMedium style="margin-top:24px">Kinds</HeadingMedium>

  <HeadingSmall style="margin-top:16px">Primary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="primary">Default</Button>
    <Button @kind="primary" @isSelected={{true}}>Selected</Button>
    <Button @kind="primary" @isLoading={{true}}>Loading</Button>
    <Button @kind="primary" @disabled={{true}}>Disabled</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Secondary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="secondary">Default</Button>
    <Button @kind="secondary" @isSelected={{true}}>Selected</Button>
    <Button @kind="secondary" @isLoading={{true}}>Loading</Button>
    <Button @kind="secondary" @disabled={{true}}>Disabled</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Tertiary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="tertiary">Default</Button>
    <Button @kind="tertiary" @isSelected={{true}}>Selected</Button>
    <Button @kind="tertiary" @isLoading={{true}}>Loading</Button>
    <Button @kind="tertiary" @disabled={{true}}>Disabled</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Danger Primary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="dangerPrimary">Default</Button>
    <Button @kind="dangerPrimary" @isLoading={{true}}>Loading</Button>
    <Button @kind="dangerPrimary" @disabled={{true}}>Disabled</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Danger Secondary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="dangerSecondary">Default</Button>
    <Button @kind="dangerSecondary" @isLoading={{true}}>Loading</Button>
    <Button @kind="dangerSecondary" @disabled={{true}}>Disabled</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Danger Tertiary</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="dangerTertiary">Default</Button>
    <Button @kind="dangerTertiary" @isLoading={{true}}>Loading</Button>
    <Button @kind="dangerTertiary" @disabled={{true}}>Disabled</Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Sizes</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @size="xSmall">XSmall</Button>
    <Button @size="small">Small</Button>
    <Button @size="medium">Medium</Button>
    <Button @size="large">Large</Button>
  </div>

  <HeadingSmall style="margin-top:16px">Loading at every size (Spinner)</HeadingSmall>
  <ParagraphSmall>Loading state now uses the new <code>&lt;Bst::Spinner&gt;</code> component under the hood.</ParagraphSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center;margin-top:8px">
    <Button @size="xSmall" @isLoading={{true}}>XSmall</Button>
    <Button @size="small" @isLoading={{true}}>Small</Button>
    <Button @size="medium" @isLoading={{true}}>Medium</Button>
    <Button @size="large" @isLoading={{true}}>Large</Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Shapes</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @shape="default">Default</Button>
    <Button @shape="pill">Pill Shape</Button>
    <Button @shape="circle"><Plus @size="20px" /></Button>
    <Button @shape="square"><TrashCanFilled @size="20px" /></Button>
  </div>

  <HeadingSmall style="margin-top:16px">Icon shapes × Sizes</HeadingSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @shape="circle" @size="xSmall"><Plus @size="14px" /></Button>
    <Button @shape="circle" @size="small"><Plus @size="16px" /></Button>
    <Button @shape="circle" @size="medium"><Plus @size="20px" /></Button>
    <Button @shape="circle" @size="large"><Plus @size="24px" /></Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Full Width</HeadingMedium>
  <div style="max-width:400px;display:flex;flex-direction:column;gap:8px">
    <Button @fullWidth={{true}}>Full Width Primary</Button>
    <Button @fullWidth={{true}} @kind="secondary">Full Width Secondary</Button>
    <Button @fullWidth={{true}} @kind="tertiary">Full Width Tertiary</Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Enhancers (named blocks + icons)</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="primary">
      <:startEnhancer><Search @size="16px" /></:startEnhancer>
      <:default>Search</:default>
    </Button>
    <Button @kind="secondary">
      <:default>Hide</:default>
      <:endEnhancer><Hide @size="16px" /></:endEnhancer>
    </Button>
    <Button @kind="tertiary">
      <:startEnhancer><Show @size="16px" /></:startEnhancer>
      <:default>Show details</:default>
      <:endEnhancer><Plus @size="16px" /></:endEnhancer>
    </Button>
    <Button @kind="dangerPrimary">
      <:startEnhancer><TrashCanFilled @size="16px" /></:startEnhancer>
      <:default>Delete</:default>
    </Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>backgroundSafe (FAB)</HeadingMedium>
  <div style="background:linear-gradient(135deg,#276EF1,#06C167);padding:32px;border-radius:8px;display:flex;gap:12px;align-items:center">
    <Button @backgroundSafe={{true}}>Safe on any bg</Button>
    <Button @backgroundSafe={{true}} @shape="circle"><Plus @size="20px" /></Button>
    <Button @backgroundSafe={{true}} @kind="secondary">Secondary Safe</Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Link button (@href)</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @href="https://example.com" @target="_blank">External Primary</Button>
    <Button @href="https://example.com" @kind="secondary">External Secondary</Button>
    <Button @href="https://example.com" @disabled={{true}}>Disabled Link</Button>
  </div>

  <HeadingMedium style="margin-top:16px">Router button (@route)</HeadingMedium>
  <ParagraphSmall>When <code>@route</code> is provided, Button renders via <code>&lt;LinkTo&gt;</code> and supports <code>@model</code>, <code>@models</code>, and <code>@query</code> just like the link primitive.</ParagraphSmall>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center;margin-top:8px">
    <Button @route="demo-target">Go to demo target</Button>
    <Button @route="demo-detail" @model="42" @kind="secondary">Detail (single @model)</Button>
    <Button @route="demo-pair" @models={{invoiceParams}} @kind="tertiary">Open invoice (@models)</Button>
    <Button @route="button" @query={{hash q="ember"}} @kind="tertiary">With @query</Button>
  </div>

  <HeadingMedium style="margin-top:16px">Tables / lists (@route + @models)</HeadingMedium>
  <ParagraphSmall>Typical pattern: render a button per row, each pointing at the same route with a different model.</ParagraphSmall>
  <table style="border-collapse:collapse;margin-top:8px;min-width:360px">
    <thead>
      <tr>
        <th style="text-align:left;padding:8px;border-bottom:1px solid #e8e8e8">Name</th>
        <th style="text-align:left;padding:8px;border-bottom:1px solid #e8e8e8">Action</th>
      </tr>
    </thead>
    <tbody>
      {{#each rows as |row|}}
        <tr>
          <td style="padding:8px;border-bottom:1px solid #f3f3f3">{{row.name}}</td>
          <td style="padding:8px;border-bottom:1px solid #f3f3f3">
            <Button @size="small" @kind="tertiary" @route="demo-detail" @model={{row.id}}>
              Open
            </Button>
          </td>
        </tr>
      {{/each}}
    </tbody>
  </table>

  <Divider @size="section" />

  <HeadingMedium>Custom Colors</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @colors={{customPurple}}>Purple Custom</Button>
    <Button @colors={{customGreen}}>Green Custom</Button>
  </div>

  <Divider @size="section" />

  <HeadingMedium>Combinations</HeadingMedium>
  <div style="display:flex;gap:12px;flex-wrap:wrap;align-items:center">
    <Button @kind="primary" @shape="pill" @size="large">
      <:startEnhancer><Plus @size="20px" /></:startEnhancer>
      <:default>Launch</:default>
    </Button>
    <Button @kind="dangerPrimary" @shape="pill">
      <:startEnhancer><TrashCanFilled @size="16px" /></:startEnhancer>
      <:default>Delete</:default>
    </Button>
    <Button @kind="secondary" @shape="pill" @size="small">
      <:default>Cancel</:default>
    </Button>
  </div>
</template>
