import 'package:firebase_analytics_web/firebase_analytics_web.dart';

class GAEvent {
  static const CLICK_DOWNLOAD_CV = 'Click Download CV';
  static const CLICK_COMPANY_SITE = 'Click Project Company Site';
  static const CLICK_DOWNLOAD_PLATFORM = 'Click Download Platform';
  static const CLICK_LETS_CONNECT_MODAL = 'Click Let\'s Connect';
  static const CLICK_LINKED_IN = 'Click LinkedIn';
  static const CLICK_GITHUB = 'Click GitHub';
}

class GAParam {
  static const COMPANY_SITE = 'Company Site';
  static const DOWNLOAD_PLATFORM_URL = 'Download Url';
}

Future<void> sendAnalyticsEvent(
  String event,
  Map<String, dynamic> parameters,
) async {
  FirebaseAnalyticsWeb analytics = FirebaseAnalyticsWeb();
  Map<String, dynamic> params = Map<String, dynamic>.from(parameters);

  params.removeWhere((key, value) => value == null);
  params.updateAll((key, value) => (value is String && value.length > 100)
      ? value.replaceRange(100, value.length, '')
      : value);
  try {
    await analytics.logEvent(
      name: event,
      parameters: params,
    );
  } catch (e) {
    print('Log Error: $e');
  }
}
