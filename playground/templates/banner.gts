import Component from '@glimmer/component';
import Banner from '../../src/components/banner/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class BannerDemo extends Component {
  handleAction = () => { alert('Action clicked'); };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>Banner</HeadingXLarge>
      <ParagraphSmall>Informational banners with artwork, actions, and color schemes.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Low Hierarchy (default)</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="info" @title="Information" @message="A new software update is available for download." />
        <Banner @kind="positive" @title="Success" @message="Your changes have been saved successfully." />
        <Banner @kind="warning" @title="Warning" @message="Your session will expire in 5 minutes." />
        <Banner @kind="negative" @title="Error" @message="Unable to connect to the server." />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>High Hierarchy</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="info" @hierarchy="high" @title="Info" @message="System maintenance scheduled for tonight." />
        <Banner @kind="positive" @hierarchy="high" @title="Complete" @message="Deployment finished successfully." />
        <Banner @kind="warning" @hierarchy="high" @title="Caution" @message="Disk space is running low." />
        <Banner @kind="negative" @hierarchy="high" @title="Critical" @message="Database connection lost." />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Trailing Action</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="info" @title="Update" @message="Version 2.0 is available." @actionLabel="Install" @onActionClick={{this.handleAction}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Below Action</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="warning" @title="Attention" @message="Your plan will be downgraded next month." @actionLabel="Learn more" @actionPosition="below" @onActionClick={{this.handleAction}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Nested (smaller radius)</HeadingMedium>
      <div style="margin-top:16px;max-width:600px;background:#f7f7f7;padding:16px;border-radius:12px">
        <Banner @kind="positive" @nested={{true}} @message="Nested banner inside a card." />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Artwork</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="info" @title="New feature" @message="Check out the new dashboard features.">
          <:artwork>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>
          </:artwork>
        </Banner>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Default Block (no artwork)</HeadingMedium>
      <div style="margin-top:16px;max-width:600px">
        <Banner @kind="info" @title="Tip">
          You can use the default block for message content when there is no artwork.
        </Banner>
      </div>
    </div>
  </template>
}

export default BannerDemo;
