import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/supplier_dao.dart';

void main() {
  late AppDatabase database;
  late SupplierDao dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = database.supplierDao;
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertSupplier({
    String id = 's1',
    String name = 'Fornitore Uno',
    int displayOrder = 0,
  }) => dao.insertSupplier(
    SuppliersCompanion.insert(
      id: id,
      name: name,
      baseUrl: 'https://example.com',
      urlTemplate: 'https://example.com/search?q={query}',
      displayOrder: Value(displayOrder),
    ),
  );

  Future<void> insertDeviceType({
    String id = 'dt1',
    String name = 'Smartphone',
  }) => database.catalogDao.insertDeviceType(
    DeviceTypesCompanion.insert(id: id, name: name),
  );

  test('elenca i fornitori ordinati per displayOrder', () async {
    await insertSupplier(id: 's1', displayOrder: 2);
    await insertSupplier(id: 's2', displayOrder: 1);

    final results = await dao.getAllSuppliers();

    expect(results.map((s) => s.id), ['s2', 's1']);
  });

  test('aggiorna un fornitore esistente', () async {
    await insertSupplier();

    final replaced = await dao.updateSupplier(
      SuppliersCompanion.insert(
        id: 's1',
        name: 'Fornitore Aggiornato',
        baseUrl: 'https://example.com',
        urlTemplate: 'https://example.com/search?q={query}',
      ),
    );

    expect(replaced, isTrue);
    expect((await dao.getSupplierById('s1'))!.name, 'Fornitore Aggiornato');
  });

  group('compatibilita\' fornitore <-> tipo dispositivo', () {
    test('aggiunge e legge la compatibilita\' da entrambi i lati', () async {
      await insertSupplier();
      await insertDeviceType();

      await dao.addCompatibleDeviceType('s1', 'dt1');

      expect((await dao.getCompatibleDeviceTypes('s1')).single.id, 'dt1');
      expect((await dao.getCompatibleWithDeviceType('dt1')).single.id, 's1');
    });

    test(
      'cancellare il fornitore rimuove la compatibilita\' (cascade)',
      () async {
        await insertSupplier();
        await insertDeviceType();
        await dao.addCompatibleDeviceType('s1', 'dt1');

        await dao.deleteSupplier('s1');

        expect(await dao.getCompatibleWithDeviceType('dt1'), isEmpty);
      },
    );

    test('rimuove esplicitamente la compatibilita\'', () async {
      await insertSupplier();
      await insertDeviceType();
      await dao.addCompatibleDeviceType('s1', 'dt1');

      final removedCount = await dao.removeCompatibleDeviceType('s1', 'dt1');

      expect(removedCount, 1);
      expect(await dao.getCompatibleDeviceTypes('s1'), isEmpty);
    });
  });
}
