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
import 'package:portfolio/services/analytics/analytics.dart';
import 'package:provider/provider.dart';

void main() {
  // Clean `/works/<slug>` URLs instead of `/#/works/<slug>` (no-op off web).
  usePathUrlStrategy();
  runApp(const PortfolioApp());
}

/// `/` is the single-page home; each featured project also gets a dedicated,
/// shareable case-study page at `/works/<slug>`.
final GoRouter _router = GoRouter(
  observers: [_AnalyticsRouteObserver()],
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        // Read back by [_AnalyticsRouteObserver] as the pageview path.
        name: '/',
        child: const HomeScreen(),
      ),
    ),
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
          // Built from the slug rather than `state.uri`: an imperative
          // `push()` leaves `state.uri` pointing at the base location, so the
          // pageview would otherwise be reported as `/`.
          name: '/works/${project.slug}',
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

/// Reports a PostHog `$pageview` for every route the visitor lands on.
///
/// The route's `name` (set on each page above) is the source of truth rather
/// than `window.location`: `context.push('/works/<slug>')` records the case
/// study as an imperative match and leaves the address bar on `/`, so the
/// browser — and therefore posthog-js' own SPA detection — never sees the
/// navigation. [Analytics.pageView] drops the duplicate for the initial route,
/// which `web/index.html` has already reported.
class _AnalyticsRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _report(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Going back re-exposes the route underneath, e.g. `/` again.
    _report(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _report(newRoute);
  }

  void _report(Route<dynamic>? route) {
    final path = route?.settings.name;
    if (path != null && path.isNotEmpty) Analytics.pageView(path);
  }
}

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
