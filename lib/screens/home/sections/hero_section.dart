import 'package:flutter/material.dart';
import 'package:portfolio/constants/images.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/decorations.dart';
import 'package:portfolio/screens/home/widgets/parallax_scene.dart';
import 'package:portfolio/screens/home/widgets/reveal_on_scroll.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/status_badge.dart';
import 'package:portfolio/screens/home/widgets/tilt_3d.dart';
import 'package:portfolio/screens/home/widgets/wireframe_cube.dart';
import 'package:portfolio/services/analytics/analytics.dart';
import 'package:provider/provider.dart';

/// The landing hero: a parallax 3D scene (floating wireframe cube + glow behind
/// a tilting portrait) paired with a staggered fly-in headline.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return SectionContainer(
      topPadding: 48,
      bottomPadding: 64,
      child: ParallaxScene(
        builder: (context, pointer) => isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _HeroImage(pointer: pointer),
                  const SizedBox(height: 32),
                  const _HeroText(centered: true),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Expanded(flex: 3, child: _HeroText(centered: false)),
                  const SizedBox(width: 24),
                  Expanded(flex: 2, child: _HeroImage(pointer: pointer)),
                ],
              ),
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  final bool centered;
  const _HeroText({required this.centered});

  @override
  Widget build(BuildContext context) {
    final align =
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: align,
      mainAxisSize: MainAxisSize.min,
      children: [
        RevealOnScroll(
          child: SelectableText(
            PortfolioData.heroHeadline,
            style: AppTextStyles.heroTitleFor(context.isMobile),
            textAlign: textAlign,
          ),
        ),
        const SizedBox(height: 16),
        RevealOnScroll(
          delay: const Duration(milliseconds: 110),
          child: SelectableText(
            PortfolioData.heroSubtitle,
            style: AppTextStyles.heroSubtitle,
            textAlign: textAlign,
          ),
        ),
        const SizedBox(height: 24),
        RevealOnScroll(
          delay: const Duration(milliseconds: 220),
          child: CodeButton(
            label: 'Contact me!!',
            onPressed: () => context.read<NavigationProvider>().scrollTo(
                  PortfolioSection.contacts,
                  source: AnalyticsPlacements.heroCta,
                ),
          ),
        ),
      ],
    );
  }
}

class _HeroImage extends StatelessWidget {
  /// Smoothed pointer fraction (-0.5..0.5) from the enclosing [ParallaxScene].
  final Offset pointer;
  const _HeroImage({required this.pointer});

  @override
  Widget build(BuildContext context) {
    final imageSize = Responsive.value<double>(
      context,
      mobile: 240,
      tablet: 300,
      desktop: 340,
    );
    final cubeSize = imageSize * 0.5;
    final stageSize = imageSize + 80;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: stageSize,
          height: stageSize,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Depth layer 1 (deepest): soft blue glow drifting slowly.
              Transform.translate(
                offset: pointer * 14,
                child: Container(
                  width: imageSize * 0.9,
                  height: imageSize * 0.9,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.primaryGlow, AppColors.transparent],
                    ),
                  ),
                ),
              ),
              // Depth layer 2: the floating 3D wireframe cube.
              Positioned(
                top: -18,
                right: -8,
                child: Transform.translate(
                  offset: pointer * 34,
                  child: WireframeCube(
                    size: cubeSize,
                    pointerInfluence: pointer,
                  ),
                ),
              ),
              // Depth layer 3: dot grid accent.
              Positioned(
                right: 0,
                bottom: 0,
                child: Transform.translate(
                  offset: pointer * 22,
                  child: const DotGrid(rows: 5, columns: 5, color: AppColors.gray),
                ),
              ),
              // Foreground: the portrait, tilting toward the cursor as it reveals.
              RevealOnScroll(
                child: Tilt3D(
                  child: Container(
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
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const RevealOnScroll(
          delay: Duration(milliseconds: 160),
          child: StatusBadge(text: PortfolioData.currentlyWorkingOn),
        ),
      ],
    );
  }
}
