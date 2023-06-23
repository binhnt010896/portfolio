import 'package:flutter/material.dart';

enum SnackBarType {
  error,
  success
}

void showSnackBar(context, {required String text, SnackBarType snackBarType = SnackBarType.success}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: snackBarType == SnackBarType.success
          ? Theme.of(context).colorScheme.primary
          : Colors.redAccent,
      content: Text(text)
    ),
  );
}