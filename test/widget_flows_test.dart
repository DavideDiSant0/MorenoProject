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
    await openCatalogTab(tester, 'Device types');

    expect(find.text('No device types yet.'), findsOneWidget);

    await tapFilledButton(tester, 'Add type');
    await enterDialogTextFields(tester, ['Console', 'Home repair consoles.']);
    await tapDialogFilledButton(tester, 'Save');

    await pumpUntil(tester, () {
      final state = harness.container.read(catalogControllerProvider);
      return state.hasValue &&
          state.requireValue.deviceTypes.any(
            (deviceType) => deviceType.name == 'Console',
          );
    });
    await openCatalogTab(tester, 'Device types');
    await pumpUntilFound(tester, find.text('Console'));
    expect(find.text('Home repair consoles.'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Edit'));
    await enterDialogTextFields(tester, [
      'Console Pro',
      'Premium console repairs.',
    ]);
    await tapDialogFilledButton(tester, 'Save');

    await openCatalogTab(tester, 'Device types');
    await pumpUntilFound(tester, find.text('Console Pro'));
    expect(find.text('Premium console repairs.'), findsOneWidget);
    expect(find.text('Console'), findsNothing);

    await tapVisible(tester, find.byTooltip('Delete'));
    expect(find.text('Delete device type'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Delete');

    await openCatalogTab(tester, 'Device types');
    await pumpUntilFound(tester, find.text('No device types yet.'));
    expect(find.text('Console Pro'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'Catalog brand, model, component and compatibility CRUD work from the UI',
    (tester) async {
      final harness = await pumpFlowApp(tester, seedDemoData: false);
      await openDestination(tester, Icons.inventory_2_outlined);

      await openCatalogTab(tester, 'Device types');
      await tapFilledButton(tester, 'Add type');
      await enterDialogTextFields(tester, ['Console', 'Game console.']);
      await tapDialogFilledButton(tester, 'Save');
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
      await openCatalogTab(tester, 'Device types');
      await pumpUntilFound(tester, find.text('Console'));

      await openCatalogTab(tester, 'Brands');
      await tapFilledButton(tester, 'Add brand');
      await enterDialogTextFields(tester, ['Nintendo']);
      await tapDialogFilledButton(tester, 'Save');
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
      await openCatalogTab(tester, 'Brands');
      await pumpUntilFound(tester, find.text('Nintendo'));

      await openCatalogTab(tester, 'Components');
      await tapFilledButton(tester, 'Add component');
      await enterDialogTextFields(tester, ['Cooling fan', 'Internal fan.']);
      await tapDialogFilledButton(tester, 'Save');
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
      await openCatalogTab(tester, 'Components');
      await pumpUntilFound(tester, find.text('Cooling fan'));

      await openCatalogTab(tester, 'Models');
      await tapFilledButton(tester, 'Add model');
      await enterDialogTextFields(tester, [
        'Switch',
        'HAC-001',
        'NSW, Switch V1',
      ]);
      await tapDialogFilledButton(tester, 'Save');
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
      await openCatalogTab(tester, 'Models');
      await pumpUntilFound(tester, find.text('Switch'));

      await openCatalogTab(tester, 'Compatibility');
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

      await openCatalogTab(tester, 'Models');
      await tapVisible(tester, find.byTooltip('Delete'));
      await tapDialogFilledButton(tester, 'Delete');
      await pumpUntilFound(tester, find.text('No device models yet.'));

      await openCatalogTab(tester, 'Components');
      await tapVisible(tester, find.byTooltip('Delete'));
      await tapDialogFilledButton(tester, 'Delete');
      await pumpUntilFound(tester, find.text('No components yet.'));

      await openCatalogTab(tester, 'Brands');
      await tapVisible(tester, find.byTooltip('Delete'));
      await tapDialogFilledButton(tester, 'Delete');
      await pumpUntilFound(tester, find.text('No brands yet.'));

      await openCatalogTab(tester, 'Device types');
      await tapVisible(tester, find.byTooltip('Delete'));
      await tapDialogFilledButton(tester, 'Delete');
      await pumpUntilFound(tester, find.text('No device types yet.'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Supplier CRUD, template test and compatibility work from the UI',
    (tester) async {
      await pumpFlowApp(tester);
      await openDestination(tester, Icons.storefront_outlined);

      await tapFilledButton(tester, 'Add');
      await enterDialogTextFields(tester, [
        'Parts Lab',
        'https://parts.example',
        'https://parts.example/search?q={query}&brand={brand}',
        '3',
        'Widget-tested supplier.',
      ]);

      await tapDialogTextButton(tester, 'Test');
      expect(find.text('Generated URL'), findsOneWidget);
      expect(
        find.text(
          'https://parts.example/search?q=iPhone%2012%20screen&brand=Apple',
        ),
        findsOneWidget,
      );
      await tapDialogFilledButton(tester, 'OK');

      await tapDialogFilledButton(tester, 'Save');
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

      await tapVisible(tester, find.byTooltip('Edit'));
      await enterDialogTextFields(tester, [
        'Parts Lab EU',
        'https://parts.example',
        'https://parts.example/search?q={query}&brand={brand}',
        '3',
        'Widget-tested supplier.',
      ]);
      await tapDialogFilledButton(tester, 'Save');

      await pumpUntilFound(tester, find.text('Parts Lab EU'));
      expect(find.text('Parts Lab'), findsNothing);

      await tapVisible(tester, find.byTooltip('Delete'));
      expect(find.text('Delete supplier'), findsOneWidget);
      await tapDialogFilledButton(tester, 'Delete');

      await pumpUntilGone(tester, find.text('Parts Lab EU'));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Catalog dialog stays open when validation fails', (
    tester,
  ) async {
    await pumpFlowApp(tester, seedDemoData: false);
    await openDestination(tester, Icons.inventory_2_outlined);
    await openCatalogTab(tester, 'Device types');

    await tapFilledButton(tester, 'Add type');
    expect(find.text('Add device type'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Save');

    expect(find.text('Add device type'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Supplier dialog stays open when validation fails', (
    tester,
  ) async {
    await pumpFlowApp(tester);
    await openDestination(tester, Icons.storefront_outlined);

    await tapFilledButton(tester, 'Add');
    await enterDialogTextFields(tester, [
      'Unsafe supplier',
      'https://supplier.example',
      'javascript:alert({query})',
      '3',
      '',
    ]);
    await tapDialogFilledButton(tester, 'Save');

    expect(find.text('Add supplier'), findsOneWidget);
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

    await tapFilledButton(tester, 'Save');
    expect(find.text('Save favorite'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Save');

    expect(find.text('Save favorite'), findsOneWidget);
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

    await tapFilledButton(tester, 'Save');
    expect(find.text('Save favorite'), findsOneWidget);
    await enterDialogTextFields(tester, ['Bench favorite']);
    await tapDialogFilledButton(tester, 'Save');

    await pumpUntilFound(tester, find.text('Bench favorite'));

    await tapFilledButton(tester, 'Launch');
    expect(find.text('Launch favorite'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Launch');

    await pumpUntil(tester, () => browser.openedUrls.length == 1);
    expect(browser.openedUrls.single.host, 'www.ifixit.com');
    expect(
      find.text('Favorite launched: opened 1 URL and saved to history'),
      findsOneWidget,
    );

    await tapVisible(tester, find.byTooltip('Delete'));
    expect(find.text('Delete favorite'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Delete');

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

    await tapFilledButton(tester, 'Preview');

    await pumpUntilFound(tester, find.text('Preview ready'));
    expect(find.text('Apple iPhone 13 A2633 Display'), findsWidgets);
    expect(find.text('iFixit'), findsWidgets);
    expect(find.text('eBay Ricambi'), findsWidgets);
    expect(find.textContaining('www.ifixit.com/Search'), findsOneWidget);
    expect(find.textContaining('www.ebay.it/sch/i.html'), findsOneWidget);

    await tapFilledButton(tester, 'Open');
    expect(find.text('Open URLs'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Open');

    await pumpUntil(tester, () => browser.openedUrls.length == 2);
    expect(
      browser.openedUrls.map((url) => url.toString()),
      containsAll([
        'https://www.ifixit.com/Search?query=Apple%20iPhone%2013%20A2633%20Display',
        'https://www.ebay.it/sch/i.html?_nkw=Apple%20iPhone%2013%20A2633%20Display',
      ]),
    );
    expect(find.text('Opened 2 URL and saved to history'), findsOneWidget);
    expect(find.text('opened'), findsNWidgets(2));

    await openDestination(tester, Icons.history_outlined);

    await pumpUntilFound(tester, find.text('Saved searches'));
    expect(find.text('Apple iPhone 13 A2633 Display'), findsWidgets);
    expect(find.textContaining('2 suppliers'), findsOneWidget);
    expect(find.textContaining('www.ifixit.com/Search'), findsOneWidget);

    await tapFilledButton(tester, 'Repeat');
    expect(find.text('Repeat search'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Repeat');

    await pumpUntil(tester, () => browser.openedUrls.length == 4);
    expect(find.text('Repeated search: opened 2 URL'), findsOneWidget);

    await tapVisible(tester, find.byTooltip('Delete'));
    expect(find.text('Delete search'), findsOneWidget);
    await tapDialogFilledButton(tester, 'Delete');

    await pumpUntilFound(tester, find.text('No saved searches yet.'));
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
