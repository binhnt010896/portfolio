import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/main.dart';

void main() {
  testWidgets('renders the hero headline', (WidgetTester tester) async {
    // Fire VisibilityDetector callbacks immediately so no timer is left pending.
    VisibilityDetectorController.instance.updateInterval = Duration.zero;

    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();

    expect(find.text(PortfolioData.heroHeadline), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
