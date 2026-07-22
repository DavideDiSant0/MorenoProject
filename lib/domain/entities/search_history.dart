import 'package:repair_parts_finder/core/utilities/list_equals.dart';
import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Voce di cronologia. Salva uno snapshot testuale dei valori visibili al
/// momento della ricerca, cosi' da restare comprensibile anche se il
/// catalogo o i fornitori cambiano in seguito (vedi `docs/06-data-model.md`).
final class SearchHistory {
  SearchHistory({
    required this.id,
    required this.searchedAt,
    required this.deviceType,
    required this.brand,
    required this.deviceModel,
    this.deviceModelCode,
    required this.component,
    required this.generatedQuery,
    required List<SearchHistorySupplier> suppliers,
  }) : suppliers = List.unmodifiable(suppliers) {
    requireNotBlank(id, 'id');
    requireNotBlank(deviceType, 'deviceType');
    requireNotBlank(brand, 'brand');
    requireNotBlank(deviceModel, 'deviceModel');
    requireNotBlank(component, 'component');
    requireNotBlank(generatedQuery, 'generatedQuery');
    if (suppliers.isEmpty) {
      throw ArgumentError.value(
        suppliers,
        'suppliers',
        'Una ricerca registrata deve avere almeno un fornitore.',
      );
    }
  }

  final String id;
  final DateTime searchedAt;
  final String deviceType;
  final String brand;
  final String deviceModel;
  final String? deviceModelCode;
  final String component;
  final String generatedQuery;
  final List<SearchHistorySupplier> suppliers;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistory &&
          other.id == id &&
          other.searchedAt == searchedAt &&
          other.deviceType == deviceType &&
          other.brand == brand &&
          other.deviceModel == deviceModel &&
          other.deviceModelCode == deviceModelCode &&
          other.component == component &&
          other.generatedQuery == generatedQuery &&
          listEquals(other.suppliers, suppliers));

  @override
  int get hashCode => Object.hash(
    id,
    searchedAt,
    deviceType,
    brand,
    deviceModel,
    deviceModelCode,
    component,
    generatedQuery,
    Object.hashAll(suppliers),
  );

  @override
  String toString() =>
      'SearchHistory(id: $id, searchedAt: $searchedAt, '
      'deviceType: $deviceType, brand: $brand, deviceModel: $deviceModel, '
      'deviceModelCode: $deviceModelCode, component: $component, '
      'generatedQuery: $generatedQuery, suppliers: $suppliers)';
}

/// Fornitore associato a una voce di cronologia. Il nome e' sempre uno
/// snapshot durevole; l'id e' un riferimento "best effort" al fornitore
/// ancora esistente, opzionale perche' il fornitore potrebbe essere stato
/// eliminato in seguito.
final class SearchHistorySupplier {
  SearchHistorySupplier({
    required this.id,
    required this.searchHistoryId,
    this.supplierId,
    required this.supplierName,
    required this.generatedUrl,
    this.openResult,
  }) {
    requireNotBlank(id, 'id');
    requireNotBlank(searchHistoryId, 'searchHistoryId');
    requireNotBlank(supplierName, 'supplierName');
    requireNotBlank(generatedUrl, 'generatedUrl');
  }

  final String id;
  final String searchHistoryId;
  final String? supplierId;
  final String supplierName;
  final String generatedUrl;
  final String? openResult;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SearchHistorySupplier &&
          other.id == id &&
          other.searchHistoryId == searchHistoryId &&
          other.supplierId == supplierId &&
          other.supplierName == supplierName &&
          other.generatedUrl == generatedUrl &&
          other.openResult == openResult);

  @override
  int get hashCode => Object.hash(
    id,
    searchHistoryId,
    supplierId,
    supplierName,
    generatedUrl,
    openResult,
  );

  @override
  String toString() =>
      'SearchHistorySupplier(id: $id, searchHistoryId: $searchHistoryId, '
      'supplierId: $supplierId, supplierName: $supplierName, '
      'generatedUrl: $generatedUrl, openResult: $openResult)';
}
