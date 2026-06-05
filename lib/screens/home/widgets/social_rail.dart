import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/screens/home/widgets/social_icon.dart';

/// The fixed vertical social rail pinned to the left edge on desktop:
/// a vertical line rising from a column of social icons.
class SocialRail extends StatelessWidget {
  const SocialRail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(width: 1, height: 220, color: AppColors.border),
        const SizedBox(height: 24),
        for (final social in PortfolioData.socials)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SocialIcon(
              iconAsset: social.iconAsset,
              url: social.url,
              size: 24,
            ),
          ),
      ],
    );
  }
}
