import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

final class SupplierState {
  const SupplierState({
    required this.suppliers,
    required this.deviceTypes,
    required this.compatibleDeviceTypes,
    this.selectedSupplierId,
  });

  final List<Supplier> suppliers;
  final List<DeviceType> deviceTypes;
  final List<DeviceType> compatibleDeviceTypes;
  final String? selectedSupplierId;

  Supplier? get selectedSupplier {
    for (final supplier in suppliers) {
      if (supplier.id == selectedSupplierId) {
        return supplier;
      }
    }
    return null;
  }
}
