import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Widget? icon;
  final bool loading;
  final VoidCallback onPressed;
  final EdgeInsets? padding;
  const ActionButton({Key? key, required this.text, required this.onPressed, this.icon, this.padding, this.loading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      color: theme.colorScheme.tertiary,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      onPressed: onPressed,
      child: loading
        ? SizedBox(
            height: 24,
            width: 24,
            child: Center(
                child: CircularProgressIndicator()
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(text),
              SizedBox(width: 6),
              icon ?? Container()
            ],
          ),
    );
  }
}
