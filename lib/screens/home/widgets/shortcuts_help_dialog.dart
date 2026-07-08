import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';

/// The `?` keyboard-shortcuts cheatsheet — a themed, code-editor styled dialog.
class ShortcutsHelpDialog extends StatelessWidget {
  const ShortcutsHelpDialog({super.key});

  static const List<(String, String)> _shortcuts = [
    ('j / k', 'scroll down / up'),
    ('1 – 6', 'jump to section'),
    ('?', 'open this help'),
    ('esc', 'close'),
  ];

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: AppColors.scrim,
      builder: (_) => const ShortcutsHelpDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: Border.all(color: AppColors.border),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('// keyboard-shortcuts', style: AppTextStyles.metaLabel),
              const SizedBox(height: 16),
              for (final (keys, action) in _shortcuts)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      _Keycap(label: keys),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(action, style: AppTextStyles.body),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Keycap extends StatelessWidget {
  final String label;
  const _Keycap({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        color: AppColors.background,
      ),
      child: Text(label, style: AppTextStyles.kbdKey),
    );
  }
}
