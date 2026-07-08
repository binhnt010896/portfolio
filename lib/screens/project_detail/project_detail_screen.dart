import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/app_logo.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/home/widgets/footer.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';

/// Dedicated case-study page for a featured project (`/works/<slug>`):
/// full-bleed hero, role/timeline/team meta bar, then the narrative —
/// overview, responsibilities, what I built, findings, and outcome.
class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  CaseStudy get study => project.caseStudy!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _DetailHeader(project: project),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Hero(project: project),
                  SectionContainer(
                    topPadding: 40,
                    bottomPadding: 24,
                    child: RevealOnScroll(child: _MetaBar(study: study)),
                  ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 24,
                    child: RevealOnScroll(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: 'overview'),
                          SelectableText(
                            study.overview,
                            style: AppTextStyles.body,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 24,
                    child: RevealOnScroll(
                      child: _BulletBlock(
                        title: 'what-i-did',
                        items: study.highlights,
                      ),
                    ),
                  ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 24,
                    child: RevealOnScroll(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: 'findings'),
                          for (var i = 0; i < study.findings.length; i++) ...[
                            if (i > 0) const SizedBox(height: 16),
                            _FindingCard(
                              index: i + 1,
                              finding: study.findings[i],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (study.gallery.isNotEmpty)
                    SectionContainer(
                      topPadding: 16,
                      bottomPadding: 24,
                      child: RevealOnScroll(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeading(title: 'gallery'),
                            for (var i = 0; i < study.gallery.length; i++) ...[
                              if (i > 0) const SizedBox(height: 24),
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.border),
                                ),
                                child: Image.asset(
                                  study.gallery[i],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 56,
                    child: RevealOnScroll(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: 'outcome'),
                          SelectableText(
                            study.outcome,
                            style: AppTextStyles.bodyWhite,
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              if (project.liveUrl != null)
                                CodeButton(
                                  label: 'Live <~>',
                                  onPressed: () => openUrl(project.liveUrl!),
                                ),
                              if (project.appStoreUrl != null)
                                CodeButton(
                                  label: 'App Store <~>',
                                  onPressed: () =>
                                      openUrl(project.appStoreUrl!),
                                ),
                              if (project.playStoreUrl != null)
                                CodeButton(
                                  label: 'Play Store <~>',
                                  onPressed: () =>
                                      openUrl(project.playStoreUrl!),
                                ),
                              CodeButton(
                                label: '<~ Back to works',
                                onPressed: () => _backHome(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _backHome(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/');
  }
}

/// Slim sticky header: logo + back link (the home header's section anchors
/// don't exist on this page).
class _DetailHeader extends StatelessWidget {
  final Project project;
  const _DetailHeader({required this.project});

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 32,
      desktop: 24,
    );
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CursorTarget(
                child: GestureDetector(
                  onTap: () => _backHome(context),
                  child: const AppLogo(),
                ),
              ),
              CodeTextLink(
                label: '<~ back',
                onPressed: () => _backHome(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Full-bleed screenshot with a scrim and the project title/tags overlaid at
/// the bottom — the Moritz-style immersive opener.
class _Hero extends StatelessWidget {
  final Project project;
  const _Hero({required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final height = Responsive.value<double>(
      context,
      mobile: 260,
      tablet: 360,
      desktop: 440,
    );
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (project.imageAsset != null)
            Hero(
              tag: 'project-hero-${project.slug}',
              child: Image.asset(project.imageAsset!, fit: BoxFit.cover),
            )
          else
            const ColoredBox(color: AppColors.cardBackground),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.transparent, AppColors.background],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints:
                  const BoxConstraints(maxWidth: Responsive.maxContentWidth),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.value<double>(
                    context,
                    mobile: 16,
                    tablet: 32,
                    desktop: 24,
                  ),
                  vertical: 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SelectableText(
                        project.title,
                        style: AppTextStyles.detailTitleFor(isMobile),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SelectableText(
                      project.tags.join('  '),
                      style: AppTextStyles.tagPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// role / timeline / team — a bordered strip of labelled meta values.
class _MetaBar extends StatelessWidget {
  final CaseStudy study;
  const _MetaBar({required this.study});

  @override
  Widget build(BuildContext context) {
    final entries = [
      ('role', study.role),
      ('timeline', study.duration),
      ('team', study.teamContext),
    ];
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 48,
          runSpacing: 16,
          children: [
            for (final (label, value) in entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('// $label', style: AppTextStyles.metaLabel),
                  const SizedBox(height: 4),
                  SelectableText(value, style: AppTextStyles.metaValue),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

/// A `# heading` followed by `>` bullets.
class _BulletBlock extends StatelessWidget {
  final String title;
  final List<String> items;
  const _BulletBlock({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(title: title),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('>', style: AppTextStyles.tagPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: SelectableText(item, style: AppTextStyles.body),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// One problem→resolution pair from the findings list.
class _FindingCard extends StatelessWidget {
  final int index;
  final Finding finding;
  const _FindingCard({required this.index, required this.finding});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        color: AppColors.cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('// finding-0$index', style: AppTextStyles.metaLabel),
            const SizedBox(height: 12),
            SelectableText(finding.problem, style: AppTextStyles.bodyWhite),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('=>', style: AppTextStyles.tagPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: SelectableText(
                    finding.resolution,
                    style: AppTextStyles.body,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
