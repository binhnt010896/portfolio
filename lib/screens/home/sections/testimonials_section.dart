import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';

/// `# testimonials` — quotes from supervisors, each linking to their
/// LinkedIn profile.
class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  static const double _gap = 24;

  @override
  Widget build(BuildContext context) {
    final sideBySide = context.isDesktop;
    final testimonials = PortfolioData.testimonials;
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionHeading(title: 'testimonials', index: 4),
          ),
          const SizedBox(height: 8),
          if (sideBySide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < testimonials.length; i++) ...[
                  if (i > 0) const SizedBox(width: _gap),
                  Expanded(
                    child: RevealOnScroll(
                      delay: Duration(milliseconds: 90 * i),
                      child: _TestimonialCard(testimonial: testimonials[i]),
                    ),
                  ),
                ],
              ],
            )
          else
            Column(
              children: [
                for (var i = 0; i < testimonials.length; i++) ...[
                  if (i > 0) const SizedBox(height: _gap),
                  RevealOnScroll(
                    child: _TestimonialCard(testimonial: testimonials[i]),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        color: AppColors.cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Image.asset(
                    testimonial.avatarAsset,
                    width: 64,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(
                        testimonial.name,
                        style: AppTextStyles.bold,
                      ),
                      const SizedBox(height: 4),
                      SelectableText(
                        testimonial.title,
                        style: AppTextStyles.tagPrimary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SelectableText(testimonial.quote, style: AppTextStyles.body),
            const SizedBox(height: 20),
            CodeTextLink(
              label: 'LinkedIn ~~>',
              onPressed: () => openUrl(testimonial.linkedinUrl),
            ),
          ],
        ),
      ),
    );
  }
}
