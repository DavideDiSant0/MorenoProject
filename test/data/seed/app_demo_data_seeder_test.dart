import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('popola catalogo, fornitori, compatibilita e preferiti demo', () async {
    final seeded = await AppDemoDataSeeder(database).seedIfEmpty();

    expect(seeded, isTrue);
    expect(await database.select(database.deviceTypes).get(), hasLength(3));
    expect(await database.select(database.brands).get(), hasLength(3));
    expect(await database.select(database.deviceModels).get(), hasLength(6));
    expect(await database.select(database.components).get(), hasLength(7));
    expect(await database.select(database.suppliers).get(), hasLength(3));
    expect(await database.select(database.favorites).get(), hasLength(1));
    expect(
      await database.appSettingsDao.getDemoSeedVersion(),
      currentDemoSeedVersion,
    );

    final phoneComponents = await database.catalogDao.getCompatibleComponents(
      demoDeviceTypeSmartphoneId,
    );
    expect(
      phoneComponents.map((component) => component.id),
      containsAll([demoComponentDisplayId, demoComponentBatteryId]),
    );

    final phoneSuppliers = await database.supplierDao
        .getCompatibleWithDeviceType(demoDeviceTypeSmartphoneId);
    expect(
      phoneSuppliers.map((supplier) => supplier.id),
      containsAll([demoSupplierIfixitId, demoSupplierSosavId]),
    );

    final favoriteSuppliers = await database.favoriteDao
        .getSupplierIdsForFavorite(demoFavoriteIphoneDisplayId);
    expect(
      favoriteSuppliers,
      containsAll([demoSupplierIfixitId, demoSupplierEbayId]),
    );
  });

  test('non duplica i dati se il seed viene richiamato piu volte', () async {
    final seeder = AppDemoDataSeeder(database);

    expect(await seeder.seedIfEmpty(), isTrue);
    expect(await seeder.seedIfEmpty(), isFalse);

    expect(await database.select(database.deviceTypes).get(), hasLength(3));
    expect(await database.select(database.suppliers).get(), hasLength(3));
    expect(
      await database.select(database.favoriteSuppliers).get(),
      hasLength(2),
    );
  });

  test('non inserisce demo data quando esistono gia dati utente', () async {
    await database
        .into(database.deviceTypes)
        .insert(
          DeviceTypesCompanion.insert(
            id: 'custom-phone',
            name: 'Custom phone',
            description: Value('Voce creata manualmente.'),
          ),
        );

    final seeded = await AppDemoDataSeeder(database).seedIfEmpty();

    expect(seeded, isFalse);
    expect(await database.select(database.deviceTypes).get(), hasLength(1));
    expect(await database.select(database.suppliers).get(), isEmpty);
    expect(
      await database.appSettingsDao.getDemoSeedVersion(),
      currentDemoSeedVersion,
    );
  });

  test('non reinserisce demo data dopo che il seed e stato marcato', () async {
    await database
        .into(database.deviceTypes)
        .insert(
          DeviceTypesCompanion.insert(
            id: 'custom-phone',
            name: 'Custom phone',
            description: Value('Voce creata manualmente.'),
          ),
        );

    final seeder = AppDemoDataSeeder(database);

    expect(await seeder.seedIfEmpty(), isFalse);
    await database.catalogDao.deleteDeviceType('custom-phone');
    expect(await seeder.seedIfEmpty(), isFalse);

    expect(await database.select(database.deviceTypes).get(), isEmpty);
    expect(await database.select(database.suppliers).get(), isEmpty);
  });

  test('i template URL dei fornitori demo sono validi e generabili', () async {
    await AppDemoDataSeeder(database).seedIfEmpty();

    final generator = const UrlTemplateGenerator();
    final suppliers = await database.select(database.suppliers).get();

    for (final supplier in suppliers) {
      generator.validateTemplate(supplier.urlTemplate);
      final uri = generator.generate(
        supplier.urlTemplate,
        const UrlTemplateValues(query: 'iPhone 13 display'),
      );

      expect(uri.scheme, anyOf('http', 'https'));
      expect(uri.host, isNotEmpty);
      expect(uri.toString(), contains('iPhone%2013%20display'));
    }
  });
}
