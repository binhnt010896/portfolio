import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/services/analytics/analytics.dart';

/// A single tappable social SVG icon that brightens on hover.
class SocialIcon extends StatefulWidget {
  final String iconAsset;
  final String url;
  final double size;

  /// Which network this is (e.g. `GitHub`) — reported as the analytics label.
  final String label;

  /// Where on the page the icon sits — see [AnalyticsPlacements]. The rail and
  /// the footer show the same links, so this is what separates them in PostHog.
  final String placement;

  const SocialIcon({
    super.key,
    required this.iconAsset,
    required this.url,
    required this.label,
    required this.placement,
    this.size = 32,
  });

  @override
  State<SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<SocialIcon> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return CursorTarget(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: () => openUrl(
            widget.url,
            label: widget.label,
            placement: widget.placement,
          ),
          child: SvgPicture.asset(
            widget.iconAsset,
            width: widget.size,
            height: widget.size,
            colorFilter: ColorFilter.mode(
              _hovering ? AppColors.white : AppColors.gray,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
