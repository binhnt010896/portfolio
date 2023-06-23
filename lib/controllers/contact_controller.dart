import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/helpers/misc.dart';
import 'package:portfolio/services/supabase_service.dart';
import 'package:web_browser_detect/web_browser_detect.dart';

class ContactController extends GetxController {
  var nameInput = TextEditingController().obs;
  var emailInput = TextEditingController().obs;
  var messageInput = TextEditingController().obs;
  var isFormLoading = false.obs;

  final SupabaseService supabaseService = SupabaseService();

  /// Get
  getNameController() => nameInput.value;
  getEmailController() => emailInput.value;
  getMessageController() => messageInput.value;
  getFormLoading() => isFormLoading.value;

  getName() => nameInput.value.text;
  getEmail() => emailInput.value.text;
  getMessage() => messageInput.value.text;

  /// Set
  setFormLoading(state) => isFormLoading(state);

  clearForm() {
    nameInput.value.clear();
    emailInput.value.clear();
    messageInput.value.clear();
  }

  /// Methods
  submitForm(context) {
    setFormLoading(true);
    final browser = Browser();
    supabaseService
        .supabase
        .from('Contacts')
        .insert({
      'name': getName(),
      'email': getEmail(),
      'message': getMessage(),
      'browser': '${browser.browser} ${browser.version}'
    }).then((_) {
      showSnackBar(context, text: 'Awesome ${getName()}! I\'ll get in touch within 24 hours! ;)', snackBarType: SnackBarType.success);
      clearForm();
    }).onError((error, stackTrace) {
      showSnackBar(context, text: 'Some error occurs, please try again later!', snackBarType: SnackBarType.error);
    }).whenComplete(() {
      Navigator.pop(context);
      setFormLoading(false);
    });
  }
}