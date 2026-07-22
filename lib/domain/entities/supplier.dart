import 'package:repair_parts_finder/core/validation/require_not_blank.dart';

/// Fornitore configurabile dall'utente, con il proprio template URL di
/// ricerca. La validazione del template avviene in una fase successiva
/// (vedi `docs/07-url-template-system.md`): qui il valore e' testo opaco.
final class Supplier {
  Supplier({
    required this.id,
    required this.name,
    required this.baseUrl,
    required this.urlTemplate,
    this.displayOrder = 0,
    this.notes,
    this.isActive = true,
  }) {
    requireNotBlank(id, 'id');
    requireNotBlank(name, 'name');
    requireNotBlank(baseUrl, 'baseUrl');
    requireNotBlank(urlTemplate, 'urlTemplate');
  }

  final String id;
  final String name;
  final String baseUrl;
  final String urlTemplate;
  final int displayOrder;
  final String? notes;
  final bool isActive;

  Supplier copyWith({
    String? name,
    String? baseUrl,
    String? urlTemplate,
    int? displayOrder,
    String? notes,
    bool? isActive,
  }) {
    return Supplier(
      id: id,
      name: name ?? this.name,
      baseUrl: baseUrl ?? this.baseUrl,
      urlTemplate: urlTemplate ?? this.urlTemplate,
      displayOrder: displayOrder ?? this.displayOrder,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == id &&
          other.name == name &&
          other.baseUrl == baseUrl &&
          other.urlTemplate == urlTemplate &&
          other.displayOrder == displayOrder &&
          other.notes == notes &&
          other.isActive == isActive);

  @override
  int get hashCode => Object.hash(
    id,
    name,
    baseUrl,
    urlTemplate,
    displayOrder,
    notes,
    isActive,
  );

  @override
  String toString() =>
      'Supplier(id: $id, name: $name, baseUrl: $baseUrl, '
      'urlTemplate: $urlTemplate, displayOrder: $displayOrder, '
      'notes: $notes, isActive: $isActive)';
}
