/// Web implementation of the analytics binding: forwards events to the
/// `posthog-js` instance bootstrapped in `web/index.html`.
///
/// `window.posthog` is absent when the snippet chose not to load (localhost, or
/// a blocked request), so every entry point checks for it and degrades to a
/// no-op rather than throwing into the widget tree.
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

/// Whether `posthog.init()` has run and the JS API is callable.
bool analyticsIsReady() {
  try {
    return globalContext.has('posthog');
  } catch (_) {
    return false;
  }
}

/// The path currently shown in the address bar, e.g. `/works/thomson-touch`.
String analyticsCurrentPath() {
  try {
    final location = globalContext['location'] as JSObject?;
    return (location?['pathname'] as JSString?)?.toDart ?? '/';
  } catch (_) {
    return '/';
  }
}

/// Reports a `$pageview` for [path].
///
/// `$current_url` and `$pathname` are set explicitly because posthog-js would
/// otherwise read them off `window.location` — which still points at `/` after
/// a go_router `push()`.
void analyticsPageView(String path) {
  final origin = _origin();
  analyticsCapture(r'$pageview', {
    r'$current_url': origin.isEmpty ? path : '$origin$path',
    r'$pathname': path,
  });
}

String _origin() {
  try {
    final location = globalContext['location'] as JSObject?;
    return (location?['origin'] as JSString?)?.toDart ?? '';
  } catch (_) {
    return '';
  }
}

void analyticsCapture(String event, Map<String, Object?> properties) {
  try {
    if (!globalContext.has('posthog')) return;
    final posthog = globalContext['posthog'] as JSObject?;
    if (posthog == null) return;
    posthog.callMethod(
      'capture'.toJS,
      event.toJS,
      properties.isEmpty ? null : properties.jsify(),
    );
  } catch (_) {
    // Analytics must never break the page.
  }
}
