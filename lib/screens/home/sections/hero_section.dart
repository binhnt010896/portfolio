import 'package:flutter/material.dart';
import 'package:portfolio/constants/images.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/decorations.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/status_badge.dart';
import 'package:provider/provider.dart';

/// The landing hero: headline, intro, CTA and a decorated profile image.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return SectionContainer(
      topPadding: 48,
      bottomPadding: 64,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                _HeroImage(),
                SizedBox(height: 32),
                _HeroText(centered: true),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Expanded(flex: 3, child: _HeroText(centered: false)),
                SizedBox(width: 24),
                Expanded(flex: 2, child: _HeroImage()),
              ],
            ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool centered;
  const _HeroText({required this.centered});

  @override
  Widget build(BuildContext context) {
    final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        SelectableText(
          PortfolioData.heroHeadline,
          style: AppTextStyles.heroTitleFor(context.isMobile),
          textAlign: textAlign,
        ),
        const SizedBox(height: 16),
        SelectableText(
          PortfolioData.heroSubtitle,
          style: AppTextStyles.heroSubtitle,
          textAlign: textAlign,
        ),
        const SizedBox(height: 24),
        CodeButton(
          label: 'Contact me!!',
          onPressed: () =>
              context.read<NavigationProvider>().scrollTo(PortfolioSection.contacts),
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    final imageSize = Responsive.value<double>(
      context,
      mobile: 240,
      tablet: 300,
      desktop: 340,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: imageSize + 40,
          height: imageSize + 40,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: DotGrid(
                  rows: 5,
                  columns: 5,
                  color: AppColors.gray,
                ),
              ),
              Container(
                width: imageSize,
                height: imageSize,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary, width: 1),
                  image: const DecorationImage(
                    image: AssetImage(ImagesDirectory.avatar),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const StatusBadge(text: PortfolioData.currentlyWorkingOn),
      ],
    );
  }
}
