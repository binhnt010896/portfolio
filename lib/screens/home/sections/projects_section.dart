import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/project_card.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';

/// `# projects` — a responsive grid of project cards.
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const double _gap = 24;

  @override
  Widget build(BuildContext context) {
    final columns = Responsive.value<int>(
      context,
      mobile: 1,
      tablet: 2,
      desktop: 3,
    );
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RevealOnScroll(
            child: SectionHeading(
              title: 'projects',
              trailing: CodeTextLink(
                label: 'View all ~~>',
                onPressed: () => openUrl('https://github.com/binhnt010896'),
              ),
            ),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final totalGap = _gap * (columns - 1);
              final itemWidth = (constraints.maxWidth - totalGap) / columns;
              final projects = PortfolioData.projects;
              return Wrap(
                spacing: _gap,
                runSpacing: _gap,
                children: [
                  for (var i = 0; i < projects.length; i++)
                    SizedBox(
                      width: itemWidth,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 90 * (i % columns)),
                        child: Tilt3D(
                          maxTilt: 0.06,
                          hoverScale: 1.015,
                          child: ProjectCard(project: projects[i]),
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
