import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio/constants/app_config.dart';

/// The outcome of a contact-form submission.
class SubmitResult {
  final bool success;
  final String message;
  const SubmitResult({required this.success, required this.message});
}

/// Sends contact-form submissions to the configured email via Web3Forms.
///
/// No backend required — Web3Forms accepts a plain HTTPS POST and emails the
/// submission to the address the access key is registered to.
class Web3FormsService {
  const Web3FormsService();

  Future<SubmitResult> send({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (!AppConfig.hasContactFormKey) {
      return const SubmitResult(
        success: false,
        message: 'Contact form is not configured yet.',
      );
    }

    try {
      final response = await http.post(
        Uri.parse(AppConfig.web3formsEndpoint),
        headers: const {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'access_key': AppConfig.web3formsAccessKey,
          'name': name,
          'email': email,
          'message': message,
          'subject': subject.isEmpty ? 'Portfolio contact from $name' : subject,
          'from_name': 'Portfolio Contact Form',
          // Honeypot field — bots fill it, humans never see it.
          'botcheck': '',
        }),
      );

      final body = jsonDecode(response.body) as Map<String, dynamic>;
      final success = response.statusCode == 200 && body['success'] == true;
      return SubmitResult(
        success: success,
        message: (body['message'] as String?) ??
            (success ? 'Message sent.' : 'Something went wrong.'),
      );
    } catch (_) {
      return const SubmitResult(
        success: false,
        message: 'Could not send your message. Please try again.',
      );
    }
  }
}
