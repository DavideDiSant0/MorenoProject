import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

Supplier supplierFromRow(SupplierRow row) {
  return Supplier(
    id: row.id,
    name: row.name,
    baseUrl: row.baseUrl,
    urlTemplate: row.urlTemplate,
    displayOrder: row.displayOrder,
    notes: row.notes,
    isActive: row.isActive,
  );
}

SuppliersCompanion supplierToCompanion(Supplier supplier) {
  return SuppliersCompanion.insert(
    id: supplier.id,
    name: supplier.name,
    baseUrl: supplier.baseUrl,
    urlTemplate: supplier.urlTemplate,
    displayOrder: Value(supplier.displayOrder),
    notes: Value(supplier.notes),
    isActive: Value(supplier.isActive),
  );
}
