import 'package:flutter/material.dart';

/// Tracks the pointer over its area and hands a smoothed position fraction
/// (-0.5..0.5 on each axis, `Offset.zero` at centre / when the pointer leaves)
/// to [builder]. Layers inside can multiply that fraction by their own "depth"
/// to drift at different speeds, producing the layered parallax depth seen on
/// Apple product pages.
///
/// Touch devices (no hover) simply receive `Offset.zero`, and the effect is
/// switched off when the OS "reduce motion" setting is enabled.
class ParallaxScene extends StatefulWidget {
  final Widget Function(BuildContext context, Offset pointer) builder;

  const ParallaxScene({super.key, required this.builder});

  @override
  State<ParallaxScene> createState() => _ParallaxSceneState();
}

class _ParallaxSceneState extends State<ParallaxScene> {
  Offset _pointer = Offset.zero;

  void _update(Offset localPosition, Size size) {
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
      return widget.builder(context, Offset.zero);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _update(e.localPosition, size),
          onExit: (_) => setState(() => _pointer = Offset.zero),
          child: TweenAnimationBuilder<Offset>(
            tween: Tween<Offset>(end: _pointer),
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            builder: (context, value, _) => widget.builder(context, value),
          ),
        );
      },
    );
  }
}
