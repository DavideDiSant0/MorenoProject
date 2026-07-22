import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';
import 'package:repair_parts_finder/data/mappers/component_mapper.dart';
import 'package:repair_parts_finder/data/mappers/device_type_mapper.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/repositories/device_type_repository.dart';

class DriftDeviceTypeRepository implements DeviceTypeRepository {
  DriftDeviceTypeRepository(this._dao);

  final CatalogDao _dao;

  @override
  Future<List<DeviceType>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllDeviceTypes();
    return rows.map(deviceTypeFromRow).toList();
  });

  @override
  Future<DeviceType?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getDeviceTypeById(id);
    return row == null ? null : deviceTypeFromRow(row);
  });

  @override
  Future<void> create(DeviceType deviceType) => guardPersistence(
    () => _dao.insertDeviceType(deviceTypeToCompanion(deviceType)),
  );

  @override
  Future<void> update(DeviceType deviceType) => guardPersistence(() async {
    final replaced = await _dao.updateDeviceType(
      deviceTypeToCompanion(deviceType),
    );
    if (!replaced) {
      throw NotFoundException(
        'Tipo di dispositivo non trovato: ${deviceType.id}.',
      );
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteDeviceType(id);
    if (deletedCount == 0) {
      throw NotFoundException('Tipo di dispositivo non trovato: $id.');
    }
  });

  @override
  Future<List<Component>> getCompatibleComponents(String deviceTypeId) =>
      guardPersistence(() async {
        final rows = await _dao.getCompatibleComponents(deviceTypeId);
        return rows.map(componentFromRow).toList();
      });

  @override
  Future<void> addCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) => guardPersistence(
    () => _dao.addCompatibleComponent(deviceTypeId, componentId),
  );

  @override
  Future<void> removeCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) => guardPersistence(
    () => _dao.removeCompatibleComponent(deviceTypeId, componentId),
  );
}
