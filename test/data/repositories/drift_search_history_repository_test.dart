import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_search_history_repository.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';

void main() {
  late AppDatabase database;
  late DriftSearchHistoryRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSearchHistoryRepository(database.searchHistoryDao);
  });

  tearDown(() async {
    await database.close();
  });

  SearchHistory buildEntry({String id = 'h1'}) => SearchHistory(
    id: id,
    searchedAt: DateTime(2026, 1, 1),
    deviceType: 'Smartphone',
    brand: 'Apple',
    deviceModel: 'iPhone 12',
    component: 'Schermo',
    generatedQuery: 'iPhone 12 schermo',
    suppliers: [
      SearchHistorySupplier(
        id: '${id}_s1',
        searchHistoryId: id,
        supplierName: 'Fornitore Uno',
        generatedUrl: 'https://example.com/search?q=schermo',
      ),
    ],
  );

  test('crea e legge una voce con i suoi fornitori', () async {
    await repository.create(buildEntry());

    final fetched = await repository.getById('h1');

    expect(fetched, isNotNull);
    expect(fetched!.suppliers, hasLength(1));
  });

  test('delete su id inesistente lancia NotFoundException', () async {
    expect(
      () => repository.delete('missing'),
      throwsA(isA<NotFoundException>()),
    );
  });

  test('deleteAll svuota la cronologia', () async {
    await repository.create(buildEntry(id: 'h1'));
    await repository.create(buildEntry(id: 'h2'));

    await repository.deleteAll();

    expect(await repository.getAll(), isEmpty);
  });
}
