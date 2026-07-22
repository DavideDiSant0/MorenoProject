import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';

void main() {
  late AppDatabase database;
  late CatalogDao dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = database.catalogDao;
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertDeviceType({
    String id = 'dt1',
    String name = 'Smartphone',
  }) => dao.insertDeviceType(DeviceTypesCompanion.insert(id: id, name: name));

  Future<void> insertBrand({String id = 'b1', String name = 'Apple'}) =>
      dao.insertBrand(BrandsCompanion.insert(id: id, name: name));

  Future<void> insertComponent({String id = 'c1', String name = 'Schermo'}) =>
      dao.insertComponent(ComponentsCompanion.insert(id: id, name: name));

  group('device types', () {
    test('insert, get, update, delete', () async {
      await insertDeviceType();

      final fetched = await dao.getDeviceTypeById('dt1');
      expect(fetched!.name, 'Smartphone');

      final updated = await dao.updateDeviceType(
        DeviceTypesCompanion.insert(id: 'dt1', name: 'Tablet'),
      );
      expect(updated, isTrue);
      expect((await dao.getDeviceTypeById('dt1'))!.name, 'Tablet');

      final deletedCount = await dao.deleteDeviceType('dt1');
      expect(deletedCount, 1);
      expect(await dao.getDeviceTypeById('dt1'), isNull);
    });
  });

  group('device models', () {
    test('il vincolo unique su (brandId, name) rifiuta un duplicato', () async {
      await insertDeviceType();
      await insertBrand();
      await dao.insertDeviceModel(
        DeviceModelsCompanion.insert(
          id: 'm1',
          name: 'iPhone 12',
          deviceTypeId: 'dt1',
          brandId: 'b1',
        ),
      );

      expect(
        () => dao.insertDeviceModel(
          DeviceModelsCompanion.insert(
            id: 'm2',
            name: 'iPhone 12',
            deviceTypeId: 'dt1',
            brandId: 'b1',
          ),
        ),
        throwsA(isA<SqliteException>()),
      );
    });

    test('filtra per tipo dispositivo e marca', () async {
      await insertDeviceType();
      await insertBrand();
      await insertBrand(id: 'b2', name: 'Samsung');
      await dao.insertDeviceModel(
        DeviceModelsCompanion.insert(
          id: 'm1',
          name: 'iPhone 12',
          deviceTypeId: 'dt1',
          brandId: 'b1',
        ),
      );
      await dao.insertDeviceModel(
        DeviceModelsCompanion.insert(
          id: 'm2',
          name: 'Galaxy S21',
          deviceTypeId: 'dt1',
          brandId: 'b2',
        ),
      );

      final results = await dao.getDeviceModelsByDeviceTypeAndBrand(
        'dt1',
        'b1',
      );

      expect(results, hasLength(1));
      expect(results.single.name, 'iPhone 12');
    });

    test(
      'eliminare un tipo dispositivo con modelli collegati e\' rifiutato',
      () async {
        await insertDeviceType();
        await insertBrand();
        await dao.insertDeviceModel(
          DeviceModelsCompanion.insert(
            id: 'm1',
            name: 'iPhone 12',
            deviceTypeId: 'dt1',
            brandId: 'b1',
          ),
        );

        expect(
          () => dao.deleteDeviceType('dt1'),
          throwsA(isA<SqliteException>()),
        );
      },
    );
  });

  group('compatibilita\' tipo dispositivo <-> componente', () {
    test('aggiunge, legge e rimuove la compatibilita\'', () async {
      await insertDeviceType();
      await insertComponent();

      await dao.addCompatibleComponent('dt1', 'c1');
      var components = await dao.getCompatibleComponents('dt1');
      expect(components, hasLength(1));
      expect(components.single.name, 'Schermo');

      final removedCount = await dao.removeCompatibleComponent('dt1', 'c1');
      expect(removedCount, 1);
      components = await dao.getCompatibleComponents('dt1');
      expect(components, isEmpty);
    });

    test(
      'cancellare il componente rimuove la compatibilita\' (cascade)',
      () async {
        await insertDeviceType();
        await insertComponent();
        await dao.addCompatibleComponent('dt1', 'c1');

        await dao.deleteComponent('c1');

        expect(await dao.getCompatibleComponents('dt1'), isEmpty);
      },
    );
  });
}
