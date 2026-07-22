import 'dart:async';

import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/core/errors/browser_launch_exception.dart';
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
      'Opened 1 URL, 1 failed and saved to history',
    );
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
