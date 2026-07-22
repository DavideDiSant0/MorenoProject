import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/search_history_dao.dart';
import 'package:repair_parts_finder/data/mappers/search_history_mapper.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';
import 'package:repair_parts_finder/domain/repositories/search_history_repository.dart';

class DriftSearchHistoryRepository implements SearchHistoryRepository {
  DriftSearchHistoryRepository(this._dao);

  final SearchHistoryDao _dao;

  @override
  Future<List<SearchHistory>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllEntries();
    final entries = <SearchHistory>[];
    for (final row in rows) {
      final supplierRows = await _dao.getSuppliersForEntry(row.id);
      entries.add(searchHistoryFromRow(row, supplierRows));
    }
    return entries;
  });

  @override
  Future<SearchHistory?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getEntryById(id);
    if (row == null) {
      return null;
    }
    final supplierRows = await _dao.getSuppliersForEntry(id);
    return searchHistoryFromRow(row, supplierRows);
  });

  @override
  Future<void> create(SearchHistory entry) => guardPersistence(
    () => _dao.insertEntry(
      searchHistoryToCompanion(entry),
      searchHistorySuppliersToCompanions(entry),
    ),
  );

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteEntry(id);
    if (deletedCount == 0) {
      throw NotFoundException('Voce di cronologia non trovata: $id.');
    }
  });

  @override
  Future<void> deleteAll() => guardPersistence(() => _dao.deleteAllEntries());
}
