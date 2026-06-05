import 'package:flutter/material.dart';
import 'package:portfolio/helpers/responsive.dart';

/// Centres a section's content within [Responsive.maxContentWidth] and applies
/// responsive horizontal + vertical padding.
class SectionContainer extends StatelessWidget {
  final Widget child;
  final double topPadding;
  final double bottomPadding;

  const SectionContainer({
    super.key,
    required this.child,
    this.topPadding = 56,
    this.bottomPadding = 56,
  });

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 32,
      desktop: 24,
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontal,
        topPadding,
        horizontal,
        bottomPadding,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Responsive.maxContentWidth,
          ),
          child: child,
        ),
      ),
    );
  }
}
