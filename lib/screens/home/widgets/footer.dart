import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/app_logo.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/social_icon.dart';
import 'package:portfolio/services/analytics/analytics.dart';

/// Site footer: branding + contact on the left, social links on the right,
/// and a copyright line.
class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      children: [
        const Divider(color: AppColors.border, height: 1, thickness: 1),
        SectionContainer(
          topPadding: 40,
          bottomPadding: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: isMobile ? 0 : 3,
                    child: const _Branding(),
                  ),
                  if (isMobile) const SizedBox(height: 24),
                  const _Media(),
                ],
              ),
              const SizedBox(height: 32),
              SelectableText(
                '© Copyright 2026. Made by ${PortfolioData.fullName}',
                style: AppTextStyles.copyright,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Branding extends StatelessWidget {
  const _Branding();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppLogo(),
            const SizedBox(width: 16),
            Flexible(
              child: CursorTarget(
                child: GestureDetector(
                  onTap: () => openUrl(
                    'mailto:${PortfolioData.email}',
                    label: AnalyticsLinkLabels.email,
                    placement: AnalyticsPlacements.footer,
                  ),
                  child: Text(
                    PortfolioData.email,
                    style: AppTextStyles.body,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SelectableText(PortfolioData.role, style: AppTextStyles.bodyWhite),
      ],
    );
  }
}

class _Media extends StatelessWidget {
  const _Media();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText('Media', style: AppTextStyles.bold),
        const SizedBox(height: 12),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final social in PortfolioData.socials)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: SocialIcon(
                  iconAsset: social.iconAsset,
                  url: social.url,
                  label: social.label,
                  placement: AnalyticsPlacements.footer,
                  size: 28,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
