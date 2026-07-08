import 'package:flutter/material.dart';
import 'package:portfolio/constants/images.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/decorations.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';

/// `# about-me` — bio text alongside a decorated portrait.
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    final bio = RevealOnScroll(
      from: isMobile ? RevealFrom.bottom : RevealFrom.left,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(PortfolioData.aboutMe, style: AppTextStyles.body),
        ],
      ),
    );

    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(child: SectionHeading(title: 'about-me', index: 3)),
          const SizedBox(height: 8),
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bio,
                const SizedBox(height: 32),
                const Center(child: _Portrait()),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 3, child: bio),
                const SizedBox(width: 40),
                const Expanded(flex: 2, child: _Portrait()),
              ],
            ),
        ],
      ),
    );
  }
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) {
    final size = Responsive.value<double>(
      context,
      mobile: 240,
      tablet: 280,
      desktop: 320,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: DotGrid(rows: 3, columns: 5),
        ),
        const SizedBox(height: 12),
        RevealOnScroll(
          from: RevealFrom.right,
          child: Tilt3D(
            maxTilt: 0.08,
            child: Container(
              width: size,
              height: size * 1.2,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                image: const DecorationImage(
                  image: AssetImage(ImagesDirectory.avatar2),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
