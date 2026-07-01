import 'package:flutter/material.dart';

/// Wraps [child] in an interactive 3D perspective tilt that follows the cursor
/// (the subtle "the object leans toward you" effect from Apple product pages).
///
/// On pointer devices the child rotates about the X/Y axes toward the cursor
/// and lifts slightly on hover. Touch devices have no hover, so the child
/// simply renders flat — that is the intended responsive behaviour (mobile gets
/// the scroll reveals instead). The tilt is disabled entirely when the OS
/// "reduce motion" setting is on.
///
/// Only transforms are animated, so this never causes a layout reflow.
class Tilt3D extends StatefulWidget {
  final Widget child;

  /// Maximum rotation about each axis, in radians.
  final double maxTilt;

  /// How much the child scales up while hovered.
  final double hoverScale;

  const Tilt3D({
    super.key,
    required this.child,
    this.maxTilt = 0.12,
    this.hoverScale = 1.03,
  });

  @override
  State<Tilt3D> createState() => _Tilt3DState();
}

class _Tilt3DState extends State<Tilt3D> {
  // Pointer position as a fraction of the widget from its centre (-0.5..0.5).
  Offset _pointer = Offset.zero;
  bool _hovering = false;

  void _updatePointer(Offset localPosition, Size size) {
    if (size.width == 0 || size.height == 0) return;
    setState(() {
      _pointer = Offset(
        (localPosition.dx / size.width) - 0.5,
        (localPosition.dy / size.height) - 0.5,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      return widget.child;
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        final target = _hovering ? _pointer : Offset.zero;
        final scale = _hovering ? widget.hoverScale : 1.0;

        return MouseRegion(
          onEnter: (_) => setState(() => _hovering = true),
          onHover: (event) => _updatePointer(event.localPosition, size),
          onExit: (_) => setState(() {
            _hovering = false;
            _pointer = Offset.zero;
          }),
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(end: target),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              final matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.0012) // perspective depth
                ..rotateX(-value.dy * widget.maxTilt)
                ..rotateY(value.dx * widget.maxTilt)
                ..scaleByDouble(scale, scale, scale, 1);
              return Transform(
                alignment: Alignment.center,
                transform: matrix,
                child: child,
              );
            },
            child: widget.child,
          ),
        );
      },
    );
  }
}
