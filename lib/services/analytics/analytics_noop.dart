/// Non-web implementation of the analytics binding.
///
/// The desktop/mobile builds of the portfolio have no PostHog SDK wired up, so
/// every call is a no-op. Selected by the conditional import in
/// [analytics.dart] when `dart:js_interop` is unavailable.
library;

bool analyticsIsReady() => false;

String analyticsCurrentPath() => '/';

void analyticsPageView(String path) {}

void analyticsCapture(String event, Map<String, Object?> properties) {}
