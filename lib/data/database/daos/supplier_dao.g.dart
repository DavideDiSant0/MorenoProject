// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_dao.dart';

// ignore_for_file: type=lint
mixin _$SupplierDaoMixin on DatabaseAccessor<AppDatabase> {
  $SuppliersTable get suppliers => attachedDatabase.suppliers;
  $DeviceTypesTable get deviceTypes => attachedDatabase.deviceTypes;
  $SupplierDeviceTypesTable get supplierDeviceTypes =>
      attachedDatabase.supplierDeviceTypes;
  SupplierDaoManager get managers => SupplierDaoManager(this);
}

class SupplierDaoManager {
  final _$SupplierDaoMixin _db;
  SupplierDaoManager(this._db);
  $$SuppliersTableTableManager get suppliers =>
      $$SuppliersTableTableManager(_db.attachedDatabase, _db.suppliers);
  $$DeviceTypesTableTableManager get deviceTypes =>
      $$DeviceTypesTableTableManager(_db.attachedDatabase, _db.deviceTypes);
  $$SupplierDeviceTypesTableTableManager get supplierDeviceTypes =>
      $$SupplierDeviceTypesTableTableManager(
        _db.attachedDatabase,
        _db.supplierDeviceTypes,
      );
}
