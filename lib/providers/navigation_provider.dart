import 'package:flutter/material.dart';

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
    notifyListeners();
  }

  void setActive(PortfolioSection section) {
    if (_active == section) return;
    _active = section;
    notifyListeners();
  }

  GlobalKey keyFor(PortfolioSection section) => sectionKeys[section]!;

  Future<void> scrollTo(PortfolioSection section) async {
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
