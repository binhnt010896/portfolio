import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';

/// A genuine spinning 3D wireframe cube, drawn from first principles: eight
/// vertices are rotated in 3D, projected through a perspective transform and
/// connected by twelve edges whose brightness/width follows their depth (near
/// edges glow blue, far edges fade back). It fits the "code-editor" wireframe
/// aesthetic and is the site's signature 3D object.
///
/// The rotation runs continuously, but honours the OS "reduce motion" setting
/// by freezing at a pleasant isometric angle instead of spinning.
///
/// [pointerInfluence] (fraction -0.5..0.5 on each axis) lets the hero nudge the
/// cube toward the cursor for an interactive, parallax feel.
class WireframeCube extends StatefulWidget {
  final double size;
  final Offset pointerInfluence;

  const WireframeCube({
    super.key,
    this.size = 180,
    this.pointerInfluence = Offset.zero,
  });

  @override
  State<WireframeCube> createState() => _WireframeCubeState();
}

class _WireframeCubeState extends State<WireframeCube>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 16),
  );

  @override
  void initState() {
    super.initState();
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    Widget painter(double t) => CustomPaint(
          size: Size.square(widget.size),
          painter: _CubePainter(
            t: t,
            pointer: widget.pointerInfluence,
          ),
        );

    if (reduceMotion) {
      return painter(0.08); // fixed, static isometric pose
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) => painter(_controller.value),
    );
  }
}

class _CubePainter extends CustomPainter {
  final double t;
  final Offset pointer;

  _CubePainter({required this.t, required this.pointer});

  // Unit cube corners.
  static const List<List<double>> _corners = [
    [-1, -1, -1],
    [1, -1, -1],
    [1, 1, -1],
    [-1, 1, -1],
    [-1, -1, 1],
    [1, -1, 1],
    [1, 1, 1],
    [-1, 1, 1],
  ];

  // The twelve edges as index pairs into [_corners].
  static const List<List<int>> _edges = [
    [0, 1], [1, 2], [2, 3], [3, 0], // back face
    [4, 5], [5, 6], [6, 7], [7, 4], // front face
    [0, 4], [1, 5], [2, 6], [3, 7], // connectors
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = size.width * 0.3;

    final angleY = t * 2 * math.pi + pointer.dx * 0.9;
    final angleX = 0.5 + 0.14 * math.sin(t * 2 * math.pi) + pointer.dy * 0.6;

    final cosY = math.cos(angleY), sinY = math.sin(angleY);
    final cosX = math.cos(angleX), sinX = math.sin(angleX);

    // Project every corner to 2D (with its depth retained for shading).
    final projected = <Offset>[];
    final depths = <double>[];
    for (final c in _corners) {
      var x = c[0].toDouble(), y = c[1].toDouble(), z = c[2].toDouble();

      // Rotate about Y, then X.
      final x1 = x * cosY + z * sinY;
      final z1 = -x * sinY + z * cosY;
      final y2 = y * cosX - z1 * sinX;
      final z2 = y * sinX + z1 * cosX;
      x = x1;
      y = y2;
      z = z2;

      const viewDistance = 4.0;
      final perspective = viewDistance / (viewDistance - z);
      projected.add(center + Offset(x * scale * perspective, y * scale * perspective));
      depths.add(z); // -1 (far) .. 1 (near)
    }

    // Draw edges back-to-front so nearer, brighter edges sit on top.
    final order = List<int>.generate(_edges.length, (i) => i)
      ..sort((a, b) {
        final da = depths[_edges[a][0]] + depths[_edges[a][1]];
        final db = depths[_edges[b][0]] + depths[_edges[b][1]];
        return da.compareTo(db);
      });

    for (final i in order) {
      final e = _edges[i];
      final depth = (depths[e[0]] + depths[e[1]]) / 2; // -1..1
      final f = ((depth + 1) / 2).clamp(0.0, 1.0); // 0 far .. 1 near
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 1.0 + f * 1.4
        ..color = Color.lerp(AppColors.wireframeBack, AppColors.primary, f)!;
      canvas.drawLine(projected[e[0]], projected[e[1]], paint);
    }

    // Vertices as small dots, brighter when nearer.
    for (var i = 0; i < projected.length; i++) {
      final f = ((depths[i] + 1) / 2).clamp(0.0, 1.0);
      final paint = Paint()
        ..style = PaintingStyle.fill
        ..color = Color.lerp(AppColors.wireframeBack, AppColors.primary, f)!;
      canvas.drawCircle(projected[i], 1.6 + f * 1.8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CubePainter old) =>
      old.t != t || old.pointer != pointer;
}
