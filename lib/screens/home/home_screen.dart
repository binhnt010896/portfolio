import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/sections/about_section.dart';
import 'package:portfolio/screens/home/sections/contacts_section.dart';
import 'package:portfolio/screens/home/sections/hero_section.dart';
import 'package:portfolio/screens/home/sections/projects_section.dart';
import 'package:portfolio/screens/home/sections/quote_section.dart';
import 'package:portfolio/screens/home/sections/skills_section.dart';
import 'package:portfolio/screens/home/sections/testimonials_section.dart';
import 'package:portfolio/screens/home/widgets/app_header.dart';
import 'package:portfolio/screens/home/widgets/footer.dart';
import 'package:portfolio/screens/home/widgets/shortcuts_help_dialog.dart';
import 'package:portfolio/screens/home/widgets/social_rail.dart';
import 'package:portfolio/services/analytics/analytics.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// The single-page portfolio: a sticky header over a scrollable column of
/// anchored sections, with a fixed social rail on wide screens and
/// codedgar-style keyboard shortcuts (j/k scroll, 1–5 jump, ? for help).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  /// Minimum width at which the fixed left social rail is shown.
  static const double _railBreakpoint = 1320;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _shortcutsNode = FocusNode(debugLabel: 'page-shortcuts');

  /// Distance (logical px) a j/k keypress scrolls.
  static const double _keyScrollStep = 480;

  @override
  void dispose() {
    _shortcutsNode.dispose();
    super.dispose();
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    // Only react when nothing else (e.g. a contact-form field) owns focus.
    if (!node.hasPrimaryFocus) return KeyEventResult.ignored;
    if (event is KeyUpEvent) return KeyEventResult.ignored;

    final nav = context.read<NavigationProvider>();
    switch (event.character) {
      case 'j':
        _reportShortcut('j');
        _scrollBy(nav, _keyScrollStep);
        return KeyEventResult.handled;
      case 'k':
        _reportShortcut('k');
        _scrollBy(nav, -_keyScrollStep);
        return KeyEventResult.handled;
      case '?':
        _reportShortcut('?');
        ShortcutsHelpDialog.show(context);
        return KeyEventResult.handled;
      case '1':
      case '2':
      case '3':
      case '4':
      case '5':
      case '6':
        _reportShortcut(event.character!);
        final index = int.parse(event.character!) - 1;
        nav.scrollTo(
          PortfolioSection.values[index],
          source: AnalyticsPlacements.keyboard,
        );
        return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  /// Reports shortcut usage once per key per page load — enough to tell whether
  /// anyone discovers them, without a j-spam scroll drowning out every other
  /// event.
  void _reportShortcut(String shortcut) {
    Analytics.captureOnce(
      '${AnalyticsEvents.keyboardShortcutUsed}:$shortcut',
      AnalyticsEvents.keyboardShortcutUsed,
      {AnalyticsProps.shortcut: shortcut},
    );
  }

  void _scrollBy(NavigationProvider nav, double delta) {
    final position = nav.scrollController.position;
    nav.scrollController.animateTo(
      (position.pixels + delta).clamp(0.0, position.maxScrollExtent),
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();
    final showRail =
        MediaQuery.sizeOf(context).width >= HomeScreen._railBreakpoint;

    return Focus(
      focusNode: _shortcutsNode,
      autofocus: true,
      onKeyEvent: _onKeyEvent,
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                const AppHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    controller: nav.scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _Anchored(
                          section: PortfolioSection.home,
                          child: const HeroSection(),
                        ),
                        const QuoteSection(),
                        _Anchored(
                          section: PortfolioSection.projects,
                          child: const ProjectsSection(),
                        ),
                        _Anchored(
                          section: PortfolioSection.skills,
                          child: const SkillsSection(),
                        ),
                        _Anchored(
                          section: PortfolioSection.about,
                          child: const AboutSection(),
                        ),
                        _Anchored(
                          section: PortfolioSection.testimonials,
                          child: const TestimonialsSection(),
                        ),
                        _Anchored(
                          section: PortfolioSection.contacts,
                          child: const ContactsSection(),
                        ),
                        const Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (showRail)
              const Positioned(
                left: 28,
                top: AppHeader.height,
                bottom: 0,
                child: SocialRail(),
              ),
            const Positioned(
              left: 0,
              right: 0,
              top: AppHeader.height,
              bottom: 0,
              child: MobileMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

/// Wraps a section with its navigation [GlobalKey] (for scroll-to) and a
/// [VisibilityDetector] that marks it active when it dominates the viewport.
class _Anchored extends StatelessWidget {
  final PortfolioSection section;
  final Widget child;

  const _Anchored({required this.section, required this.child});

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();
    return VisibilityDetector(
      key: ValueKey('section-${section.name}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.55) {
          nav.setActive(section);
        }
      },
      child: KeyedSubtree(key: nav.keyFor(section), child: child),
    );
  }
}
