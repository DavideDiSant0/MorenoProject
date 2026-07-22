import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/favorites_table.dart';
import 'package:repair_parts_finder/data/database/tables/suppliers_table.dart';

/// A differenza delle FK di `favorites_table.dart`, qui entrambi i lati sono
/// `cascade`: perdere un fornitore candidato non invalida il preferito
/// (resta ripetibile con i fornitori restanti) e se il preferito stesso
/// viene eliminato le sue associazioni non hanno piu' motivo di esistere.
@DataClassName('FavoriteSupplierRow')
class FavoriteSuppliers extends Table {
  TextColumn get favoriteId =>
      text().references(Favorites, #id, onDelete: KeyAction.cascade)();
  TextColumn get supplierId =>
      text().references(Suppliers, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {favoriteId, supplierId};
}
