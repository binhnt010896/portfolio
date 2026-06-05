import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/screens/home/widgets/app_header.dart';
import 'package:portfolio/screens/home/widgets/nav_link.dart';

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  VisibilityDetectorController.instance.updateInterval = Duration.zero;
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const PortfolioApp());
  await tester.pump(const Duration(milliseconds: 100));
}

void main() {
  for (final entry in {
    'mobile': const Size(390, 1600),
    'tablet': const Size(800, 1400),
    'desktop': const Size(1440, 1200),
  }.entries) {
    testWidgets('lays out without overflow on ${entry.key}', (tester) async {
      await _pumpAt(tester, entry.value);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('shows burger on mobile, inline nav on desktop', (tester) async {
    await _pumpAt(tester, const Size(390, 1600));
    expect(find.byIcon(Icons.menu), findsOneWidget);

    await _pumpAt(tester, const Size(1440, 1200));
    expect(find.byIcon(Icons.menu), findsNothing);
    // 5 inline nav links present on desktop.
    expect(find.byType(NavLink), findsNWidgets(AppHeader.navSections.length));
  });
}
