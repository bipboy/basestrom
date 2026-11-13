import EmberRouter from '@ember/routing/router';
import PageTitleService from 'ember-page-title/services/page-title';
import EmberApp from 'ember-strict-application-resolver';

// Import theme vars to ensure CSS custom properties are injected into :root
import '../src/themes/vars.stylex';

// ember-basic-dropdown positioning CSS (position:absolute + z-index for portaled
// content). Required for Popover/Combobox overlays to be visible and anchored.
import 'ember-basic-dropdown/vendor/ember-basic-dropdown.css';

class Router extends EmberRouter {
  location = 'history';
  rootURL = '/';
}

export class App extends EmberApp {
  modules = {
    './router': Router,
    './services/page-title': PageTitleService,
    ...import.meta.glob('./services/**/*', { eager: true }),
    ...import.meta.glob('./templates/**/*', { eager: true }),
  };
}

Router.map(function () {
  this.route('block');
  this.route('typography');
  this.route('divider');
  this.route('skeleton');
  this.route('aspect-ratio-box');
  this.route('grid');
  this.route('flex-grid');
  this.route('layout-grid');
  this.route('checkbox');
  this.route('radio');
  this.route('button');
  this.route('button-group');
  this.route('button-timed');
  this.route('button-dock');
  this.route('sliding-button');
  this.route('switch');
  this.route('segmented-control');
  this.route('file-uploader');
  this.route('link');
  this.route('input');
  this.route('textarea');
  this.route('slider');
  this.route('spinner');
  this.route('icon');
  this.route('form-control');
  this.route('banner');
  this.route('system-banner');
  this.route('snackbar');
  this.route('dialog');
  this.route('drawer');
  this.route('modal');
  this.route('card');
  this.route('heading');
  this.route('pagination');
  this.route('combobox');
  this.route('select');
  this.route('popover');
  // Sample target routes used by Button @route demo:
  this.route('demo-target');
  this.route('demo-detail', { path: '/demo/:id' });
  this.route('demo-pair', { path: '/demo/:org/:invoice' });
});
