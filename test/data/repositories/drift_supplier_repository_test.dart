import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_supplier_repository.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

void main() {
  late AppDatabase database;
  late DriftSupplierRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSupplierRepository(database.supplierDao);
  });

  tearDown(() async {
    await database.close();
  });

  Supplier buildSupplier({String id = 's1'}) => Supplier(
    id: id,
    name: 'Fornitore Uno',
    baseUrl: 'https://example.com',
    urlTemplate: 'https://example.com/search?q={query}',
  );

  test('crea, aggiorna ed elimina un fornitore', () async {
    await repository.create(buildSupplier());
    expect((await repository.getById('s1'))!.name, 'Fornitore Uno');

    await repository.update(buildSupplier().copyWith(displayOrder: 3));
    expect((await repository.getById('s1'))!.displayOrder, 3);

    await repository.delete('s1');
    expect(await repository.getById('s1'), isNull);
  });

  test('delete su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.delete('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('gestisce la compatibilita\' con i tipi di dispositivo', () async {
    await repository.create(buildSupplier());
    await database.catalogDao.insertDeviceType(
      DeviceTypesCompanion.insert(id: 'dt1', name: 'Smartphone'),
    );

    await repository.addCompatibleDeviceType('s1', 'dt1');
    expect(await repository.getCompatibleWithDeviceType('dt1'), hasLength(1));

    await repository.removeCompatibleDeviceType('s1', 'dt1');
    expect(await repository.getCompatibleWithDeviceType('dt1'), isEmpty);
  });
}
