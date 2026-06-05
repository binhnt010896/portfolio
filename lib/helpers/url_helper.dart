import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in a new tab / external application. Silently ignores failures.
Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
