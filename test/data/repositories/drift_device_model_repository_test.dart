import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_model_repository.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';

void main() {
  late AppDatabase database;
  late DriftDeviceModelRepository repository;

  setUp(() async {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftDeviceModelRepository(database.catalogDao);
    await database.catalogDao.insertDeviceType(
      DeviceTypesCompanion.insert(id: 'dt1', name: 'Smartphone'),
    );
    await database.catalogDao.insertBrand(
      BrandsCompanion.insert(id: 'b1', name: 'Apple'),
    );
  });

  tearDown(() async {
    await database.close();
  });

  DeviceModel buildModel({String id = 'm1', String name = 'iPhone 12'}) =>
      DeviceModel(id: id, name: name, deviceTypeId: 'dt1', brandId: 'b1');

  test('crea e filtra per tipo dispositivo e marca', () async {
    await repository.create(buildModel());

    final results = await repository.getByDeviceTypeAndBrand('dt1', 'b1');

    expect(results, hasLength(1));
    expect(results.single.name, 'iPhone 12');
  });

  test('update su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.update(buildModel(id: 'missing')),
      throwsA(isA<NotFoundException>()),
    );
  });

  test(
    'un nome duplicato per la stessa marca lancia PersistenceException',
    () async {
      await repository.create(buildModel());

      expect(
        () => repository.create(buildModel(id: 'm2')),
        throwsA(isA<PersistenceException>()),
      );
    },
  );
}
