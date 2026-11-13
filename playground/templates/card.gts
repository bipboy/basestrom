import Component from '@glimmer/component';
import Card from '../../src/components/card/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class CardDemo extends Component {
  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Card</HeadingXLarge>
      <ParagraphSmall>Content container with header image, thumbnail, title, body, and action.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Basic Card</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Card @title="Card Title">
          <:body>This is the card body content. It can contain any text or elements.</:body>
        </Card>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Header Image</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Card @title="Mountain View" @headerImage="https://picsum.photos/400/200" @headerImageAlt="Mountain landscape">
          <:body>A beautiful mountain landscape captured at sunset.</:body>
        </Card>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Thumbnail</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Card @title="User Profile" @thumbnail="https://picsum.photos/96/96" @thumbnailAlt="User avatar">
          <:body>John Doe is a software engineer based in San Francisco. He enjoys hiking and photography.</:body>
        </Card>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Action</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Card @title="Subscription">
          <:body>Your trial ends in 3 days. Upgrade now to keep access.</:body>
          <:action>
            <button type="button" style="padding:8px 16px;border-radius:8px;border:none;background:#000;color:#fff;cursor:pointer;font-size:14px;font-weight:500">Upgrade</button>
          </:action>
        </Card>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Full Featured</HeadingMedium>
      <div style="margin-top:16px;max-width:400px">
        <Card @title="Product Card" @headerImage="https://picsum.photos/400/180" @headerImageAlt="Product">
          <:body>Premium wireless headphones with noise cancellation and 30-hour battery life.</:body>
          <:action>
            <button type="button" style="padding:8px 16px;border-radius:8px;border:none;background:#276EF1;color:#fff;cursor:pointer;font-size:14px;font-weight:500">Add to Cart</button>
          </:action>
        </Card>
      </div>
    </div>
  </template>
}

export default CardDemo;
