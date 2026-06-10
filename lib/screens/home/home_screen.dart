import 'package:flutter/material.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/sections/about_section.dart';
import 'package:portfolio/screens/home/sections/contacts_section.dart';
import 'package:portfolio/screens/home/sections/hero_section.dart';
import 'package:portfolio/screens/home/sections/projects_section.dart';
import 'package:portfolio/screens/home/sections/quote_section.dart';
import 'package:portfolio/screens/home/sections/skills_section.dart';
import 'package:portfolio/screens/home/widgets/app_header.dart';
import 'package:portfolio/screens/home/widgets/footer.dart';
import 'package:portfolio/screens/home/widgets/social_rail.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// The single-page portfolio: a sticky header over a scrollable column of
/// anchored sections, with a fixed social rail on wide screens.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Minimum width at which the fixed left social rail is shown.
  static const double _railBreakpoint = 1320;

  @override
  Widget build(BuildContext context) {
    final nav = context.read<NavigationProvider>();
    final showRail = MediaQuery.sizeOf(context).width >= _railBreakpoint;

    return Scaffold(
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
