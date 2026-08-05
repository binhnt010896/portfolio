import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/providers/contact_form_provider.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/services/analytics/analytics.dart';
import 'package:provider/provider.dart';

/// A contact form matching the Figma design: Name + Email side-by-side, a
/// Title (subject), a tall Message box, and a `Send` button. Submissions are
/// emailed via Web3Forms.
class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  /// Whether [AnalyticsEvents.contactFormStarted] has already been reported.
  /// Never reset: clearing the fields after a successful send also fires
  /// `Form.onChanged`, and a phantom "started" would be worse than missing the
  /// (rare) second message in one visit.
  bool _startReported = false;

  /// Fires the "someone actually began typing" half of the contact funnel, then
  /// clears any stale success/error feedback.
  void _onFormChanged() {
    if (!_startReported) {
      _startReported = true;
      Analytics.capture(AnalyticsEvents.contactFormStarted);
    }
    context.read<ContactFormProvider>().reset();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _titleController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  String? _required(String? value, String field) {
    if (value == null || value.trim().isEmpty) return 'Please enter your $field.';
    return null;
  }

  String? _validateEmail(String? value) {
    final required = _required(value, 'email');
    if (required != null) return required;
    final email = value!.trim();
    final valid = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    return valid ? null : 'Please enter a valid email.';
  }

  Future<void> _submit() async {
    final provider = context.read<ContactFormProvider>();
    if (provider.isSending) return;
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final ok = await provider.submit(
      name: _nameController.text,
      email: _emailController.text,
      subject: _titleController.text,
      message: _messageController.text,
    );

    if (ok && mounted) {
      _formKey.currentState?.reset();
      _nameController.clear();
      _emailController.clear();
      _titleController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContactFormProvider>();
    final isError = provider.status == ContactFormStatus.error;
    final isSuccess = provider.status == ContactFormStatus.success;

    final nameField = _Field(
      hint: 'Name',
      controller: _nameController,
      textInputAction: TextInputAction.next,
      validator: (v) => _required(v, 'name'),
    );
    final emailField = _Field(
      hint: 'Email',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: _validateEmail,
    );

    return Form(
      key: _formKey,
      onChanged: _onFormChanged,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Email sit side-by-side when there's room, else stack.
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 420) {
                return Column(
                  children: [
                    nameField,
                    const SizedBox(height: 16),
                    emailField,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: nameField),
                  const SizedBox(width: 16),
                  Expanded(child: emailField),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          _Field(
            hint: 'Title',
            controller: _titleController,
            textInputAction: TextInputAction.next,
            validator: (v) => _required(v, 'title'),
          ),
          const SizedBox(height: 16),
          _Field(
            hint: 'Message',
            controller: _messageController,
            minLines: 5,
            maxLines: 8,
            validator: (v) => _required(v, 'message'),
          ),
          const SizedBox(height: 16),
          CodeButton(
            label: provider.isSending ? 'Sending…' : 'Send',
            filled: true,
            onPressed: _submit,
          ),
          if (provider.feedback.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              provider.feedback,
              style: isSuccess
                  ? AppTextStyles.formFeedbackSuccess
                  : isError
                      ? AppTextStyles.formFeedbackError
                      : AppTextStyles.inputHint,
            ),
          ],
        ],
      ),
    );
  }
}

/// A bordered text field with the field name shown as placeholder text,
/// matching the Figma input component.
class _Field extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;

  const _Field({
    required this.hint,
    required this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    const enabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.border),
    );
    const focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.primary),
    );
    const errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: AppColors.error),
    );

    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      cursorColor: AppColors.primary,
      style: AppTextStyles.inputText,
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        hintStyle: AppTextStyles.inputHint,
        errorStyle: AppTextStyles.formFeedbackError,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
      ).copyWith(hintText: hint),
    );
  }
}
