import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';
import 'package:repair_parts_finder/data/database/tables/supplier_device_types_table.dart';
import 'package:repair_parts_finder/data/database/tables/suppliers_table.dart';

part 'supplier_dao.g.dart';

/// Raggruppa l'accesso ai dati del modulo Fornitori (`docs/04-modules.md`):
/// fornitori e la loro compatibilita' con i tipi di dispositivo.
@DriftAccessor(tables: [Suppliers, SupplierDeviceTypes, DeviceTypes])
class SupplierDao extends DatabaseAccessor<AppDatabase>
    with _$SupplierDaoMixin {
  SupplierDao(super.db);

  Future<List<SupplierRow>> getAllSuppliers() => (select(
    suppliers,
  )..orderBy([(t) => OrderingTerm.asc(t.displayOrder)])).get();

  Future<SupplierRow?> getSupplierById(String id) =>
      (select(suppliers)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertSupplier(SuppliersCompanion entry) =>
      into(suppliers).insert(entry);

  Future<bool> updateSupplier(SuppliersCompanion entry) =>
      update(suppliers).replace(entry);

  Future<int> deleteSupplier(String id) =>
      (delete(suppliers)..where((t) => t.id.equals(id))).go();

  Future<List<DeviceTypeRow>> getCompatibleDeviceTypes(String supplierId) {
    final query = select(deviceTypes).join([
      innerJoin(
        supplierDeviceTypes,
        supplierDeviceTypes.deviceTypeId.equalsExp(deviceTypes.id),
      ),
    ])..where(supplierDeviceTypes.supplierId.equals(supplierId));
    return query.map((row) => row.readTable(deviceTypes)).get();
  }

  Future<List<SupplierRow>> getCompatibleWithDeviceType(String deviceTypeId) {
    final query = select(suppliers).join([
      innerJoin(
        supplierDeviceTypes,
        supplierDeviceTypes.supplierId.equalsExp(suppliers.id),
      ),
    ])..where(supplierDeviceTypes.deviceTypeId.equals(deviceTypeId));
    return query.map((row) => row.readTable(suppliers)).get();
  }

  Future<void> addCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) => into(supplierDeviceTypes).insert(
    SupplierDeviceTypesCompanion.insert(
      supplierId: supplierId,
      deviceTypeId: deviceTypeId,
    ),
  );

  Future<int> removeCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) =>
      (delete(supplierDeviceTypes)..where(
            (t) =>
                t.supplierId.equals(supplierId) &
                t.deviceTypeId.equals(deviceTypeId),
          ))
          .go();
}
