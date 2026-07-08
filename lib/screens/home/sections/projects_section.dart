import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/featured_project_row.dart';
import 'package:portfolio/screens/home/widgets/project_card.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';

/// `# projects` — immersive featured case-study rows followed by a compact
/// grid of the remaining projects.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const double _gap = 24;
  static const double _rowGap = 72;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    final featured = PortfolioData.featuredProjects;
    final others = PortfolioData.otherProjects;
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: SectionHeading(
              title: 'projects',
              index: 1,
              trailing: CodeTextLink(
                label: 'View all ~~>',
                onPressed: () => openUrl('https://github.com/binhnt010896'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < featured.length; i++) ...[
            if (i > 0) const SizedBox(height: _rowGap),
            RevealOnScroll(
              from: i.isEven ? RevealFrom.left : RevealFrom.right,
              child: FeaturedProjectRow(project: featured[i], index: i),
            ),
          ],
          const SizedBox(height: _rowGap),
          const RevealOnScroll(
            child: SectionHeading(title: 'other-projects'),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final totalGap = _gap * (columns - 1);
              final itemWidth = (constraints.maxWidth - totalGap) / columns;
              return Wrap(
                spacing: _gap,
                runSpacing: _gap,
                children: [
                  for (var i = 0; i < others.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 90 * (i % columns)),
                        child: Tilt3D(
                          maxTilt: 0.06,
                          hoverScale: 1.015,
                          child: ProjectCard(project: others[i]),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
