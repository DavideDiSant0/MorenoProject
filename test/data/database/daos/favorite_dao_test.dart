import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/favorite_dao.dart';

void main() {
  late AppDatabase database;
  late FavoriteDao dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = database.favoriteDao;
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertCatalogPrerequisites() async {
    final catalog = database.catalogDao;
    await catalog.insertDeviceType(
      DeviceTypesCompanion.insert(id: 'dt1', name: 'Smartphone'),
    );
    await catalog.insertBrand(BrandsCompanion.insert(id: 'b1', name: 'Apple'));
    await catalog.insertDeviceModel(
      DeviceModelsCompanion.insert(
        id: 'm1',
        name: 'iPhone 12',
        deviceTypeId: 'dt1',
        brandId: 'b1',
      ),
    );
    await catalog.insertComponent(
      ComponentsCompanion.insert(id: 'c1', name: 'Schermo'),
    );
  }

  Future<void> insertSupplier(String id) => database.supplierDao.insertSupplier(
    SuppliersCompanion.insert(
      id: id,
      name: 'Fornitore $id',
      baseUrl: 'https://example.com',
      urlTemplate: 'https://example.com/search?q={query}',
    ),
  );

  FavoritesCompanion buildFavorite({String id = 'f1'}) =>
      FavoritesCompanion.insert(
        id: id,
        name: 'iPhone 12 schermo',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        deviceModelId: 'm1',
        componentId: 'c1',
        createdAt: DateTime(2026, 1, 1),
      );

  test('inserisce il preferito con i fornitori associati', () async {
    await insertCatalogPrerequisites();
    await insertSupplier('s1');
    await insertSupplier('s2');

    await dao.insertFavorite(buildFavorite(), 'f1', ['s1', 's2']);

    final row = await dao.getFavoriteById('f1');
    final supplierIds = await dao.getSupplierIdsForFavorite('f1');

    expect(row, isNotNull);
    expect(supplierIds, unorderedEquals(['s1', 's2']));
  });

  test('aggiorna il preferito sostituendo i fornitori associati', () async {
    await insertCatalogPrerequisites();
    await insertSupplier('s1');
    await insertSupplier('s2');
    await dao.insertFavorite(buildFavorite(), 'f1', ['s1']);

    final replaced = await dao.updateFavorite(buildFavorite(), 'f1', ['s2']);

    expect(replaced, isTrue);
    expect(await dao.getSupplierIdsForFavorite('f1'), ['s2']);
  });

  test(
    'eliminare il fornitore rimuove la sua associazione (cascade)',
    () async {
      await insertCatalogPrerequisites();
      await insertSupplier('s1');
      await dao.insertFavorite(buildFavorite(), 'f1', ['s1']);

      await database.supplierDao.deleteSupplier('s1');

      expect(await dao.getSupplierIdsForFavorite('f1'), isEmpty);
    },
  );

  test(
    'eliminare un tipo dispositivo con preferiti collegati e\' rifiutato',
    () async {
      await insertCatalogPrerequisites();
      await dao.insertFavorite(buildFavorite(), 'f1', []);

      expect(
        () => database.catalogDao.deleteDeviceType('dt1'),
        throwsException,
      );
    },
  );
}
