import 'package:repair_parts_finder/core/utilities/list_equals.dart';
import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Combinazione ricorrente di catalogo che l'utente vuole ripetere
/// rapidamente, con i fornitori preferiti associati.
final class Favorite {
  Favorite({
    required this.id,
    required this.name,
    required this.deviceTypeId,
    required this.brandId,
    required this.deviceModelId,
    required this.componentId,
    required this.createdAt,
    List<String> supplierIds = const [],
  }) : supplierIds = List.unmodifiable(supplierIds) {
    requireNotBlank(id, 'id');
    requireNotBlank(name, 'name');
    requireNotBlank(deviceTypeId, 'deviceTypeId');
    requireNotBlank(brandId, 'brandId');
    requireNotBlank(deviceModelId, 'deviceModelId');
    requireNotBlank(componentId, 'componentId');
  }

  final String id;
  final String name;
  final String deviceTypeId;
  final String brandId;
  final String deviceModelId;
  final String componentId;
  final DateTime createdAt;
  final List<String> supplierIds;

  Favorite copyWith({String? name, List<String>? supplierIds}) {
    return Favorite(
      id: id,
      name: name ?? this.name,
      deviceTypeId: deviceTypeId,
      brandId: brandId,
      deviceModelId: deviceModelId,
      componentId: componentId,
      createdAt: createdAt,
      supplierIds: supplierIds ?? this.supplierIds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == id &&
          other.name == name &&
          other.deviceTypeId == deviceTypeId &&
          other.brandId == brandId &&
          other.deviceModelId == deviceModelId &&
          other.componentId == componentId &&
          other.createdAt == createdAt &&
          listEquals(other.supplierIds, supplierIds));

  @override
  int get hashCode => Object.hash(
    id,
    name,
    deviceTypeId,
    brandId,
    deviceModelId,
    componentId,
    createdAt,
    Object.hashAll(supplierIds),
  );

  @override
  String toString() =>
      'Favorite(id: $id, name: $name, deviceTypeId: $deviceTypeId, '
      'brandId: $brandId, deviceModelId: $deviceModelId, '
      'componentId: $componentId, createdAt: $createdAt, '
      'supplierIds: $supplierIds)';
}
