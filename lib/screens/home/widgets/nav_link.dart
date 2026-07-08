import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/providers/navigation_provider.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';

/// A `#label` header navigation link that highlights when its section is the
/// active one or on hover.
class NavLink extends StatefulWidget {
  final PortfolioSection section;
  final bool active;
  final VoidCallback onTap;

  const NavLink({
    super.key,
    required this.section,
    required this.active,
    required this.onTap,
  });

  @override
  State<NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<NavLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.active || _hovering;
    return CursorTarget(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: RichText(
              text: TextSpan(
                text: '#',
                style: AppTextStyles.navHash,
                children: [
                  TextSpan(
                    text: widget.section.label,
                    style: highlighted
                        ? AppTextStyles.navLinkActive
                        : AppTextStyles.navLink,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
