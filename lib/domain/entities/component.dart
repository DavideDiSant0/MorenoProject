import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Ricambio cercabile, ad esempio schermo o batteria.
final class Component {
  Component({
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

  Component copyWith({String? name, String? description, bool? isActive}) {
    return Component(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Component &&
          other.id == id &&
          other.name == name &&
          other.description == description &&
          other.isActive == isActive);

  @override
  int get hashCode => Object.hash(id, name, description, isActive);

  @override
  String toString() =>
      'Component(id: $id, name: $name, description: $description, '
      'isActive: $isActive)';
}
