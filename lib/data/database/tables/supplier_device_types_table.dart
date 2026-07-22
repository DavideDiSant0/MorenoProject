import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';
import 'package:repair_parts_finder/data/database/tables/suppliers_table.dart';

/// Relazione molti-a-molti pura, stessa motivazione di
/// `device_type_components_table.dart`: `cascade` su entrambi i lati.
@DataClassName('SupplierDeviceTypeRow')
class SupplierDeviceTypes extends Table {
  TextColumn get supplierId =>
      text().references(Suppliers, #id, onDelete: KeyAction.cascade)();
  TextColumn get deviceTypeId =>
      text().references(DeviceTypes, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {supplierId, deviceTypeId};
}
