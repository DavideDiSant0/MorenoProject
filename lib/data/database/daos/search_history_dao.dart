import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/tables/search_history_suppliers_table.dart';
import 'package:repair_parts_finder/data/database/tables/search_history_table.dart';

part 'search_history_dao.g.dart';

/// Raggruppa l'accesso ai dati del modulo Cronologia (`docs/04-modules.md`).
/// Le due tabelle sono sempre lette e scritte insieme come un unico
/// aggregato, quindi condividono lo stesso DAO.
@DriftAccessor(tables: [SearchHistoryEntries, SearchHistorySuppliers])
class SearchHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$SearchHistoryDaoMixin {
  SearchHistoryDao(super.db);

  Future<List<SearchHistoryRow>> getAllEntries() => (select(
    searchHistoryEntries,
  )..orderBy([(t) => OrderingTerm.desc(t.searchedAt)])).get();

  Future<SearchHistoryRow?> getEntryById(String id) => (select(
    searchHistoryEntries,
  )..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<SearchHistorySupplierRow>> getSuppliersForEntry(
    String searchHistoryId,
  ) => (select(
    searchHistorySuppliers,
  )..where((t) => t.searchHistoryId.equals(searchHistoryId))).get();

  Future<void> insertEntry(
    SearchHistoryEntriesCompanion entry,
    List<SearchHistorySuppliersCompanion> entrySuppliers,
  ) => transaction(() async {
    await into(searchHistoryEntries).insert(entry);
    for (final supplierEntry in entrySuppliers) {
      await into(searchHistorySuppliers).insert(supplierEntry);
    }
  });

  Future<int> deleteEntry(String id) =>
      (delete(searchHistoryEntries)..where((t) => t.id.equals(id))).go();

  Future<void> deleteAllEntries() async {
    await delete(searchHistoryEntries).go();
  }
}
