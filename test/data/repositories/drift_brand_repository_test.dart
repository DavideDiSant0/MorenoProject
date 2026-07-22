import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_brand_repository.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';

void main() {
  late AppDatabase database;
  late DriftBrandRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftBrandRepository(database.catalogDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('crea, aggiorna ed elimina una marca', () async {
    await repository.create(Brand(id: '1', name: 'Apple'));
    expect((await repository.getById('1'))!.name, 'Apple');

    await repository.update(Brand(id: '1', name: 'Apple Inc.'));
    expect((await repository.getById('1'))!.name, 'Apple Inc.');

    await repository.delete('1');
    expect(await repository.getById('1'), isNull);
  });

  test('update su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.update(Brand(id: 'missing', name: 'x')),
      throwsA(isA<NotFoundException>()),
    );
  });
}
