import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/helpers/url_helper.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';

/// A single tappable social SVG icon that brightens on hover.
class SocialIcon extends StatefulWidget {
  final String iconAsset;
  final String url;
  final double size;

  const SocialIcon({
    super.key,
    required this.iconAsset,
    required this.url,
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
          onTap: () => openUrl(widget.url),
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
