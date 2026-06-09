import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';

/// A bordered skill-category card: a titled header above a body of items.
class SkillCard extends StatelessWidget {
  final SkillCategory category;

  const SkillCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: SelectableText(category.title, style: AppTextStyles.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                for (final item in category.items)
                  SelectableText(item, style: AppTextStyles.skillItem),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
