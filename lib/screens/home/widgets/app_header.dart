import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/widgets/app_logo.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/home/widgets/nav_link.dart';
import 'package:portfolio/services/analytics/analytics.dart';
import 'package:provider/provider.dart';

/// Sticky top navigation bar. Shows inline links on desktop and a burger
/// toggle on mobile/tablet.
class AppHeader extends StatelessWidget {
  static const double height = 84;

  /// Sections shown in the navigation, in order.
  static const List<PortfolioSection> navSections = [
    PortfolioSection.home,
    PortfolioSection.projects,
    PortfolioSection.skills,
    PortfolioSection.about,
    PortfolioSection.testimonials,
    PortfolioSection.contacts,
  ];

  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final showInlineNav = context.isDesktop;
    final horizontal = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 32,
      desktop: 48,
    );

    return Container(
      height: height,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: horizontal),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => nav.scrollTo(
              PortfolioSection.home,
              source: AnalyticsPlacements.logo,
            ),
            child: const CursorTarget(child: AppLogo()),
          ),
          if (showInlineNav)
            Row(
              children: [
                for (final section in navSections)
                  NavLink(
                    section: section,
                    active: nav.active == section,
                    onTap: () => nav.scrollTo(
                      section,
                      source: AnalyticsPlacements.header,
                    ),
                  ),
              ],
            )
          else
            _BurgerButton(
              open: nav.mobileMenuOpen,
              onTap: () => nav.toggleMobileMenu(),
            ),
        ],
      ),
    );
  }
}

class _BurgerButton extends StatelessWidget {
  final bool open;
  final VoidCallback onTap;

  const _BurgerButton({required this.open, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        open ? Icons.close : Icons.menu,
        color: AppColors.white,
        size: 28,
      ),
    );
  }
}

/// Full-screen overlay menu shown when the burger is open on mobile/tablet.
class MobileMenu extends StatelessWidget {
  const MobileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: !nav.mobileMenuOpen
          ? const SizedBox.shrink()
          : Container(
              color: AppColors.background,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final section in AppHeader.navSections)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: NavLink(
                        section: section,
                        active: nav.active == section,
                        onTap: () => nav.scrollTo(
                          section,
                          source: AnalyticsPlacements.mobileMenu,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
