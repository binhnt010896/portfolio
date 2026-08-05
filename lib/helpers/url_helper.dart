import 'package:portfolio/services/analytics/analytics.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new tab / external application. Silently ignores failures.
///
/// Every outbound link in the portfolio goes through here, so this is also the
/// single place that reports [AnalyticsEvents.outboundLinkClicked]. Pass [label]
/// (*what* was clicked) and [placement] (*where* it was clicked) so the event
/// can be broken down in PostHog; [properties] carries any extra context, e.g.
/// the project slug.
Future<void> openUrl(
  String url, {
  String? label,
  String? placement,
  Map<String, Object?> properties = const {},
}) async {
  final uri = Uri.tryParse(url);

  Analytics.capture(AnalyticsEvents.outboundLinkClicked, {
    AnalyticsProps.url: url,
    if (uri != null && uri.host.isNotEmpty) AnalyticsProps.host: uri.host,
    if (uri != null && uri.scheme.isNotEmpty) AnalyticsProps.scheme: uri.scheme,
    if (label != null) AnalyticsProps.label: label,
    if (placement != null) AnalyticsProps.placement: placement,
    ...properties,
  });

  if (uri == null) return;
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
