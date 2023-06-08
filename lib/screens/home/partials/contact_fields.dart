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
              cursorColor: theme.colorScheme.onPrimary,
              controller: widget.controller,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary, fontSize: 16),
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: widget.helper,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary.withOpacity(0.7)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.onPrimary, width: 2),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.onPrimary, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: theme.colorScheme.onPrimary, width: 2),
                ),
              ),
              maxLines: widget.maxLine,
            ),
          ),
        ],
      ),
    );
  }
}
