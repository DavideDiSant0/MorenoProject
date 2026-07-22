import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/supplier_dao.dart';
import 'package:repair_parts_finder/data/mappers/device_type_mapper.dart';
import 'package:repair_parts_finder/data/mappers/supplier_mapper.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/repositories/supplier_repository.dart';

class DriftSupplierRepository implements SupplierRepository {
  DriftSupplierRepository(this._dao);

  final SupplierDao _dao;

  @override
  Future<List<Supplier>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllSuppliers();
    return rows.map(supplierFromRow).toList();
  });

  @override
  Future<Supplier?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getSupplierById(id);
    return row == null ? null : supplierFromRow(row);
  });

  @override
  Future<void> create(Supplier supplier) => guardPersistence(
    () => _dao.insertSupplier(supplierToCompanion(supplier)),
  );

  @override
  Future<void> update(Supplier supplier) => guardPersistence(() async {
    final replaced = await _dao.updateSupplier(supplierToCompanion(supplier));
    if (!replaced) {
      throw NotFoundException('Fornitore non trovato: ${supplier.id}.');
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteSupplier(id);
    if (deletedCount == 0) {
      throw NotFoundException('Fornitore non trovato: $id.');
    }
  });

  @override
  Future<List<DeviceType>> getCompatibleDeviceTypes(String supplierId) =>
      guardPersistence(() async {
        final rows = await _dao.getCompatibleDeviceTypes(supplierId);
        return rows.map(deviceTypeFromRow).toList();
      });

  @override
  Future<List<Supplier>> getCompatibleWithDeviceType(String deviceTypeId) =>
      guardPersistence(() async {
        final rows = await _dao.getCompatibleWithDeviceType(deviceTypeId);
        return rows.map(supplierFromRow).toList();
      });

  @override
  Future<void> addCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) => guardPersistence(
    () => _dao.addCompatibleDeviceType(supplierId, deviceTypeId),
  );

  @override
  Future<void> removeCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) => guardPersistence(
    () => _dao.removeCompatibleDeviceType(supplierId, deviceTypeId),
  );
}
