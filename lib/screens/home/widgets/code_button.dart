import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';

/// A bordered, monospace call-to-action button matching the design's
/// code-editor aesthetic (e.g. `Contact me!!`, `View all ~~>`).
///
/// On hover, four corner brackets slide outward from the border — a
/// "selection" effect echoing codedgar.com — while the custom cursor
/// collapses to a dot over it.
class CodeButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final bool filled;

  const CodeButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.filled = false,
  });

  @override
  State<CodeButton> createState() => _CodeButtonState();
}

class _CodeButtonState extends State<CodeButton> {
  bool _hovering = false;

  /// Room around the button reserved for the brackets to slide into.
  static const double _bracketRoom = 8;

  @override
  Widget build(BuildContext context) {
    final bool activeFill = widget.filled || _hovering;
    return CursorTarget(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: _hovering ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            builder: (context, t, child) => CustomPaint(
              foregroundPainter: _CornerBracketsPainter(t),
              child: child,
            ),
            child: Padding(
              padding: const EdgeInsets.all(_bracketRoom),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  color: activeFill ? AppColors.scrim : AppColors.transparent,
                ),
                child: Text(widget.label, style: AppTextStyles.button),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints four L-shaped corner brackets that slide outward and fade in as
/// [t] goes 0 → 1, plus a small "target" dot beside the top-right corner.
class _CornerBracketsPainter extends CustomPainter {
  final double t;

  static const double _arm = 10;

  const _CornerBracketsPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    if (t == 0) return;

    // Brackets travel from hugging the border (inset 8) to the outer
    // corners (inset 1) while fading in.
    final inset = 8.0 - 7.0 * t;
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: t)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final left = inset;
    final top = inset;
    final right = size.width - inset;
    final bottom = size.height - inset;

    void corner(Offset elbow, Offset dxArm, Offset dyArm) {
      final path = Path()
        ..moveTo(elbow.dx + dxArm.dx, elbow.dy + dxArm.dy)
        ..lineTo(elbow.dx, elbow.dy)
        ..lineTo(elbow.dx + dyArm.dx, elbow.dy + dyArm.dy);
      canvas.drawPath(path, paint);
    }

    corner(Offset(left, top), const Offset(_arm, 0), const Offset(0, _arm));
    corner(Offset(right, top), const Offset(-_arm, 0), const Offset(0, _arm));
    corner(
        Offset(left, bottom), const Offset(_arm, 0), const Offset(0, -_arm));
    corner(
        Offset(right, bottom), const Offset(-_arm, 0), const Offset(0, -_arm));
  }

  @override
  bool shouldRepaint(_CornerBracketsPainter oldDelegate) => oldDelegate.t != t;
}

/// A subtle inline text link with a trailing symbol, e.g. `Read more ->`.
/// Brightens to the accent colour on hover.
class CodeTextLink extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const CodeTextLink({super.key, required this.label, required this.onPressed});

  @override
  State<CodeTextLink> createState() => _CodeTextLinkState();
}

class _CodeTextLinkState extends State<CodeTextLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return CursorTarget(
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 120),
            style: _hovering ? AppTextStyles.navHash : AppTextStyles.button,
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
