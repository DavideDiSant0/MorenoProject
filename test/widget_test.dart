import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repair_parts_finder/main.dart';

void main() {
  testWidgets('Desktop shell smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RepairPartsFinderApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Search'), findsWidgets);
  });

  testWidgets('Navigation rail opens catalog route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const RepairPartsFinderApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Catalog').first);
    await tester.pumpAndSettle();

    expect(find.text('Catalog'), findsWidgets);
    expect(find.text('Device types'), findsOneWidget);
  });
}
