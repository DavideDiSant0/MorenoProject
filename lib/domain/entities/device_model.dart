import 'package:repair_parts_finder/core/utilities/list_equals.dart';
import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Modello specifico e ricercabile di un dispositivo, legato a un tipo e a
/// una marca. I termini alternativi aiutano a costruire query efficaci senza
/// perdere le denominazioni usate dai fornitori.
final class DeviceModel {
  DeviceModel({
    required this.id,
    required this.name,
    this.modelCode,
    List<String> alternativeSearchTerms = const [],
    required this.deviceTypeId,
    required this.brandId,
    this.isActive = true,
  }) : alternativeSearchTerms = List.unmodifiable(alternativeSearchTerms) {
    requireNotBlank(id, 'id');
    requireNotBlank(name, 'name');
    requireNotBlank(deviceTypeId, 'deviceTypeId');
    requireNotBlank(brandId, 'brandId');
  }

  final String id;
  final String name;
  final String? modelCode;
  final List<String> alternativeSearchTerms;
  final String deviceTypeId;
  final String brandId;
  final bool isActive;

  DeviceModel copyWith({
    String? name,
    String? modelCode,
    List<String>? alternativeSearchTerms,
    bool? isActive,
  }) {
    return DeviceModel(
      id: id,
      name: name ?? this.name,
      modelCode: modelCode ?? this.modelCode,
      alternativeSearchTerms:
          alternativeSearchTerms ?? this.alternativeSearchTerms,
      deviceTypeId: deviceTypeId,
      brandId: brandId,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceModel &&
          other.id == id &&
          other.name == name &&
          other.modelCode == modelCode &&
          listEquals(other.alternativeSearchTerms, alternativeSearchTerms) &&
          other.deviceTypeId == deviceTypeId &&
          other.brandId == brandId &&
          other.isActive == isActive);

  @override
  int get hashCode => Object.hash(
    id,
    name,
    modelCode,
    Object.hashAll(alternativeSearchTerms),
    deviceTypeId,
    brandId,
    isActive,
  );

  @override
  String toString() =>
      'DeviceModel(id: $id, name: $name, modelCode: $modelCode, '
      'alternativeSearchTerms: $alternativeSearchTerms, '
      'deviceTypeId: $deviceTypeId, brandId: $brandId, isActive: $isActive)';
}
