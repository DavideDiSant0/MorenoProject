import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Input applicativo per creare un preferito da una combinazione di catalogo.
final class CreateFavoriteCommand {
  CreateFavoriteCommand({
    required this.name,
    required this.deviceTypeId,
    required this.brandId,
    required this.deviceModelId,
    required this.componentId,
    List<String> supplierIds = const [],
    this.createdAt,
  }) : supplierIds = List.unmodifiable(supplierIds) {
    requireNotBlank(name, 'name');
    requireNotBlank(deviceTypeId, 'deviceTypeId');
    requireNotBlank(brandId, 'brandId');
    requireNotBlank(deviceModelId, 'deviceModelId');
    requireNotBlank(componentId, 'componentId');
  }

  final String name;
  final String deviceTypeId;
  final String brandId;
  final String deviceModelId;
  final String componentId;
  final List<String> supplierIds;
  final DateTime? createdAt;
}
