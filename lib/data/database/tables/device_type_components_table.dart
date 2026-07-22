import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';

/// Relazione molti-a-molti pura: nessun valore indipendente dalle due righe
/// collegate, quindi `cascade` su entrambi i lati e' sicuro e corretto.
@DataClassName('DeviceTypeComponentRow')
class DeviceTypeComponents extends Table {
  TextColumn get deviceTypeId =>
      text().references(DeviceTypes, #id, onDelete: KeyAction.cascade)();
  TextColumn get componentId =>
      text().references(Components, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {deviceTypeId, componentId};
}
