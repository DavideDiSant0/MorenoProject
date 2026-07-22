import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_component_repository.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';

void main() {
  late AppDatabase database;
  late DriftComponentRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftComponentRepository(database.catalogDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('crea, aggiorna ed elimina un componente', () async {
    await repository.create(Component(id: '1', name: 'Schermo'));
    expect((await repository.getById('1'))!.name, 'Schermo');

    await repository.update(
      Component(id: '1', name: 'Schermo', description: 'OLED'),
    );
    expect((await repository.getById('1'))!.description, 'OLED');

    await repository.delete('1');
    expect(await repository.getById('1'), isNull);
  });

  test('delete su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.delete('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });
}
