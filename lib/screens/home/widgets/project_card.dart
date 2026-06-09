import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';

/// A bordered project card: screenshot, tech tags, title, description and links.
class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Preview(project: project),
          Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: SelectableText(
              project.tags.join('  '),
              style: AppTextStyles.tag,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(project.title, style: AppTextStyles.cardTitle),
                const SizedBox(height: 12),
                SelectableText(project.description, style: AppTextStyles.body),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: _links(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _links() {
    final links = <Widget>[];
    if (project.liveUrl != null) {
      links.add(CodeButton(
        label: 'Live <~>',
        onPressed: () => openUrl(project.liveUrl!),
      ));
    }
    if (project.appStoreUrl != null) {
      links.add(CodeButton(
        label: 'App Store <~>',
        onPressed: () => openUrl(project.appStoreUrl!),
      ));
    }
    if (project.playStoreUrl != null) {
      links.add(CodeButton(
        label: 'Play Store <~>',
        onPressed: () => openUrl(project.playStoreUrl!),
      ));
    }
    return links;
  }
}

class _Preview extends StatelessWidget {
  final Project project;
  const _Preview({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: project.imageAsset != null
          ? Image.asset(project.imageAsset!, fit: BoxFit.cover)
          : Center(
              child: Text(
                '</${project.title.split(' ').first.toLowerCase()}>',
                style: AppTextStyles.tagPrimary,
              ),
            ),
    );
  }
}
