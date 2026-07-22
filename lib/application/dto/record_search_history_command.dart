import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Input applicativo per registrare una ricerca gia' preparata/eseguita.
final class RecordSearchHistoryCommand {
  RecordSearchHistoryCommand({
    required this.deviceType,
    required this.brand,
    required this.deviceModel,
    this.deviceModelCode,
    required this.component,
    required this.generatedQuery,
    required List<RecordSearchHistorySupplierCommand> suppliers,
    this.searchedAt,
  }) : suppliers = List.unmodifiable(suppliers) {
    requireNotBlank(deviceType, 'deviceType');
    requireNotBlank(brand, 'brand');
    requireNotBlank(deviceModel, 'deviceModel');
    requireNotBlank(component, 'component');
    requireNotBlank(generatedQuery, 'generatedQuery');
  }

  final String deviceType;
  final String brand;
  final String deviceModel;
  final String? deviceModelCode;
  final String component;
  final String generatedQuery;
  final List<RecordSearchHistorySupplierCommand> suppliers;
  final DateTime? searchedAt;
}

final class RecordSearchHistorySupplierCommand {
  RecordSearchHistorySupplierCommand({
    this.supplierId,
    required this.supplierName,
    required this.generatedUrl,
    this.openResult,
  }) {
    requireNotBlank(supplierName, 'supplierName');
    requireNotBlank(generatedUrl, 'generatedUrl');
  }

  final String? supplierId;
  final String supplierName;
  final String generatedUrl;
  final String? openResult;
}
