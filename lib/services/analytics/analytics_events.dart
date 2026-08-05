/// Canonical PostHog event names.
///
/// Event names are snake_case (PostHog convention) and live here so the same
/// string is never typed twice — renaming an event in code without renaming it
/// in PostHog silently splits a funnel in two.
class AnalyticsEvents {
  AnalyticsEvents._();

  /// A section scrolled into view for the first time this page load. The single
  /// most useful signal for "how far down does anyone actually get".
  static const String sectionViewed = 'section_viewed';

  /// A scroll-to-section navigation was triggered (header, burger menu, hero
  /// CTA, logo or keyboard).
  static const String navClicked = 'nav_clicked';

  /// A `/works/<slug>` case study was opened from the home page.
  static const String caseStudyOpened = 'case_study_opened';

  /// Any link that leaves the site (live demo, store listing, social, mailto).
  static const String outboundLinkClicked = 'outbound_link_clicked';

  /// The visitor typed into the contact form for the first time.
  static const String contactFormStarted = 'contact_form_started';

  /// The contact form was submitted — see [AnalyticsProps.success].
  static const String contactFormSubmitted = 'contact_form_submitted';

  /// One of the j/k/1-6/? keyboard shortcuts was used.
  static const String keyboardShortcutUsed = 'keyboard_shortcut_used';

  /// The mobile burger menu was opened.
  static const String mobileMenuOpened = 'mobile_menu_opened';
}

/// Canonical property keys for [AnalyticsEvents].
class AnalyticsProps {
  AnalyticsProps._();

  static const String section = 'section';
  static const String source = 'source';
  static const String slug = 'slug';
  static const String title = 'title';
  static const String label = 'label';
  static const String placement = 'placement';
  static const String url = 'url';
  static const String host = 'host';
  static const String scheme = 'scheme';
  static const String success = 'success';
  static const String shortcut = 'shortcut';
}

/// Where in the UI an interaction happened — the `placement` / `source`
/// property values. Breaking clicks down by placement is what tells you whether
/// the social rail, the footer or the contact card is actually doing the work.
class AnalyticsPlacements {
  AnalyticsPlacements._();

  static const String header = 'header';
  static const String mobileMenu = 'mobile_menu';
  static const String logo = 'logo';
  static const String heroCta = 'hero_cta';
  static const String keyboard = 'keyboard';
  static const String socialRail = 'social_rail';
  static const String footer = 'footer';
  static const String contactCard = 'contact_card';
  static const String projectCard = 'project_card';
  static const String featuredImage = 'featured_image';
  static const String featuredButton = 'featured_button';
  static const String caseStudy = 'case_study';
}

/// `label` values for [AnalyticsEvents.outboundLinkClicked] on project links.
class AnalyticsLinkLabels {
  AnalyticsLinkLabels._();

  static const String live = 'live';
  static const String appStore = 'app_store';
  static const String playStore = 'play_store';
  static const String email = 'email';
}
