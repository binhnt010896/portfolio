import 'package:flutter/foundation.dart';

class ScrollOverseer with ChangeNotifier, DiagnosticableTreeMixin {
  double currentPage = 0;

  void updatePage(double newValue) {
    currentPage = newValue;
    notifyListeners();
  }
}