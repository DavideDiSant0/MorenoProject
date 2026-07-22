// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_dao.dart';

// ignore_for_file: type=lint
mixin _$CatalogDaoMixin on DatabaseAccessor<AppDatabase> {
  $DeviceTypesTable get deviceTypes => attachedDatabase.deviceTypes;
  $BrandsTable get brands => attachedDatabase.brands;
  $DeviceModelsTable get deviceModels => attachedDatabase.deviceModels;
  $ComponentsTable get components => attachedDatabase.components;
  $DeviceTypeComponentsTable get deviceTypeComponents =>
      attachedDatabase.deviceTypeComponents;
  CatalogDaoManager get managers => CatalogDaoManager(this);
}

class CatalogDaoManager {
  final _$CatalogDaoMixin _db;
  CatalogDaoManager(this._db);
  $$DeviceTypesTableTableManager get deviceTypes =>
      $$DeviceTypesTableTableManager(_db.attachedDatabase, _db.deviceTypes);
  $$BrandsTableTableManager get brands =>
      $$BrandsTableTableManager(_db.attachedDatabase, _db.brands);
  $$DeviceModelsTableTableManager get deviceModels =>
      $$DeviceModelsTableTableManager(_db.attachedDatabase, _db.deviceModels);
  $$ComponentsTableTableManager get components =>
      $$ComponentsTableTableManager(_db.attachedDatabase, _db.components);
  $$DeviceTypeComponentsTableTableManager get deviceTypeComponents =>
      $$DeviceTypeComponentsTableTableManager(
        _db.attachedDatabase,
        _db.deviceTypeComponents,
      );
}
