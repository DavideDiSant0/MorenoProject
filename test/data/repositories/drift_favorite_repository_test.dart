import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_favorite_repository.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';

void main() {
  late AppDatabase database;
  late DriftFavoriteRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftFavoriteRepository(database.favoriteDao);

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
  });

  tearDown(() async {
    await database.close();
  });

  Favorite buildFavorite({String id = 'f1', List<String>? supplierIds}) =>
      Favorite(
        id: id,
        name: 'iPhone 12 schermo',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        deviceModelId: 'm1',
        componentId: 'c1',
        createdAt: DateTime(2026, 1, 1),
        supplierIds: supplierIds ?? const [],
      );

  test('crea e legge un preferito', () async {
    await repository.create(buildFavorite());

    final fetched = await repository.getById('f1');

    expect(fetched, isNotNull);
    expect(fetched!.name, 'iPhone 12 schermo');
  });

  test('update su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.update(buildFavorite(id: 'missing')),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('delete su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.delete('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });
}
