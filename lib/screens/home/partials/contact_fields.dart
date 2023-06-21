import 'package:flutter/material.dart';

class ContactTextField extends StatefulWidget {
  final String title;
  final String helper;
  final TextEditingController? controller;
  final int maxLine;
  final VoidCallback? onPress;
  final bool enabled;
  const ContactTextField({Key? key, required this.title, this.helper = '', this.maxLine = 1, this.controller, this.onPress, this.enabled = true}) : super(key: key);

  @override
  State<ContactTextField> createState() => _ContactTextFieldState();
}

class _ContactTextFieldState extends State<ContactTextField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onPrimary)),
          SizedBox(height: 4),
          GestureDetector(
            onTap: widget.onPress,
            child: TextFormField(
              cursorColor: theme.colorScheme.onBackground,
              controller: widget.controller,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground, fontSize: 16),
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: widget.helper,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onBackground.withOpacity(0.7)),
                filled: true,
                fillColor: theme.colorScheme.onPrimary,
              ),
              maxLines: widget.maxLine,
            ),
          ),
        ],
      ),
    );
  }
}
