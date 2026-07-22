// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_dao.dart';

// ignore_for_file: type=lint
mixin _$FavoriteDaoMixin on DatabaseAccessor<AppDatabase> {
  $DeviceTypesTable get deviceTypes => attachedDatabase.deviceTypes;
  $BrandsTable get brands => attachedDatabase.brands;
  $DeviceModelsTable get deviceModels => attachedDatabase.deviceModels;
  $ComponentsTable get components => attachedDatabase.components;
  $FavoritesTable get favorites => attachedDatabase.favorites;
  $SuppliersTable get suppliers => attachedDatabase.suppliers;
  $FavoriteSuppliersTable get favoriteSuppliers =>
      attachedDatabase.favoriteSuppliers;
  FavoriteDaoManager get managers => FavoriteDaoManager(this);
}

class FavoriteDaoManager {
  final _$FavoriteDaoMixin _db;
  FavoriteDaoManager(this._db);
  $$DeviceTypesTableTableManager get deviceTypes =>
      $$DeviceTypesTableTableManager(_db.attachedDatabase, _db.deviceTypes);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db.attachedDatabase, _db.brands);
  $$DeviceModelsTableTableManager get deviceModels =>
      $$DeviceModelsTableTableManager(_db.attachedDatabase, _db.deviceModels);
  $$ComponentsTableTableManager get components =>
      $$ComponentsTableTableManager(_db.attachedDatabase, _db.components);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db.attachedDatabase, _db.favorites);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db.attachedDatabase, _db.suppliers);
  $$FavoriteSuppliersTableTableManager get favoriteSuppliers =>
      $$FavoriteSuppliersTableTableManager(
        _db.attachedDatabase,
        _db.favoriteSuppliers,
      );
}
