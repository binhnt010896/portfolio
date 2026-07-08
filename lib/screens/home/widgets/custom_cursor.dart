import 'package:flutter/material.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/providers/cursor_provider.dart';
import 'package:provider/provider.dart';

/// Wraps the whole app (via `MaterialApp.builder`) to replace the system
/// cursor with a custom ring + dot that morphs over interactive elements.
///
/// The overlay renders above the Navigator, so it also covers dialogs. It
/// ignores pointers and only appears after a mouse hover event, keeping touch
/// devices unaffected.
class CursorArena extends StatelessWidget {
  final Widget child;

  const CursorArena({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final cursor = context.read<CursorProvider>();
    return MouseRegion(
      opaque: false,
      cursor: SystemMouseCursors.none,
      onHover: (event) => cursor.move(event.position),
      onExit: (_) => cursor.hide(),
      child: Stack(
        textDirection: TextDirection.ltr,
        children: [
          child,
          const Positioned.fill(
            child: IgnorePointer(child: _CursorOverlay()),
          ),
        ],
      ),
    );
  }
}

/// The painted cursor itself: a ring + centre dot that collapses into a
/// single solid dot while hovering an interactive element (whose corner
/// brackets take over as the "selection" visual).
class _CursorOverlay extends StatelessWidget {
  static const double _boxSize = 48;

  const _CursorOverlay();

  @override
  Widget build(BuildContext context) {
    final cursor = context.watch<CursorProvider>();
    final position = cursor.position;
    if (position == null) return const SizedBox.shrink();

    final interactive = cursor.hoveringInteractive;

    return Stack(
      textDirection: TextDirection.ltr,
      children: [
        Positioned(
          left: position.dx - _boxSize / 2,
          top: position.dy - _boxSize / 2,
          width: _boxSize,
          height: _boxSize,
          child: Stack(
            alignment: Alignment.center,
            textDirection: TextDirection.ltr,
            children: [
              // Ring: shrinks onto the dot and fades away over interactives.
              AnimatedOpacity(
                duration: const Duration(milliseconds: 160),
                opacity: interactive ? 0.0 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  curve: Curves.easeOut,
                  width: interactive ? 6.0 : 20.0,
                  height: interactive ? 6.0 : 20.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                ),
              ),
              // Dot: grows slightly to become the whole cursor.
              AnimatedContainer(
                duration: const Duration(milliseconds: 160),
                curve: Curves.easeOut,
                width: interactive ? 7.0 : 4.0,
                height: interactive ? 7.0 : 4.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Marks its subtree as an interactive cursor target: hides the system
/// cursor (the [CursorArena] overlay takes over) and morphs the custom
/// cursor while hovered.
class CursorTarget extends StatefulWidget {
  final Widget child;

  const CursorTarget({super.key, required this.child});

  @override
  State<CursorTarget> createState() => _CursorTargetState();
}

class _CursorTargetState extends State<CursorTarget> {
  bool _inside = false;
  CursorProvider? _cursor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cursor = context.read<CursorProvider>();
  }

  @override
  void dispose() {
    // If the widget disappears mid-hover (e.g. navigation), release the flag
    // after the frame — notifying during teardown would hit the build lock.
    if (_inside) {
      final cursor = _cursor;
      if (cursor != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          cursor.exitInteractive();
        });
      }
      _inside = false;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursor = context.read<CursorProvider>();
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      onEnter: (_) {
        _inside = true;
        cursor.enterInteractive();
      },
      onExit: (_) {
        _inside = false;
        cursor.exitInteractive();
      },
      child: widget.child,
    );
  }
}
