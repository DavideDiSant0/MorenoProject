import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Produttore o marchio commerciale di un dispositivo.
final class Brand {
  Brand({required this.id, required this.name, this.isActive = true}) {
    requireNotBlank(id, 'id');
    requireNotBlank(name, 'name');
  }

  final String id;
  final String name;
  final bool isActive;

  Brand copyWith({String? name, bool? isActive}) {
    return Brand(
      id: id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Brand &&
          other.id == id &&
          other.name == name &&
          other.isActive == isActive);

  @override
  int get hashCode => Object.hash(id, name, isActive);

  @override
  String toString() => 'Brand(id: $id, name: $name, isActive: $isActive)';
}
