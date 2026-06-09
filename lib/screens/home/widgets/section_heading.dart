import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/helpers/responsive.dart';

/// A `# section-name ───────` heading with an optional trailing action
/// (e.g. `View all ~~>`).
class SectionHeading extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeading({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('#', style: AppTextStyles.sectionHashFor(isMobile)),
          const SizedBox(width: 4),
          Flexible(
            child: SelectableText(
              title,
              style: AppTextStyles.sectionTitleFor(isMobile),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Divider(color: AppColors.line, thickness: 2, height: 2),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 16),
            trailing!,
          ],
        ],
      ),
    );
  }
}
