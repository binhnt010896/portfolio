import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/providers/contact_form_provider.dart';
import 'package:portfolio/providers/cursor_provider.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/home_screen.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/project_detail/project_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  // Clean `/works/<slug>` URLs instead of `/#/works/<slug>` (no-op off web).
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

/// `/` is the single-page home; each featured project also gets a dedicated,
/// shareable case-study page at `/works/<slug>`.
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/works/:slug',
      redirect: (context, state) {
        final slug = state.pathParameters['slug'];
        final project = slug == null ? null : PortfolioData.projectBySlug(slug);
        // Unknown slugs (or projects without a case study) fall back home.
        return (project == null || project.caseStudy == null) ? '/' : null;
      },
      pageBuilder: (context, state) {
        final project =
            PortfolioData.projectBySlug(state.pathParameters['slug']!)!;
        return CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondary, child) =>
              FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            ),
            child: child,
          ),
          child: ProjectDetailScreen(project: project),
        );
      },
    ),
  ],
);

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => ContactFormProvider()),
        ChangeNotifierProvider(create: (_) => CursorProvider()),
      ],
      child: MaterialApp.router(
        title: 'Binh — Portfolio',
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(),
        routerConfig: _router,
        builder: (context, child) =>
            CursorArena(child: child ?? const SizedBox.shrink()),
      ),
    );
  }
}
