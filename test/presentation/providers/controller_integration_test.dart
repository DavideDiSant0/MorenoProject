import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/core/errors/browser_launch_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/core/services/external_browser_service.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/presentation/providers/catalog_controller.dart';
import 'package:repair_parts_finder/presentation/providers/favorite_controller.dart';
import 'package:repair_parts_finder/presentation/providers/history_controller.dart';
import 'package:repair_parts_finder/presentation/providers/search_controller.dart';
import 'package:repair_parts_finder/presentation/providers/settings_controller.dart';
import 'package:repair_parts_finder/presentation/providers/supplier_controller.dart';

void main() {
  test(
    'le impostazioni aggiornate raggiungono ricerca, cronologia e preferiti',
    () async {
      final container = buildContainer(seedDemoData: true);

      expect(
        (await container.read(
          searchControllerProvider.future,
        )).settings.historyEnabled,
        isTrue,
      );
      expect(
        (await container.read(
          historyControllerProvider.future,
        )).settings.historyEnabled,
        isTrue,
      );
      expect(
        (await container.read(
          favoriteControllerProvider.future,
        )).settings.historyEnabled,
        isTrue,
      );

      await container.read(settingsControllerProvider.future);
      await container
          .read(settingsControllerProvider.notifier)
          .updateHistoryEnabled(false);

      expect(
        (await container.read(
          searchControllerProvider.future,
        )).settings.historyEnabled,
        isFalse,
      );
      expect(
        (await container.read(
          historyControllerProvider.future,
        )).settings.historyEnabled,
        isFalse,
      );
      expect(
        (await container.read(
          favoriteControllerProvider.future,
        )).settings.historyEnabled,
        isFalse,
      );
    },
  );

  test(
    'il refresh del catalogo mantiene una selezione compatibilita valida',
    () async {
      final container = buildContainer();
      final controller = container.read(catalogControllerProvider.notifier);

      await container.read(catalogControllerProvider.future);
      await controller.saveDeviceType(
        name: 'Alpha',
        description: null,
        isActive: true,
      );
      await controller.saveDeviceType(
        name: 'Beta',
        description: null,
        isActive: true,
      );

      final betaId = container
          .read(catalogControllerProvider)
          .requireValue
          .deviceTypes
          .firstWhere((deviceType) => deviceType.name == 'Beta')
          .id;

      await controller.selectCompatibilityDeviceType(betaId);
      await controller.refresh();

      expect(
        container
            .read(catalogControllerProvider)
            .requireValue
            .selectedCompatibilityDeviceTypeId,
        betaId,
      );
    },
  );

  test('il refresh dei fornitori mantiene il fornitore selezionato', () async {
    final container = buildContainer();
    final controller = container.read(supplierControllerProvider.notifier);

    await container.read(supplierControllerProvider.future);
    await controller.saveSupplier(
      name: 'Alpha Parts',
      baseUrl: 'https://alpha.example',
      urlTemplate: 'https://alpha.example/search?q={query}',
      displayOrder: 0,
      notes: null,
      isActive: true,
    );
    await controller.saveSupplier(
      name: 'Beta Parts',
      baseUrl: 'https://beta.example',
      urlTemplate: 'https://beta.example/search?q={query}',
      displayOrder: 1,
      notes: null,
      isActive: true,
    );

    final betaId = container
        .read(supplierControllerProvider)
        .requireValue
        .suppliers
        .firstWhere((supplier) => supplier.name == 'Beta Parts')
        .id;

    await controller.selectSupplier(betaId);
    await controller.refresh();

    expect(
      container
          .read(supplierControllerProvider)
          .requireValue
          .selectedSupplierId,
      betaId,
    );
  });

  test('la ricerca segnala i fallimenti parziali di apertura URL', () async {
    final browser = FakeExternalBrowserService(failingHostPart: 'ebay');
    final container = buildContainer(
      seedDemoData: true,
      browserService: browser,
    );
    final controller = container.read(searchControllerProvider.notifier);

    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);
    await controller.setSupplierSelected(demoSupplierIfixitId, true);
    await controller.setSupplierSelected(demoSupplierEbayId, true);
    await controller.generatePreview();
    await controller.openPreviewedUrls();

    final state = container.read(searchControllerProvider).requireValue;

    expect(browser.openedUrls, hasLength(2));
    expect(
      state.previewItems.map((item) => item.openResult),
      containsAll([
        'opened',
        'Non e\' stato possibile aprire il browser esterno.',
      ]),
    );
    expect(
      state.lastResultMessage,
      'Aperti 1 URL, 1 non riusciti e salvati nella cronologia',
    );
  });

  test(
    'aggiornamenti impostazioni concorrenti non perdono modifiche',
    () async {
      final container = buildContainer();
      final controller = container.read(settingsControllerProvider.notifier);

      await container.read(settingsControllerProvider.future);
      await Future.wait([
        controller.updateMaxPagesToOpen(12),
        controller.updateRequireConfirmation(false),
        controller.updateHistoryEnabled(false),
      ]);

      final settings = container.read(settingsControllerProvider).requireValue;
      expect(settings.maxPagesToOpen, 12);
      expect(settings.requireConfirmation, isFalse);
      expect(settings.historyEnabled, isFalse);
    },
  );

  test('selezioni fornitore concorrenti non perdono elementi', () async {
    final container = buildContainer(seedDemoData: true);
    final controller = container.read(searchControllerProvider.notifier);

    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);

    await Future.wait([
      controller.setSupplierSelected(demoSupplierIfixitId, true),
      controller.setSupplierSelected(demoSupplierEbayId, true),
    ]);

    expect(
      container.read(searchControllerProvider).requireValue.selectedSupplierIds,
      {demoSupplierIfixitId, demoSupplierEbayId},
    );
  });

  test(
    'selezioni fornitore concorrenti restano integre nei preferiti',
    () async {
      final container = buildContainer(seedDemoData: true);
      final controller = container.read(favoriteControllerProvider.notifier);

      await container.read(favoriteControllerProvider.future);
      await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
      await controller.selectBrand(demoBrandAppleId);
      await controller.selectDeviceModel(demoModelIphone13Id);
      await controller.selectComponent(demoComponentDisplayId);

      await Future.wait([
        controller.setSupplierSelected(demoSupplierIfixitId, true),
        controller.setSupplierSelected(demoSupplierEbayId, true),
      ]);

      expect(
        container
            .read(favoriteControllerProvider)
            .requireValue
            .selectedSupplierIds,
        {demoSupplierIfixitId, demoSupplierEbayId},
      );
    },
  );

  test(
    'salvataggio preferito attende la selezione fornitore pendente',
    () async {
      final container = buildContainer(seedDemoData: true);
      final controller = container.read(favoriteControllerProvider.notifier);

      await container.read(favoriteControllerProvider.future);
      await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
      await controller.selectBrand(demoBrandAppleId);
      await controller.selectDeviceModel(demoModelIphone13Id);
      await controller.selectComponent(demoComponentDisplayId);

      final supplierSelection = controller.setSupplierSelected(
        demoSupplierIfixitId,
        true,
      );
      await controller.saveFavorite('Concurrent favorite');
      await supplierSelection;

      final state = container.read(favoriteControllerProvider).requireValue;
      final saved = state.favorites.firstWhere(
        (favorite) => favorite.name == 'Concurrent favorite',
      );
      expect(saved.supplierIds, [demoSupplierIfixitId]);
    },
  );

  test('un doppio comando di apertura non duplica URL e cronologia', () async {
    final browser = BlockingExternalBrowserService();
    final container = buildContainer(
      seedDemoData: true,
      browserService: browser,
    );
    final controller = container.read(searchControllerProvider.notifier);

    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);
    await controller.setSupplierSelected(demoSupplierIfixitId, true);
    await controller.generatePreview();

    final firstOpening = controller.openPreviewedUrls();
    await browser.openStarted.future;
    await expectLater(
      controller.openPreviewedUrls(),
      throwsA(isA<ValidationException>()),
    );
    browser.allowOpen.complete();
    await firstOpening;

    expect(browser.openedUrls, hasLength(1));
    final database = await container.read(appDatabaseProvider.future);
    expect(await database.searchHistoryDao.getAllEntries(), hasLength(1));
  });

  test('apertura attende una deselezione fornitore gia richiesta', () async {
    final browser = FakeExternalBrowserService();
    final container = buildContainer(
      seedDemoData: true,
      browserService: browser,
    );
    final controller = container.read(searchControllerProvider.notifier);

    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);
    await controller.setSupplierSelected(demoSupplierIfixitId, true);
    await controller.generatePreview();

    final deselection = controller.setSupplierSelected(
      demoSupplierIfixitId,
      false,
    );
    await expectLater(
      controller.openPreviewedUrls(),
      throwsA(isA<ValidationException>()),
    );
    await deselection;

    expect(browser.openedUrls, isEmpty);
    expect(
      container.read(searchControllerProvider).requireValue.previewItems,
      isEmpty,
    );
  });

  test('cronologia disattivata non salva ricerche aperte', () async {
    final browser = FakeExternalBrowserService();
    final container = buildContainer(
      seedDemoData: true,
      browserService: browser,
    );

    await container.read(settingsControllerProvider.future);
    await container
        .read(settingsControllerProvider.notifier)
        .updateHistoryEnabled(false);

    final controller = container.read(searchControllerProvider.notifier);
    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);
    await controller.setSupplierSelected(demoSupplierIfixitId, true);
    await controller.generatePreview();
    await controller.openPreviewedUrls();

    final database = await container.read(appDatabaseProvider.future);
    expect(browser.openedUrls, hasLength(1));
    expect(await database.searchHistoryDao.getAllEntries(), isEmpty);
    expect(
      container.read(searchControllerProvider).requireValue.lastResultMessage,
      'Aperti 1 URL',
    );
  });

  test('limite pagine blocca la preview prima di aprire URL', () async {
    final browser = FakeExternalBrowserService();
    final container = buildContainer(
      seedDemoData: true,
      browserService: browser,
    );

    await container.read(settingsControllerProvider.future);
    await container
        .read(settingsControllerProvider.notifier)
        .updateMaxPagesToOpen(1);

    final controller = container.read(searchControllerProvider.notifier);
    await container.read(searchControllerProvider.future);
    await controller.selectDeviceType(demoDeviceTypeSmartphoneId);
    await controller.selectBrand(demoBrandAppleId);
    await controller.selectDeviceModel(demoModelIphone13Id);
    await controller.selectComponent(demoComponentDisplayId);
    await controller.setSupplierSelected(demoSupplierIfixitId, true);
    await controller.setSupplierSelected(demoSupplierEbayId, true);

    await expectLater(
      controller.generatePreview(),
      throwsA(isA<ValidationException>()),
    );
    expect(browser.openedUrls, isEmpty);
    expect(
      container.read(searchControllerProvider).requireValue.previewItems,
      isEmpty,
    );
  });

  test('riordino fornitori resta persistito dopo refresh', () async {
    final container = buildContainer(seedDemoData: true);
    final controller = container.read(supplierControllerProvider.notifier);

    await container.read(supplierControllerProvider.future);
    await controller.moveSupplier(demoSupplierEbayId, -1);
    await controller.refresh();

    final suppliers = container
        .read(supplierControllerProvider)
        .requireValue
        .suppliers;
    expect(suppliers.map((supplier) => supplier.id), [
      demoSupplierIfixitId,
      demoSupplierEbayId,
      demoSupplierSosavId,
    ]);
    expect(suppliers.map((supplier) => supplier.displayOrder), [0, 1, 2]);
  });
}

ProviderContainer buildContainer({
  bool seedDemoData = false,
  ExternalBrowserService? browserService,
}) {
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
      externalBrowserServiceProvider.overrideWith(
        (ref) => browserService ?? FakeExternalBrowserService(),
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
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

final class BlockingExternalBrowserService implements ExternalBrowserService {
  final Completer<void> openStarted = Completer<void>();
  final Completer<void> allowOpen = Completer<void>();
  final List<Uri> openedUrls = [];

  @override
  Future<void> open(Uri url) async {
    openedUrls.add(url);
    if (!openStarted.isCompleted) {
      openStarted.complete();
    }
    await allowOpen.future;
  }
}
