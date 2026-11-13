import Component from '@glimmer/component';
import Divider from '../../src/components/divider/index.gts';
import Heading from '../../src/components/heading/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class HeadingDemo extends Component {
  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Heading</HeadingXLarge>
      <ParagraphSmall>Context-aware heading component with 6 levels and styleLevel override.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>All Levels</HeadingMedium>
      <div style="margin-top:16px;display:flex;flex-direction:column;gap:8px">
        <Heading @level={{1}}>Heading Level 1 - 40px/700</Heading>
        <Heading @level={{2}}>Heading Level 2 - 36px/700</Heading>
        <Heading @level={{3}}>Heading Level 3 - 32px/700</Heading>
        <Heading @level={{4}}>Heading Level 4 - 28px/700</Heading>
        <Heading @level={{5}}>Heading Level 5 - 24px/700</Heading>
        <Heading @level={{6}}>Heading Level 6 - 20px/700</Heading>
      </div>
    </div>

    <Divider />

    <div style="margin-top:32px;margin-bottom:32px">
      <HeadingMedium>Style Level Override</HeadingMedium>
      <ParagraphSmall>Semantic level and visual style can differ.</ParagraphSmall>
      <div style="margin-top:16px;display:flex;flex-direction:column;gap:8px">
        <Heading @level={{3}} @styleLevel={{1}}>h3 element, styled as level 1 (40px)</Heading>
        <Heading @level={{4}} @styleLevel={{2}}>h4 element, styled as level 2 (36px)</Heading>
        <Heading @level={{2}} @styleLevel={{5}}>h2 element, styled as level 5 (24px)</Heading>
      </div>
    </div>
  </template>
}

export default HeadingDemo;
