import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';

/// The "Currently working on …" badge shown under the hero image.
class StatusBadge extends StatelessWidget {
  final String text;
  const StatusBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 16, height: 16, color: AppColors.primary),
            const SizedBox(width: 8),
            Flexible(child: SelectableText(text, style: AppTextStyles.badge)),
          ],
        ),
      ),
    );
  }
}
