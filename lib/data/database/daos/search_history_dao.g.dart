// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_dao.dart';

// ignore_for_file: type=lint
mixin _$SearchHistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $SearchHistoryEntriesTable get searchHistoryEntries =>
      attachedDatabase.searchHistoryEntries;
  $SuppliersTable get suppliers => attachedDatabase.suppliers;
  $SearchHistorySuppliersTable get searchHistorySuppliers =>
      attachedDatabase.searchHistorySuppliers;
  SearchHistoryDaoManager get managers => SearchHistoryDaoManager(this);
}

class SearchHistoryDaoManager {
  final _$SearchHistoryDaoMixin _db;
  SearchHistoryDaoManager(this._db);
  $$SearchHistoryEntriesTableTableManager get searchHistoryEntries =>
      $$SearchHistoryEntriesTableTableManager(
        _db.attachedDatabase,
        _db.searchHistoryEntries,
      );
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db.attachedDatabase, _db.suppliers);
  $$SearchHistorySuppliersTableTableManager get searchHistorySuppliers =>
      $$SearchHistorySuppliersTableTableManager(
        _db.attachedDatabase,
        _db.searchHistorySuppliers,
      );
}
