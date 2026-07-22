import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_type_repository.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  late AppDatabase database;
  late DriftDeviceTypeRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftDeviceTypeRepository(database.catalogDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('crea e legge un tipo di dispositivo', () async {
    await repository.create(DeviceType(id: '1', name: 'Smartphone'));

    final fetched = await repository.getById('1');

    expect(fetched, isNotNull);
    expect(fetched!.name, 'Smartphone');
    expect(await repository.getAll(), hasLength(1));
  });

  test('update su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.update(DeviceType(id: 'missing', name: 'x')),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('delete su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.delete('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('gestisce la compatibilita\' con i componenti', () async {
    await repository.create(DeviceType(id: 'dt1', name: 'Smartphone'));
    await database.catalogDao.insertComponent(
      ComponentsCompanion.insert(id: 'c1', name: 'Schermo'),
    );

    await repository.addCompatibleComponent('dt1', 'c1');
    expect(
      (await repository.getCompatibleComponents('dt1')).single,
      isA<Component>().having((c) => c.id, 'id', 'c1'),
    );

    await repository.removeCompatibleComponent('dt1', 'c1');
    expect(await repository.getCompatibleComponents('dt1'), isEmpty);
  });

  test(
    'un errore SQLite imprevisto viene convertito in PersistenceException',
    () async {
      await repository.create(DeviceType(id: 'dt1', name: 'Smartphone'));

      expect(
        () => repository.create(DeviceType(id: 'dt1', name: 'Duplicato')),
        throwsA(isA<PersistenceException>()),
      );
    },
  );
}
