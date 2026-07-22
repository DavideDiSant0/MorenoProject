import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Selezione completa richiesta per preparare una ricerca eseguibile.
final class SearchSelection {
  SearchSelection({
    required this.deviceTypeId,
    required this.brandId,
    required this.deviceModelId,
    required this.componentId,
    required List<String> supplierIds,
  }) : supplierIds = List.unmodifiable(supplierIds) {
    requireNotBlank(deviceTypeId, 'deviceTypeId');
    requireNotBlank(brandId, 'brandId');
    requireNotBlank(deviceModelId, 'deviceModelId');
    requireNotBlank(componentId, 'componentId');
  }

  final String deviceTypeId;
  final String brandId;
  final String deviceModelId;
  final String componentId;
  final List<String> supplierIds;
}
