import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/core/errors/browser_launch_exception.dart';
import 'package:repair_parts_finder/core/services/external_browser_service.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/main.dart';
import 'package:repair_parts_finder/presentation/providers/catalog_controller.dart';

void main() {
  testWidgets('Catalog device type CRUD works from the UI', (tester) async {
    final harness = await pumpFlowApp(tester, seedDemoData: false);
    await openDestination(tester, Icons.inventory_2_outlined);
    await openCatalogTab(tester, 'Tipi di dispositivo');

    expect(find.text('Nessun tipo di dispositivo ancora.'), findsOneWidget);

    await tapFilledButton(tester, 'Aggiungi tipo');
    await enterDialogTextFields(tester, ['Console', 'Home repair consoles.']);
    await tapDialogFilledButton(tester, 'Salva');

    await pumpUntil(tester, () {
      final state = harness.container.read(catalogControllerProvider);
      return state.hasValue &&
          state.requireValue.deviceTypes.any(
            (deviceType) => deviceType.name == 'Console',
          );
    });
    await openCatalogTab(tester, 'Tipi di dispositivo');
    await pumpUntilFound(tester, find.text('Console'));
    expect(find.text('Home repair consoles.'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Modifica'));
    await enterDialogTextFields(tester, [
      'Console Pro',
      'Premium console repairs.',
    ]);
    await tapDialogFilledButton(tester, 'Salva');

    await openCatalogTab(tester, 'Tipi di dispositivo');
    await pumpUntilFound(tester, find.text('Console Pro'));
    expect(find.text('Premium console repairs.'), findsOneWidget);
    expect(find.text('Console'), findsNothing);

    await tapVisible(tester, find.byTooltip('Elimina'));
    expect(find.text('Elimina tipo di dispositivo'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Elimina');

    await openCatalogTab(tester, 'Tipi di dispositivo');
    await pumpUntilFound(
      tester,
      find.text('Nessun tipo di dispositivo ancora.'),
    );
    expect(find.text('Console Pro'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Catalog brand, model, component and compatibility CRUD work from the UI',
    (tester) async {
      final harness = await pumpFlowApp(tester, seedDemoData: false);
      await openDestination(tester, Icons.inventory_2_outlined);

      await openCatalogTab(tester, 'Tipi di dispositivo');
      await tapFilledButton(tester, 'Aggiungi tipo');
      await enterDialogTextFields(tester, ['Console', 'Game console.']);
      await tapDialogFilledButton(tester, 'Salva');
      await pumpUntil(
        tester,
        () =>
            harness.container
                .read(catalogControllerProvider)
                .value
                ?.deviceTypes
                .any((item) => item.name == 'Console') ??
            false,
      );
      await openCatalogTab(tester, 'Tipi di dispositivo');
      await pumpUntilFound(tester, find.text('Console'));

      await openCatalogTab(tester, 'Marche');
      await tapFilledButton(tester, 'Aggiungi marca');
      await enterDialogTextFields(tester, ['Nintendo']);
      await tapDialogFilledButton(tester, 'Salva');
      await pumpUntil(
        tester,
        () =>
            harness.container
                .read(catalogControllerProvider)
                .value
                ?.brands
                .any((item) => item.name == 'Nintendo') ??
            false,
      );
      await openCatalogTab(tester, 'Marche');
      await pumpUntilFound(tester, find.text('Nintendo'));

      await openCatalogTab(tester, 'Componenti');
      await tapFilledButton(tester, 'Aggiungi componente');
      await enterDialogTextFields(tester, ['Cooling fan', 'Internal fan.']);
      await tapDialogFilledButton(tester, 'Salva');
      await pumpUntil(
        tester,
        () =>
            harness.container
                .read(catalogControllerProvider)
                .value
                ?.components
                .any((item) => item.name == 'Cooling fan') ??
            false,
      );
      await openCatalogTab(tester, 'Componenti');
      await pumpUntilFound(tester, find.text('Cooling fan'));

      await openCatalogTab(tester, 'Modelli');
      await tapFilledButton(tester, 'Aggiungi modello');
      await enterDialogTextFields(tester, [
        'Switch',
        'HAC-001',
        'NSW, Switch V1',
      ]);
      await tapDialogFilledButton(tester, 'Salva');
      await pumpUntil(
        tester,
        () =>
            harness.container
                .read(catalogControllerProvider)
                .value
                ?.deviceModels
                .any((item) => item.name == 'Switch') ??
            false,
      );
      await openCatalogTab(tester, 'Modelli');
      await pumpUntilFound(tester, find.text('Switch'));

      await openCatalogTab(tester, 'Compatibilità');
      final compatibility = find.widgetWithText(
        CheckboxListTile,
        'Cooling fan',
      );
      expect(tester.widget<CheckboxListTile>(compatibility).value, isFalse);
      await tapVisible(tester, compatibility);
      await pumpUntil(
        tester,
        () => tester.widget<CheckboxListTile>(compatibility).value == true,
      );

      await openCatalogTab(tester, 'Modelli');
      await tapVisible(tester, find.byTooltip('Elimina'));
      await tapDialogFilledButton(tester, 'Elimina');
      await pumpUntilFound(
        tester,
        find.text('Nessun modello di dispositivo ancora.'),
      );

      await openCatalogTab(tester, 'Componenti');
      await tapVisible(tester, find.byTooltip('Elimina'));
      await tapDialogFilledButton(tester, 'Elimina');
      await pumpUntilFound(tester, find.text('Nessun componente ancora.'));

      await openCatalogTab(tester, 'Marche');
      await tapVisible(tester, find.byTooltip('Elimina'));
      await tapDialogFilledButton(tester, 'Elimina');
      await pumpUntilFound(tester, find.text('Nessuna marca ancora.'));

      await openCatalogTab(tester, 'Tipi di dispositivo');
      await tapVisible(tester, find.byTooltip('Elimina'));
      await tapDialogFilledButton(tester, 'Elimina');
      await pumpUntilFound(
        tester,
        find.text('Nessun tipo di dispositivo ancora.'),
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Supplier CRUD, template test and compatibility work from the UI',
    (tester) async {
      await pumpFlowApp(tester);
      await openDestination(tester, Icons.storefront_outlined);

      await tapFilledButton(tester, 'Aggiungi');
      await enterDialogTextFields(tester, [
        'Parts Lab',
        'https://parts.example',
        'https://parts.example/search?q={query}&brand={brand}',
        '3',
        'Widget-tested supplier.',
      ]);

      await tapDialogTextButton(tester, 'Prova');
      expect(find.text('URL generato'), findsOneWidget);
      expect(
        find.text(
          'https://parts.example/search?q=iPhone%2012%20schermo&brand=Apple',
        ),
        findsOneWidget,
      );
      await tapDialogFilledButton(tester, 'OK');

      await tapDialogFilledButton(tester, 'Salva');
      await pumpUntilFound(tester, find.text('Parts Lab'));

      expect(find.text('Widget-tested supplier.'), findsOneWidget);
      final smartphoneCompatibility = find.widgetWithText(
        CheckboxListTile,
        'Smartphone',
      );
      expect(
        tester.widget<CheckboxListTile>(smartphoneCompatibility).value,
        isFalse,
      );

      await tapVisible(tester, smartphoneCompatibility);
      await pumpUntil(
        tester,
        () =>
            tester.widget<CheckboxListTile>(smartphoneCompatibility).value ==
            true,
      );
      expect(
        tester.widget<CheckboxListTile>(smartphoneCompatibility).value,
        isTrue,
      );

      await tapVisible(tester, find.byTooltip('Modifica'));
      await enterDialogTextFields(tester, [
        'Parts Lab EU',
        'https://parts.example',
        'https://parts.example/search?q={query}&brand={brand}',
        '3',
        'Widget-tested supplier.',
      ]);
      await tapDialogFilledButton(tester, 'Salva');

      await pumpUntilFound(tester, find.text('Parts Lab EU'));
      expect(find.text('Parts Lab'), findsNothing);

      await tapVisible(tester, find.byTooltip('Elimina'));
      expect(find.text('Elimina fornitore'), findsOneWidget);
      await tapDialogFilledButton(tester, 'Elimina');

      await pumpUntilGone(tester, find.text('Parts Lab EU'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Catalog dialog stays open when validation fails', (
    tester,
  ) async {
    await pumpFlowApp(tester, seedDemoData: false);
    await openDestination(tester, Icons.inventory_2_outlined);
    await openCatalogTab(tester, 'Tipi di dispositivo');

    await tapFilledButton(tester, 'Aggiungi tipo');
    expect(find.text('Aggiungi tipo di dispositivo'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Salva');

    expect(find.text('Aggiungi tipo di dispositivo'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Supplier dialog stays open when validation fails', (
    tester,
  ) async {
    await pumpFlowApp(tester);
    await openDestination(tester, Icons.storefront_outlined);

    await tapFilledButton(tester, 'Aggiungi');
    await enterDialogTextFields(tester, [
      'Unsafe supplier',
      'https://supplier.example',
      'javascript:alert({query})',
      '3',
      '',
    ]);
    await tapDialogFilledButton(tester, 'Salva');

    expect(find.text('Aggiungi fornitore'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.text('Il template URL deve usare solo HTTP o HTTPS.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Favorite dialog stays open when validation fails', (
    tester,
  ) async {
    await pumpFlowApp(tester);
    await openDestination(tester, Icons.star_border);

    await chooseDropdown(tester, 0, 'Smartphone');
    await chooseDropdown(tester, 1, 'Apple');
    await chooseDropdown(tester, 2, 'iPhone 13');
    await chooseDropdown(tester, 3, 'Display');
    await tapVisible(tester, find.widgetWithText(FilterChip, 'iFixit'));

    await tapFilledButton(tester, 'Salva');
    expect(find.text('Salva preferito'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Salva');

    expect(find.text('Salva preferito'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Favorites can be saved, launched and deleted from the UI', (
    tester,
  ) async {
    final browser = FakeExternalBrowserService();
    await pumpFlowApp(tester, browserService: browser);
    await openDestination(tester, Icons.star_border);

    await chooseDropdown(tester, 0, 'Smartphone');
    await chooseDropdown(tester, 1, 'Apple');
    await chooseDropdown(tester, 2, 'iPhone 13');
    await chooseDropdown(tester, 3, 'Display');
    await tapVisible(tester, find.widgetWithText(FilterChip, 'iFixit'));

    await tapFilledButton(tester, 'Salva');
    expect(find.text('Salva preferito'), findsOneWidget);
    await enterDialogTextFields(tester, ['Bench favorite']);
    await tapDialogFilledButton(tester, 'Salva');

    await pumpUntilFound(tester, find.text('Bench favorite'));

    await tapFilledButton(tester, 'Apri');
    expect(find.text('Apri preferito'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Apri');

    await pumpUntil(tester, () => browser.openedUrls.length == 1);
    expect(browser.openedUrls.single.host, 'www.ifixit.com');
    expect(
      find.text('Preferito aperto: 1 URL aperti e salvati nella cronologia'),
      findsOneWidget,
    );

    await tapVisible(tester, find.byTooltip('Elimina'));
    expect(find.text('Elimina preferito'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Elimina');

    await pumpUntilGone(tester, find.text('Bench favorite'));
    expect(tester.takeException(), isNull);
  });

  testWidgets('Search flow generates URLs, opens the browser and saves history', (
    tester,
  ) async {
    final browser = FakeExternalBrowserService();
    await pumpFlowApp(tester, browserService: browser);

    await chooseDropdown(tester, 0, 'Smartphone');
    await chooseDropdown(tester, 1, 'Apple');
    await chooseDropdown(tester, 2, 'iPhone 13');
    await chooseDropdown(tester, 3, 'Display');
    await tapVisible(tester, find.widgetWithText(CheckboxListTile, 'iFixit'));
    await tapVisible(
      tester,
      find.widgetWithText(CheckboxListTile, 'eBay Ricambi'),
    );

    await tapFilledButton(tester, 'Anteprima');

    await pumpUntilFound(tester, find.text('Anteprima pronta'));
    expect(find.text('Apple iPhone 13 A2633 Display'), findsWidgets);
    expect(find.text('iFixit'), findsWidgets);
    expect(find.text('eBay Ricambi'), findsWidgets);
    expect(find.textContaining('www.ifixit.com/Search'), findsOneWidget);
    expect(find.textContaining('www.ebay.it/sch/i.html'), findsOneWidget);

    await tapFilledButton(tester, 'Apri');
    expect(find.text('Apri URL'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Apri');

    await pumpUntil(tester, () => browser.openedUrls.length == 2);
    expect(
      browser.openedUrls.map((url) => url.toString()),
      containsAll([
        'https://www.ifixit.com/Search?query=Apple%20iPhone%2013%20A2633%20Display',
        'https://www.ebay.it/sch/i.html?_nkw=Apple%20iPhone%2013%20A2633%20Display',
      ]),
    );
    expect(
      find.text('Aperti 2 URL e salvati nella cronologia'),
      findsOneWidget,
    );
    expect(find.text('Aperto'), findsNWidgets(2));

    await openDestination(tester, Icons.history_outlined);

    await pumpUntilFound(tester, find.text('Ricerche salvate'));
    expect(find.text('Apple iPhone 13 A2633 Display'), findsWidgets);
    expect(find.textContaining('2 fornitori'), findsOneWidget);
    expect(find.textContaining('www.ifixit.com/Search'), findsOneWidget);

    await tapFilledButton(tester, 'Ripeti');
    expect(find.text('Ripeti ricerca'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Ripeti');

    await pumpUntil(tester, () => browser.openedUrls.length == 4);
    expect(find.text('Ricerca ripetuta: aperti 2 URL'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Elimina'));
    expect(find.text('Elimina ricerca'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Elimina');

    await pumpUntilFound(tester, find.text('Nessuna ricerca salvata ancora.'));
    expect(tester.takeException(), isNull);
  });
}

Future<FlowTestHarness> pumpFlowApp(
  WidgetTester tester, {
  bool seedDemoData = true,
  FakeExternalBrowserService? browserService,
}) async {
  tester.view.physicalSize = const Size(1280, 900);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final browser = browserService ?? FakeExternalBrowserService();
  final container = ProviderContainer(
    overrides: [
      appDatabaseProvider.overrideWith((ref) async {
        final database = AppDatabase(NativeDatabase.memory());
        if (seedDemoData) {
          await AppDemoDataSeeder(database).seedIfEmpty();
        }
        ref.onDispose(() => unawaited(database.close()));
        return database;
      }),
      externalBrowserServiceProvider.overrideWith((ref) => browser),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const RepairPartsFinderApp(),
    ),
  );
  await tester.pumpAndSettle();
  return FlowTestHarness(container: container, browser: browser);
}

final class FlowTestHarness {
  const FlowTestHarness({required this.container, required this.browser});

  final ProviderContainer container;
  final FakeExternalBrowserService browser;
}

Future<void> openDestination(WidgetTester tester, IconData icon) async {
  await tapVisible(tester, find.byIcon(icon));
}

Future<void> openCatalogTab(WidgetTester tester, String label) async {
  final tabText = find.descendant(
    of: find.byType(TabBar),
    matching: find.text(label),
  );
  await tapVisible(tester, tabText);
}

Future<void> chooseDropdown(
  WidgetTester tester,
  int index,
  String optionText,
) async {
  final dropdown = find
      .byWidgetPredicate((widget) => widget is DropdownButtonFormField<String>)
      .at(index);
  await tapVisible(tester, dropdown);
  await tapVisible(tester, find.text(optionText), preferLast: true);
}

Future<void> enterDialogTextFields(
  WidgetTester tester,
  List<String> values,
) async {
  final fields = find.descendant(
    of: find.byType(AlertDialog),
    matching: find.byType(TextField),
  );
  expect(fields, findsNWidgets(values.length));

  for (var index = 0; index < values.length; index++) {
    await tester.ensureVisible(fields.at(index));
    await tester.enterText(fields.at(index), values[index]);
    await tester.pump();
  }
}

Future<void> tapFilledButton(WidgetTester tester, String label) {
  return tapVisible(
    tester,
    widgetWithDescendantText<FilledButton>(label),
    preferLast: true,
  );
}

Future<void> tapDialogFilledButton(WidgetTester tester, String label) {
  return pressButton(
    tester,
    widgetWithDescendantText<FilledButton>(label, inDialog: true),
    preferLast: true,
  );
}

Future<void> tapDialogTextButton(WidgetTester tester, String label) {
  return pressButton(
    tester,
    widgetWithDescendantText<TextButton>(label, inDialog: true),
    preferLast: true,
  );
}

Future<void> pressButton(
  WidgetTester tester,
  Finder finder, {
  bool preferLast = false,
}) async {
  final target = singleTarget(finder, preferLast: preferLast);
  final button = tester.widget<ButtonStyleButton>(target);
  expect(button.onPressed, isNotNull);
  button.onPressed!();
  await tester.pumpAndSettle();
}

Finder widgetWithDescendantText<T extends Widget>(
  String label, {
  bool inDialog = false,
}) {
  return find.byElementPredicate((element) {
    return element.widget is T &&
        (!inDialog || _hasAncestorWidget<AlertDialog>(element)) &&
        _elementContainsText(element, label);
  });
}

bool _elementContainsText(Element element, String label) {
  final widget = element.widget;
  if (widget is Text && widget.data == label) {
    return true;
  }

  var found = false;
  element.visitChildren((child) {
    if (!found && _elementContainsText(child, label)) {
      found = true;
    }
  });
  return found;
}

bool _hasAncestorWidget<T extends Widget>(Element element) {
  var found = false;
  element.visitAncestorElements((ancestor) {
    if (ancestor.widget is T) {
      found = true;
      return false;
    }
    return true;
  });
  return found;
}

Future<void> tapVisible(
  WidgetTester tester,
  Finder finder, {
  bool preferLast = false,
}) async {
  final target = singleTarget(finder, preferLast: preferLast);
  await tester.ensureVisible(target);
  await tester.tap(target);
  await tester.pumpAndSettle();
}

Finder singleTarget(Finder finder, {bool preferLast = false}) {
  final matchCount = _matchCount(finder);
  if (matchCount == 0) {
    fail('Expected at least one widget for $finder.');
  }
  return matchCount == 1
      ? finder
      : (preferLast ? finder.at(matchCount - 1) : finder.first);
}

int _matchCount(Finder finder) {
  try {
    return finder.evaluate().length;
  } on StateError {
    return 0;
  }
}

Future<void> pumpUntilFound(WidgetTester tester, Finder finder) {
  return pumpUntil(tester, () => finder.evaluate().isNotEmpty);
}

Future<void> pumpUntilGone(WidgetTester tester, Finder finder) {
  return pumpUntil(tester, () => finder.evaluate().isEmpty);
}

Future<void> pumpUntil(WidgetTester tester, bool Function() condition) async {
  for (var attempt = 0; attempt < 40; attempt++) {
    if (condition()) {
      return;
    }
    await tester.pump(const Duration(milliseconds: 100));
  }
  fail('Timed out waiting for widget flow condition.');
}

final class FakeExternalBrowserService implements ExternalBrowserService {
  FakeExternalBrowserService({this.failingHostPart});

  final String? failingHostPart;
  final List<Uri> openedUrls = [];

  @override
  Future<void> open(Uri url) async {
    openedUrls.add(url);
    final failingHostPart = this.failingHostPart;
    if (failingHostPart != null && url.host.contains(failingHostPart)) {
      throw const BrowserLaunchException(
        'Non e\' stato possibile aprire il browser esterno.',
      );
    }
  }
}
