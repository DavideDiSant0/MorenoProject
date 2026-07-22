import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repair_parts_finder/main.dart';

void main() {
  testWidgets('Bootstrap app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
