import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Categoria di dispositivo ricercabile, ad esempio smartphone o tablet.
final class DeviceType {
  DeviceType({
    required this.id,
    required this.name,
    this.description,
    this.isActive = true,
  }) {
    requireNotBlank(id, 'id');
    requireNotBlank(name, 'name');
  }

  final String id;
  final String name;
  final String? description;
  final bool isActive;

  DeviceType copyWith({String? name, String? description, bool? isActive}) {
    return DeviceType(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceType &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.isActive == isActive);

  @override
  int get hashCode => Object.hash(id, name, description, isActive);

  @override
  String toString() =>
      'DeviceType(id: $id, name: $name, description: $description, '
      'isActive: $isActive)';
}
