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
    final columns = context.isMobile ? 1 : 2;
    final testimonials = PortfolioData.testimonials;
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionHeading(title: 'testimonials', index: 4),
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth =
                  (constraints.maxWidth - _gap * (columns - 1)) / columns;
              return Wrap(
                spacing: _gap,
                runSpacing: _gap,
                children: [
                  for (var i = 0; i < testimonials.length; i++)
                    SizedBox(
                      width: cardWidth,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 90 * (i % columns)),
                        child: _TestimonialCard(testimonial: testimonials[i]),
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

class _TestimonialCard extends StatefulWidget {
  final Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  static const int _collapsedLines = 5;
  static const double _padding = 24;

  bool _expanded = false;

  /// Whether [text] needs more than [_collapsedLines] lines at [width].
  bool _overflows(String text, double width) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: AppTextStyles.body),
      maxLines: _collapsedLines,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.textScalerOf(context),
    )..layout(maxWidth: width);
    final overflowing = painter.didExceedMaxLines;
    painter.dispose();
    return overflowing;
  }

  @override
  Widget build(BuildContext context) {
    final testimonial = widget.testimonial;
    final avatar = testimonial.avatarAsset;
    final linkedinUrl = testimonial.linkedinUrl;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        color: AppColors.cardBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(_padding),
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
                  child: avatar != null
                      ? Image.asset(
                          avatar,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          width: 64,
                          height: 64,
                          child: Icon(
                            Icons.person_outline,
                            color: AppColors.primary,
                            size: 32,
                          ),
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
            LayoutBuilder(
              builder: (context, constraints) {
                final canExpand =
                    _overflows(testimonial.quote, constraints.maxWidth);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SelectableText(
                      testimonial.quote,
                      style: AppTextStyles.body,
                      maxLines: _expanded ? null : _collapsedLines,
                    ),
                    if (canExpand) ...[
                      const SizedBox(height: 12),
                      CodeTextLink(
                        label: _expanded ? 'Show less' : 'Show more',
                        onPressed: () =>
                            setState(() => _expanded = !_expanded),
                      ),
                    ],
                  ],
                );
              },
            ),
            if (linkedinUrl != null) ...[
              const SizedBox(height: 20),
              CodeTextLink(
                label: 'LinkedIn ~~>',
                onPressed: () => openUrl(linkedinUrl),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
