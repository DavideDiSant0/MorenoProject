import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/main.dart';

void main() {
  testWidgets('Desktop shell smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Search'), findsWidgets);
    expect(find.text('Selection'), findsOneWidget);
    expect(find.text('No URL preview generated.'), findsOneWidget);
  });

  testWidgets('Navigation rail opens catalog route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Catalog').first);
    await tester.pumpAndSettle();

    expect(find.text('Catalog'), findsWidgets);
    expect(find.text('Device types'), findsWidgets);
  });

  testWidgets('Navigation rail opens suppliers route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Suppliers').first);
    await tester.pumpAndSettle();

    expect(find.text('Suppliers'), findsWidgets);
    expect(find.text('Supplier list'), findsOneWidget);
    expect(find.text('iFixit'), findsWidgets);
  });

  testWidgets('Navigation rail opens history route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('History').first);
    await tester.pumpAndSettle();

    expect(find.text('History'), findsWidgets);
    expect(find.text('Saved searches'), findsOneWidget);
    expect(find.text('No saved searches yet.'), findsOneWidget);
  });

  testWidgets('Navigation rail opens favorites route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Favorites').first);
    await tester.pumpAndSettle();

    expect(find.text('Favorites'), findsWidgets);
    expect(find.text('Saved combinations'), findsOneWidget);
    expect(find.text('iPhone 13 display'), findsWidgets);
  });

  testWidgets('Navigation rail opens settings route', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings').first);
    await tester.pumpAndSettle();

    expect(find.text('Settings'), findsWidgets);
    expect(find.text('Maximum pages to open'), findsOneWidget);
    expect(find.text('Require confirmation'), findsOneWidget);
    expect(find.text('Save search history'), findsOneWidget);
  });

  testWidgets('Settings route updates history preference', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Settings').first);
    await tester.pumpAndSettle();

    final historySwitch = find.widgetWithText(
      SwitchListTile,
      'Save search history',
    );

    expect(tester.widget<SwitchListTile>(historySwitch).value, isTrue);

    await tester.tap(find.text('Save search history'));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(historySwitch).value, isFalse);

    await tester.tap(find.byTooltip('Refresh'));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(historySwitch).value, isFalse);
  });
}

Widget buildTestApp() {
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWith((ref) async {
        final database = AppDatabase(NativeDatabase.memory());
        await AppDemoDataSeeder(database).seedIfEmpty();
        ref.onDispose(() => unawaited(database.close()));
        return database;
      }),
    ],
    child: const RepairPartsFinderApp(),
  );
}
