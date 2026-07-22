import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';

SearchHistory searchHistoryFromRow(
  SearchHistoryRow row,
  List<SearchHistorySupplierRow> supplierRows,
) {
  return SearchHistory(
    id: row.id,
    searchedAt: row.searchedAt,
    deviceType: row.deviceType,
    brand: row.brand,
    deviceModel: row.deviceModel,
    deviceModelCode: row.deviceModelCode,
    component: row.component,
    generatedQuery: row.generatedQuery,
    suppliers: supplierRows.map(searchHistorySupplierFromRow).toList(),
  );
}

SearchHistorySupplier searchHistorySupplierFromRow(
  SearchHistorySupplierRow row,
) {
  return SearchHistorySupplier(
    id: row.id,
    searchHistoryId: row.searchHistoryId,
    supplierId: row.supplierId,
    supplierName: row.supplierName,
    generatedUrl: row.generatedUrl,
    openResult: row.openResult,
  );
}

SearchHistoryEntriesCompanion searchHistoryToCompanion(SearchHistory entry) {
  return SearchHistoryEntriesCompanion.insert(
    id: entry.id,
    searchedAt: entry.searchedAt,
    deviceType: entry.deviceType,
    brand: entry.brand,
    deviceModel: entry.deviceModel,
    deviceModelCode: Value(entry.deviceModelCode),
    component: entry.component,
    generatedQuery: entry.generatedQuery,
  );
}

List<SearchHistorySuppliersCompanion> searchHistorySuppliersToCompanions(
  SearchHistory entry,
) {
  return entry.suppliers
      .map(
        (supplier) => SearchHistorySuppliersCompanion.insert(
          id: supplier.id,
          searchHistoryId: entry.id,
          supplierId: Value(supplier.supplierId),
          supplierName: supplier.supplierName,
          generatedUrl: supplier.generatedUrl,
          openResult: Value(supplier.openResult),
        ),
      )
      .toList();
}
