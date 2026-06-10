import 'package:flutter/material.dart';
import 'package:portfolio/services/web3forms_service.dart';

/// The lifecycle of a single contact-form submission.
enum ContactFormStatus { idle, sending, success, error }

/// Owns contact-form submission state (Provider state management).
///
/// The form widget keeps the text controllers; this notifier only tracks the
/// in-flight status and the last feedback message so the UI can react.
class ContactFormProvider extends ChangeNotifier {
  ContactFormProvider({Web3FormsService? service})
      : _service = service ?? const Web3FormsService();

  final Web3FormsService _service;

  ContactFormStatus _status = ContactFormStatus.idle;
  ContactFormStatus get status => _status;

  String _feedback = '';
  String get feedback => _feedback;

  bool get isSending => _status == ContactFormStatus.sending;

  Future<bool> submit({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (_status == ContactFormStatus.sending) return false;

    _status = ContactFormStatus.sending;
    _feedback = '';
    notifyListeners();

    final result = await _service.send(
      name: name.trim(),
      email: email.trim(),
      subject: subject.trim(),
      message: message.trim(),
    );

    _status =
        result.success ? ContactFormStatus.success : ContactFormStatus.error;
    _feedback = result.success
        ? "Thanks! Your message is on its way — I'll get back to you soon."
        : result.message;
    notifyListeners();
    return result.success;
  }

  /// Clears feedback when the user edits the form again.
  void reset() {
    if (_status == ContactFormStatus.idle) return;
    _status = ContactFormStatus.idle;
    _feedback = '';
    notifyListeners();
  }
}
