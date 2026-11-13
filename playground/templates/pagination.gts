import { on } from '@ember/modifier';
import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import Button from '../../src/components/button/index.gts';
import Pagination, { StatefulPagination } from '../../src/components/pagination/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class PaginationDemo extends Component {
  @tracked page1 = 3;
  @tracked page2 = 1;
  @tracked page3 = 50;

  handlePage1Change = (params: { nextPage: number; prevPage: number }) => {
    this.page1 = params.nextPage;
  };

  handlePage2Change = (params: { nextPage: number; prevPage: number }) => {
    this.page2 = params.nextPage;
  };

  handlePage3Change = (params: { nextPage: number; prevPage: number }) => {
    this.page3 = params.nextPage;
  };

  resetToFirst = () => { this.page2 = 1; };
  resetToLast = () => { this.page2 = 10; };

  <template>
    <HeadingXLarge>Pagination</HeadingXLarge>
    <ParagraphSmall>Navigation component for paged content. Prev/next buttons with a page dropdown selector.</ParagraphSmall>

    <HeadingMedium style="margin-top:24px">Basic Controlled</HeadingMedium>
    <ParagraphSmall style="margin-bottom:8px">10 pages, starting at page 3</ParagraphSmall>
    <Pagination
      @numPages={{10}}
      @currentPage={{this.page1}}
      @onPageChange={{this.handlePage1Change}}
    />

    <HeadingMedium style="margin-top:24px">Stateful (Uncontrolled)</HeadingMedium>
    <ParagraphSmall style="margin-bottom:8px">Manages its own state internally. Initial page = 1.</ParagraphSmall>
    <StatefulPagination @numPages={{20}} />

    <HeadingMedium style="margin-top:24px">Custom Labels</HeadingMedium>
    <ParagraphSmall style="margin-bottom:8px">Custom prev/next/preposition labels</ParagraphSmall>
    <Pagination
      @numPages={{10}}
      @currentPage={{this.page2}}
      @onPageChange={{this.handlePage2Change}}
      @labels={{this.customLabels}}
    />

    <HeadingMedium style="margin-top:24px">Sizes</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px;margin-top:8px">
      <div>
        <ParagraphSmall>xSmall</ParagraphSmall>
        <StatefulPagination @numPages={{5}} @size="xSmall" />
      </div>
      <div>
        <ParagraphSmall>small</ParagraphSmall>
        <StatefulPagination @numPages={{5}} @size="small" />
      </div>
      <div>
        <ParagraphSmall>medium (default)</ParagraphSmall>
        <StatefulPagination @numPages={{5}} @size="medium" />
      </div>
      <div>
        <ParagraphSmall>large</ParagraphSmall>
        <StatefulPagination @numPages={{5}} @size="large" />
      </div>
    </div>

    <HeadingMedium style="margin-top:24px">Many Pages (100)</HeadingMedium>
    <ParagraphSmall style="margin-bottom:8px">Dropdown with 100 page options</ParagraphSmall>
    <Pagination
      @numPages={{100}}
      @currentPage={{this.page3}}
      @onPageChange={{this.handlePage3Change}}
    />

    <HeadingMedium style="margin-top:24px">Disabled States</HeadingMedium>
    <div style="display:flex;flex-direction:column;gap:16px;margin-top:8px">
      <div>
        <ParagraphSmall>Page 1 of 10 - Prev disabled</ParagraphSmall>
        <Pagination
          @numPages={{10}}
          @currentPage={{this.page2}}
          @onPageChange={{this.handlePage2Change}}
        />
        <div style="margin-top:8px;display:flex;gap:8px">
          <Button @kind="secondary" @size="small" {{on "click" this.resetToFirst}}>Go to first</Button>
          <Button @kind="secondary" @size="small" {{on "click" this.resetToLast}}>Go to last</Button>
        </div>
      </div>
    </div>
  </template>

  get customLabels() {
    return { prevButton: '← Back', nextButton: 'Forward →', preposition: '/' };
  }
}

export default PaginationDemo;
