import 'package:flutter/material.dart';

/// Tracks the mouse for the custom "ring + dot" cursor overlay
/// (codedgar-style). Widgets flag themselves as interactive via
/// [enterInteractive]/[exitInteractive] so the cursor can morph over them.
///
/// The overlay only appears once a real mouse hover event arrives, so touch
/// devices never see it.
class CursorProvider extends ChangeNotifier {
  Offset? _position;
  Offset? get position => _position;

  /// True once a mouse pointer has been seen inside the app.
  bool get visible => _position != null;

  int _interactiveCount = 0;

  /// True while the pointer is over an interactive element (button, link…).
  bool get hoveringInteractive => _interactiveCount > 0;

  void move(Offset position) {
    _position = position;
    notifyListeners();
  }

  void hide() {
    if (_position == null) return;
    _position = null;
    notifyListeners();
  }

  void enterInteractive() {
    _interactiveCount++;
    notifyListeners();
  }

  void exitInteractive() {
    if (_interactiveCount == 0) return;
    _interactiveCount--;
    notifyListeners();
  }
}
