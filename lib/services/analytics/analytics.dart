import 'package:portfolio/services/analytics/analytics_noop.dart'
    if (dart.library.js_interop) 'package:portfolio/services/analytics/analytics_web.dart'
    as platform;

export 'package:portfolio/services/analytics/analytics_events.dart';

/// Thin, fire-and-forget facade over PostHog.
///
/// PostHog itself is initialised by the snippet in `web/index.html`, which also
/// owns `$pageview` / `$pageleave`. This class only sends the custom events that
/// describe what a visitor did once the app was running; on non-web builds (and
/// on localhost, where the snippet deliberately doesn't load) every call is a
/// silent no-op, so call sites never need to guard.
class Analytics {
  Analytics._();

  /// Keys already sent through [captureOnce] this page load.
  static final Set<String> _sentOnce = <String>{};

  /// The path of the most recently reported pageview. Lazily seeded with the
  /// address-bar path so the initial load — which the `index.html` snippet has
  /// already reported — is not counted a second time.
  static String? _lastPath;

  /// Whether events are actually reaching PostHog. Useful for debugging; call
  /// sites should not branch on it.
  static bool get isReady => platform.analyticsIsReady();

  static void capture(
    String event, [
    Map<String, Object?> properties = const {},
  ]) {
    platform.analyticsCapture(event, properties);
  }

  /// Reports a pageview for [path], skipping repeats of the current path.
  ///
  /// Deduplicating here is what makes the initial load safe: on first paint the
  /// seeded path already matches, whether the visitor landed on `/` or deep
  /// linked straight into a `/works/<slug>` case study.
  static void pageView(String path) {
    _lastPath ??= platform.analyticsCurrentPath();
    if (_lastPath == path) return;
    _lastPath = path;
    platform.analyticsPageView(path);
  }

  /// Captures [event] at most once per [key] per page load — for events that
  /// would otherwise repeat as the visitor scrolls back and forth (a section
  /// re-entering the viewport, for instance).
  static void captureOnce(
    String key,
    String event, [
    Map<String, Object?> properties = const {},
  ]) {
    if (!_sentOnce.add(key)) return;
    capture(event, properties);
  }
}
