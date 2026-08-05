import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';
import 'package:portfolio/services/analytics/analytics.dart';

/// One immersive, Moritz-style featured project row: a large screenshot and a
/// narrative teaser side by side (alternating left/right on desktop, stacked
/// on mobile), linking to the project's `/works/<slug>` case-study page.
class FeaturedProjectRow extends StatelessWidget {
  final Project project;

  /// Zero-based position among the featured rows — drives the `// 0N` index
  /// and which side the image sits on.
  final int index;

  const FeaturedProjectRow({
    super.key,
    required this.project,
    required this.index,
  });

  /// Navigates to the case study. [source] distinguishes a click on the big
  /// screenshot from one on the "View case study" button — worth knowing when
  /// deciding how much the imagery is pulling its weight.
  void _open(BuildContext context, String source) {
    Analytics.capture(AnalyticsEvents.caseStudyOpened, {
      AnalyticsProps.slug: project.slug,
      AnalyticsProps.title: project.title,
      AnalyticsProps.source: source,
    });
    context.push('/works/${project.slug}');
  }

  @override
  Widget build(BuildContext context) {
    final stacked = !context.isDesktop;
    final image = _FeaturedImage(
      project: project,
      onTap: () => _open(context, AnalyticsPlacements.featuredImage),
    );
    final info = _FeaturedInfo(
      project: project,
      index: index,
      onOpen: () => _open(context, AnalyticsPlacements.featuredButton),
    );

    if (stacked) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [image, const SizedBox(height: 24), info],
      );
    }

    final imageLeft = index.isEven;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 7, child: imageLeft ? image : info),
        const SizedBox(width: 48),
        Expanded(flex: 5, child: imageLeft ? info : image),
      ],
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  const _FeaturedImage({required this.project, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final height = Responsive.value<double>(
      context,
      mobile: 220,
      tablet: 320,
      desktop: 380,
    );
    return CursorTarget(
      child: GestureDetector(
        onTap: onTap,
        child: Tilt3D(
          maxTilt: 0.05,
          hoverScale: 1.01,
          child: Container(
            height: height,
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.border)),
            child: project.imageAsset != null
                ? Hero(
                    tag: 'project-hero-${project.slug}',
                    child: Image.asset(project.imageAsset!, fit: BoxFit.cover),
                  )
                : Center(
                    child: Text(
                      '</${project.title.split(' ').first.toLowerCase()}>',
                      style: AppTextStyles.tagPrimary,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedInfo extends StatelessWidget {
  final Project project;
  final int index;
  final VoidCallback onOpen;
  const _FeaturedInfo({
    required this.project,
    required this.index,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final study = project.caseStudy!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '// 0${index + 1}',
          style: AppTextStyles.sectionIndexFor(isMobile),
        ),
        const SizedBox(height: 8),
        SelectableText(
          project.title,
          style: AppTextStyles.sectionTitleFor(isMobile),
        ),
        const SizedBox(height: 8),
        SelectableText(project.tags.join('  '), style: AppTextStyles.tag),
        const SizedBox(height: 16),
        SelectableText(project.description, style: AppTextStyles.body),
        const SizedBox(height: 12),
        SelectableText('role: ${study.role}', style: AppTextStyles.tagPrimary),
        const SizedBox(height: 24),
        CodeButton(label: 'View case study ~~>', onPressed: onOpen),
      ],
    );
  }
}
