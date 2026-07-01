import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/decorations.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';
import 'package:portfolio/screens/home/widgets/skill_card.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';
import 'package:portfolio/screens/home/widgets/wireframe_cube.dart';

/// `# skills` — decorative shapes on the left, skill-category cards on the right.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const double _gap = 16;

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(child: SectionHeading(title: 'skills')),
          const SizedBox(height: 8),
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(width: 220, child: _Decorations()),
                SizedBox(width: 32),
                Expanded(child: _SkillGrid(columns: 3)),
              ],
            )
          else
            _SkillGrid(columns: context.isTablet ? 2 : 1),
        ],
      ),
    );
  }
}

class _Decorations extends StatelessWidget {
  const _Decorations();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            OutlinedSquare(size: 84, color: AppColors.border),
            SizedBox(width: 12),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: DotGrid(rows: 3, columns: 3),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Center(child: WireframeCube(size: 150)),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 60,
            height: 60,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final int columns;
  const _SkillGrid({required this.columns});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final totalGap = SkillsSection._gap * (columns - 1);
        final itemWidth = (constraints.maxWidth - totalGap) / columns;
        final skills = PortfolioData.skills;
        return Wrap(
          spacing: SkillsSection._gap,
          runSpacing: SkillsSection._gap,
          children: [
            for (var i = 0; i < skills.length; i++)
              SizedBox(
                width: itemWidth,
                child: RevealOnScroll(
                  delay: Duration(milliseconds: 80 * (i % columns)),
                  child: Tilt3D(
                    maxTilt: 0.06,
                    hoverScale: 1.015,
                    child: SkillCard(category: skills[i]),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
