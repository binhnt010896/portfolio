import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// The direction a [RevealOnScroll] child travels in from as it fades in.
enum RevealFrom { bottom, left, right, top }

/// A scroll-triggered "fly-in" wrapper (Apple-style section reveal).
///
/// The first time the child scrolls into view it animates from a small offset
/// + slight scale + zero opacity to its resting state. It only plays once, and
/// it fully respects the platform "reduce motion" accessibility setting
/// (`MediaQuery.disableAnimations`) — in that case the child is shown instantly.
///
/// Only `Transform` and `Opacity` are animated (never layout properties) so the
/// reveal stays on the compositor and never triggers a reflow.
class RevealOnScroll extends StatefulWidget {
  final Widget child;

  /// Delay before this item starts animating — use an increasing value across
  /// siblings to stagger a grid/list (30–50ms per item works well).
  final Duration delay;

  /// How far (in logical px) the child travels while flying in.
  final double distance;

  /// Which edge the child flies in from.
  final RevealFrom from;

  /// Fraction of the widget that must be visible before the reveal fires.
  final double threshold;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.distance = 48,
    this.from = RevealFrom.bottom,
    this.threshold = 0.12,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 620),
  );
  late final Animation<double> _t = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  // Stable key for the VisibilityDetector across rebuilds.
  final Key _detectorKey = UniqueKey();
  bool _revealed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibility(VisibilityInfo info) {
    if (_revealed) return;
    if (info.visibleFraction < widget.threshold) return;
    _revealed = true;
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  Offset _offsetFor(double t) {
    final travel = widget.distance * (1 - t);
    switch (widget.from) {
      case RevealFrom.bottom:
        return Offset(0, travel);
      case RevealFrom.top:
        return Offset(0, -travel);
      case RevealFrom.left:
        return Offset(-travel, 0);
      case RevealFrom.right:
        return Offset(travel, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Honour the OS "reduce motion" setting: show instantly, no animation.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) {
      return widget.child;
    }

    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibility,
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final t = _t.value;
          return Opacity(
            opacity: t.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: _offsetFor(t),
              child: Transform.scale(
                scale: 0.97 + 0.03 * t,
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
