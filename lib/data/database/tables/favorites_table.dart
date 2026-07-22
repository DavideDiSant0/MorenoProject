import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/brands_table.dart';
import 'package:repair_parts_finder/data/database/tables/components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_models_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';

/// Un preferito e' contenuto creato dall'utente, non un metadato usa-e-getta:
/// tutte le FK verso il catalogo sono `restrict`. Cancellare in silenzio un
/// preferito perche' una voce di catalogo e' stata rimossa sarebbe una
/// modifica distruttiva non consentita da `AGENTS.md`; la disattivazione
/// (`isActive` sulle voci di catalogo) resta il percorso normale.
@DataClassName('FavoriteRow')
class Favorites extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get deviceTypeId =>
      text().references(DeviceTypes, #id, onDelete: KeyAction.restrict)();
  TextColumn get brandId =>
      text().references(Brands, #id, onDelete: KeyAction.restrict)();
  TextColumn get deviceModelId =>
      text().references(DeviceModels, #id, onDelete: KeyAction.restrict)();
  TextColumn get componentId =>
      text().references(Components, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
