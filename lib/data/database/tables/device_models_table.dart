import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/brands_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';

/// Il tipo di dispositivo e la marca sono `restrict`: eliminarli mentre
/// esistono modelli collegati farebbe sparire silenziosamente il catalogo
/// dipendente, cosa vietata da `AGENTS.md`. La disattivazione (`isActive`)
/// resta il percorso normale per rimuovere un tipo/marca dal catalogo attivo.
@DataClassName('DeviceModelRow')
@TableIndex(
  name: 'idx_device_models_brand_name',
  columns: {#brandId, #name},
  unique: true,
)
class DeviceModels extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get modelCode => text().nullable()();
  TextColumn get alternativeSearchTerms => text().nullable()();
  TextColumn get deviceTypeId =>
      text().references(DeviceTypes, #id, onDelete: KeyAction.restrict)();
  TextColumn get brandId =>
      text().references(Brands, #id, onDelete: KeyAction.restrict)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
