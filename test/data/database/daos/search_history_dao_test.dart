import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/search_history_dao.dart';

void main() {
  late AppDatabase database;
  late SearchHistoryDao dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = database.searchHistoryDao;
  });

  tearDown(() async {
    await database.close();
  });

  Future<void> insertSupplier({String id = 'sup1'}) =>
      database.supplierDao.insertSupplier(
        SuppliersCompanion.insert(
          id: id,
          name: 'Fornitore Uno',
          baseUrl: 'https://example.com',
          urlTemplate: 'https://example.com/search?q={query}',
        ),
      );

  SearchHistoryEntriesCompanion buildEntry({
    String id = 'h1',
    DateTime? searchedAt,
  }) => SearchHistoryEntriesCompanion.insert(
    id: id,
    searchedAt: searchedAt ?? DateTime(2026, 1, 1),
    deviceType: 'Smartphone',
    brand: 'Apple',
    deviceModel: 'iPhone 12',
    component: 'Schermo',
    generatedQuery: 'iPhone 12 schermo',
  );

  test('inserisce la voce con i suoi fornitori in una transazione', () async {
    await insertSupplier();
    await dao.insertEntry(buildEntry(), [
      SearchHistorySuppliersCompanion.insert(
        id: 'hs1',
        searchHistoryId: 'h1',
        supplierId: const Value('sup1'),
        supplierName: 'Fornitore Uno',
        generatedUrl: 'https://example.com/search?q=schermo',
      ),
    ]);

    final entry = await dao.getEntryById('h1');
    final suppliers = await dao.getSuppliersForEntry('h1');

    expect(entry, isNotNull);
    expect(suppliers, hasLength(1));
    expect(suppliers.single.supplierName, 'Fornitore Uno');
  });

  test('elenca le voci in ordine decrescente di data', () async {
    await dao.insertEntry(
      buildEntry(id: 'h1', searchedAt: DateTime(2026, 1, 1)),
      [],
    );
    await dao.insertEntry(
      buildEntry(id: 'h2', searchedAt: DateTime(2026, 6, 1)),
      [],
    );

    final entries = await dao.getAllEntries();

    expect(entries.map((e) => e.id), ['h2', 'h1']);
  });

  test('cancellare la voce rimuove i fornitori collegati (cascade)', () async {
    await insertSupplier();
    await dao.insertEntry(buildEntry(), [
      SearchHistorySuppliersCompanion.insert(
        id: 'hs1',
        searchHistoryId: 'h1',
        supplierName: 'Fornitore Uno',
        generatedUrl: 'https://example.com',
      ),
    ]);

    await dao.deleteEntry('h1');

    expect(await dao.getSuppliersForEntry('h1'), isEmpty);
  });

  test(
    'cancellare il fornitore imposta a null il riferimento (setNull)',
    () async {
      await insertSupplier();
      await dao.insertEntry(buildEntry(), [
        SearchHistorySuppliersCompanion.insert(
          id: 'hs1',
          searchHistoryId: 'h1',
          supplierId: const Value('sup1'),
          supplierName: 'Fornitore Uno',
          generatedUrl: 'https://example.com',
        ),
      ]);

      await database.supplierDao.deleteSupplier('sup1');

      final suppliers = await dao.getSuppliersForEntry('h1');
      expect(suppliers, hasLength(1));
      expect(suppliers.single.supplierId, isNull);
      expect(suppliers.single.supplierName, 'Fornitore Uno');
    },
  );

  test('deleteAllEntries svuota la cronologia', () async {
    await dao.insertEntry(buildEntry(id: 'h1'), []);
    await dao.insertEntry(buildEntry(id: 'h2'), []);

    await dao.deleteAllEntries();

    expect(await dao.getAllEntries(), isEmpty);
  });
}
