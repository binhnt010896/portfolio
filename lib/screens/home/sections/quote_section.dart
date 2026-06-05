import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';

/// A decorative pull-quote in a bordered box with an attribution chip.
class QuoteSection extends StatelessWidget {
  const QuoteSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final markStyle = AppTextStyles.sectionTitleFor(isMobile);
    return SectionContainer(
      topPadding: 48,
      bottomPadding: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: AppColors.border)),
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 40,
              vertical: isMobile ? 28 : 40,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('"', style: markStyle),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    PortfolioData.quote,
                    style: AppTextStyles.quoteFor(isMobile),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 12),
                Text('"', style: markStyle),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: -18,
            child: Container(
              color: AppColors.background,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: DecoratedBox(
                decoration:
                    BoxDecoration(border: Border.all(color: AppColors.border)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    PortfolioData.quoteAuthor,
                    style: AppTextStyles.bodyWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
