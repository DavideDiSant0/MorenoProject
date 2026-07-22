import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/tables/search_history_table.dart';
import 'package:repair_parts_finder/data/database/tables/suppliers_table.dart';

/// `supplierName` e' lo snapshot durevole, sempre presente. `supplierId' e'
/// un collegamento "best effort" al fornitore ancora esistente: nullable e
/// `setNull` in cascata, cosi' la cronologia sopravvive alla cancellazione
/// del fornitore. Serve un id surrogato perche' `supplierId` puo' essere
/// nullo e quindi non puo' far parte di una chiave primaria.
@DataClassName('SearchHistorySupplierRow')
class SearchHistorySuppliers extends Table {
  TextColumn get id => text()();
  TextColumn get searchHistoryId => text().references(
    SearchHistoryEntries,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get supplierId => text().nullable().references(
    Suppliers,
    #id,
    onDelete: KeyAction.setNull,
  )();
  TextColumn get supplierName => text()();
  TextColumn get generatedUrl => text()();
  TextColumn get openResult => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
