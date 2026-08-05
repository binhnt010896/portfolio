import 'package:flutter/material.dart';
import 'package:portfolio/services/analytics/analytics.dart';

/// The anchored sections of the single-page portfolio.
enum PortfolioSection { home, projects, skills, about, testimonials, contacts }

extension PortfolioSectionLabel on PortfolioSection {
  String get label {
    switch (this) {
      case PortfolioSection.home:
        return 'home';
      case PortfolioSection.projects:
        return 'works';
      case PortfolioSection.skills:
        return 'skills';
      case PortfolioSection.about:
        return 'about-me';
      case PortfolioSection.testimonials:
        return 'testimonials';
      case PortfolioSection.contacts:
        return 'contacts';
    }
  }
}

/// Owns scroll-to-section behaviour and tracks which section is in view so the
/// header/nav can highlight the active link. (Provider state management.)
class NavigationProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  final Map<PortfolioSection, GlobalKey> sectionKeys = {
    for (final s in PortfolioSection.values) s: GlobalKey(),
  };

  PortfolioSection _active = PortfolioSection.home;
  PortfolioSection get active => _active;

  bool _mobileMenuOpen = false;
  bool get mobileMenuOpen => _mobileMenuOpen;

  void toggleMobileMenu([bool? open]) {
    _mobileMenuOpen = open ?? !_mobileMenuOpen;
    if (_mobileMenuOpen) {
      Analytics.capture(AnalyticsEvents.mobileMenuOpened);
    }
    notifyListeners();
  }

  void setActive(PortfolioSection section) {
    // Reported before the early return: on first paint the home section is
    // already `_active`, and it still counts as viewed.
    _reportViewed(section);
    if (_active == section) return;
    _active = section;
    notifyListeners();
  }

  /// Records the first time [section] comes into view this page load.
  void _reportViewed(PortfolioSection section) {
    Analytics.captureOnce(
      '${AnalyticsEvents.sectionViewed}:${section.name}',
      AnalyticsEvents.sectionViewed,
      {AnalyticsProps.section: section.label},
    );
  }

  GlobalKey keyFor(PortfolioSection section) => sectionKeys[section]!;

  /// Scrolls [section] into view. [source] records which control triggered it
  /// (see [AnalyticsPlacements]) so header, burger menu, hero CTA, logo and
  /// keyboard navigation can be told apart in PostHog.
  Future<void> scrollTo(PortfolioSection section, {String? source}) async {
    Analytics.capture(AnalyticsEvents.navClicked, {
      AnalyticsProps.section: section.label,
      if (source != null) AnalyticsProps.source: source,
    });
    _mobileMenuOpen = false;
    notifyListeners();
    final ctx = sectionKeys[section]!.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.0,
    );
    setActive(section);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
