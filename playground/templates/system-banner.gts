import Component from '@glimmer/component';
import { SystemBanner } from '../../src/components/system-banner/index.gts';
import { HeadingMedium, HeadingXLarge, ParagraphSmall } from '../../src/components/typography/index.gts';

class SystemBannerDemo extends Component {
  handlePrimary = () => { alert('Primary action'); };
  handleSecondary = () => { alert('Secondary action'); };

  <template>
    <div style="margin-bottom:32px">
      <HeadingXLarge>SystemBanner</HeadingXLarge>
      <ParagraphSmall>Full-bleed, high-hierarchy banners for system-level notifications.</ParagraphSmall>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Single Action (entire banner clickable)</HeadingMedium>
      <div style="margin-top:16px">
        <SystemBanner @kind="info" @title="Update available" @message="A new version of the app is ready." @primaryActionLabel="Learn more" @onPrimaryAction={{this.handlePrimary}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>Two Actions (message + trailing icon)</HeadingMedium>
      <div style="margin-top:16px">
        <SystemBanner @kind="negative" @title="Connection Error" @message="Unable to reach the server." @primaryActionLabel="Retry" @onPrimaryAction={{this.handlePrimary}} @secondaryActionLabel="Dismiss" @onSecondaryAction={{this.handleSecondary}}>
          <:secondaryIcon>
            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M19 6.41L17.59 5 12 10.59 6.41 5 5 6.41 10.59 12 5 17.59 6.41 19 12 13.41 17.59 19 19 17.59 13.41 12z"/></svg>
          </:secondaryIcon>
        </SystemBanner>
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>No Action (static)</HeadingMedium>
      <div style="margin-top:16px">
        <SystemBanner @kind="warning" @title="Scheduled maintenance tonight at 2:00 AM." />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>All Kinds</HeadingMedium>
      <div style="margin-top:16px;display:flex;flex-direction:column;gap:8px">
        <SystemBanner @kind="info" @message="Info: System update in progress." @primaryActionLabel="Details" @onPrimaryAction={{this.handlePrimary}} />
        <SystemBanner @kind="positive" @message="Positive: Deployment completed." @primaryActionLabel="View" @onPrimaryAction={{this.handlePrimary}} />
        <SystemBanner @kind="warning" @message="Warning: Disk space running low." @primaryActionLabel="Manage" @onPrimaryAction={{this.handlePrimary}} />
        <SystemBanner @kind="negative" @message="Negative: Service unavailable." @primaryActionLabel="Retry" @onPrimaryAction={{this.handlePrimary}} />
      </div>
    </div>

    <div style="margin-bottom:32px">
      <HeadingMedium>With Artwork</HeadingMedium>
      <div style="margin-top:16px">
        <SystemBanner @kind="positive" @title="Success" @message="Your changes have been deployed." @primaryActionLabel="View" @onPrimaryAction={{this.handlePrimary}}>
          <:artwork>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/></svg>
          </:artwork>
        </SystemBanner>
      </div>
    </div>
  </template>
}

export default SystemBannerDemo;
