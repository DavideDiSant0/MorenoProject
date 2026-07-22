import 'package:repair_parts_finder/domain/entities/component.dart';

/// Contratto di persistenza per [Component].
abstract interface class ComponentRepository {
  Future<List<Component>> getAll();

  Future<Component?> getById(String id);

  Future<void> create(Component component);

  Future<void> update(Component component);

  Future<void> delete(String id);
}
