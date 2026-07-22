import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';
import 'package:repair_parts_finder/data/mappers/component_mapper.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/repositories/component_repository.dart';

class DriftComponentRepository implements ComponentRepository {
  DriftComponentRepository(this._dao);

  final CatalogDao _dao;

  @override
  Future<List<Component>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllComponents();
    return rows.map(componentFromRow).toList();
  });

  @override
  Future<Component?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getComponentById(id);
    return row == null ? null : componentFromRow(row);
  });

  @override
  Future<void> create(Component component) => guardPersistence(
    () => _dao.insertComponent(componentToCompanion(component)),
  );

  @override
  Future<void> update(Component component) => guardPersistence(() async {
    final replaced = await _dao.updateComponent(
      componentToCompanion(component),
    );
    if (!replaced) {
      throw NotFoundException('Componente non trovato: ${component.id}.');
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteComponent(id);
    if (deletedCount == 0) {
      throw NotFoundException('Componente non trovato: $id.');
    }
  });
}
