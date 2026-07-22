import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

/// Contratto di persistenza per [Supplier] e per la sua compatibilita' con i
/// tipi di dispositivo (relazione `supplier_device_types`).
abstract interface class SupplierRepository {
  Future<List<Supplier>> getAll();

  Future<Supplier?> getById(String id);

  Future<void> create(Supplier supplier);

  Future<void> update(Supplier supplier);

  Future<void> delete(String id);

  Future<List<DeviceType>> getCompatibleDeviceTypes(String supplierId);

  Future<List<Supplier>> getCompatibleWithDeviceType(String deviceTypeId);

  Future<void> addCompatibleDeviceType(String supplierId, String deviceTypeId);

  Future<void> removeCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  );
}
