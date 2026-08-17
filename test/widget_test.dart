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
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Ricerca'), findsWidgets);
    expect(find.text('Selezione'), findsOneWidget);
    expect(find.text('Nessuna anteprima URL generata.'), findsOneWidget);
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

    await tester.tap(find.text('Catalogo').first);
    await tester.pumpAndSettle();

    expect(find.text('Catalogo'), findsWidgets);
    expect(find.text('Tipi di dispositivo'), findsWidgets);
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

    await tester.tap(find.text('Fornitori').first);
    await tester.pumpAndSettle();

    expect(find.text('Fornitori'), findsWidgets);
    expect(find.text('Elenco fornitori'), findsOneWidget);
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

    await tester.tap(find.text('Cronologia').first);
    await tester.pumpAndSettle();

    expect(find.text('Cronologia'), findsWidgets);
    expect(find.text('Ricerche salvate'), findsOneWidget);
    expect(find.text('Nessuna ricerca salvata ancora.'), findsOneWidget);
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

    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pumpAndSettle();

    expect(find.text('Preferiti'), findsWidgets);
    expect(find.text('Combinazioni salvate'), findsOneWidget);
    expect(find.text('iPhone 13 display'), findsWidgets);
  });

  testWidgets('Favorites route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.star_border).first);
    await tester.pumpAndSettle();

    expect(find.text('Preferiti'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Search route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Ricerca'), findsWidgets);
    expect(find.text('Selezione'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Shell navigation fits in a short desktop window', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 320);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.byTooltip('Catalogo'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Search route fits in a tiny desktop window', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(420, 260);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    expect(find.text('Ricerca'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Catalog route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.inventory_2_outlined).first);
    await tester.pumpAndSettle();

    expect(find.text('Catalogo'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Suppliers route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.storefront_outlined).first);
    await tester.pumpAndSettle();

    expect(find.text('Fornitori'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('History route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.history_outlined).first);
    await tester.pumpAndSettle();

    expect(find.text('Cronologia'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Settings route fits in compact desktop viewport', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(640, 560);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(buildTestApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.settings_outlined).first);
    await tester.pumpAndSettle();

    expect(find.text('Impostazioni'), findsWidgets);
    expect(tester.takeException(), isNull);
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

    await tester.tap(find.text('Impostazioni').first);
    await tester.pumpAndSettle();

    expect(find.text('Impostazioni'), findsWidgets);
    expect(find.text('Numero massimo di pagine da aprire'), findsOneWidget);
    expect(find.text('Richiedi conferma'), findsOneWidget);
    expect(find.text('Salva la cronologia delle ricerche'), findsOneWidget);
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

    await tester.tap(find.text('Impostazioni').first);
    await tester.pumpAndSettle();

    final historySwitch = find.widgetWithText(
      SwitchListTile,
      'Salva la cronologia delle ricerche',
    );

    expect(tester.widget<SwitchListTile>(historySwitch).value, isTrue);

    await tester.tap(find.text('Salva la cronologia delle ricerche'));
    await tester.pumpAndSettle();

    expect(tester.widget<SwitchListTile>(historySwitch).value, isFalse);

    await tester.tap(find.byTooltip('Aggiorna'));
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
