import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';
import 'package:repair_parts_finder/data/mappers/device_model_mapper.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/repositories/device_model_repository.dart';

class DriftDeviceModelRepository implements DeviceModelRepository {
  DriftDeviceModelRepository(this._dao);

  final CatalogDao _dao;

  @override
  Future<List<DeviceModel>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllDeviceModels();
    return rows.map(deviceModelFromRow).toList();
  });

  @override
  Future<DeviceModel?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getDeviceModelById(id);
    return row == null ? null : deviceModelFromRow(row);
  });

  @override
  Future<List<DeviceModel>> getByDeviceTypeAndBrand(
    String deviceTypeId,
    String brandId,
  ) => guardPersistence(() async {
    final rows = await _dao.getDeviceModelsByDeviceTypeAndBrand(
      deviceTypeId,
      brandId,
    );
    return rows.map(deviceModelFromRow).toList();
  });

  @override
  Future<void> create(DeviceModel deviceModel) => guardPersistence(
    () => _dao.insertDeviceModel(deviceModelToCompanion(deviceModel)),
  );

  @override
  Future<void> update(DeviceModel deviceModel) => guardPersistence(() async {
    final replaced = await _dao.updateDeviceModel(
      deviceModelToCompanion(deviceModel),
    );
    if (!replaced) {
      throw NotFoundException('Modello non trovato: ${deviceModel.id}.');
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteDeviceModel(id);
    if (deletedCount == 0) {
      throw NotFoundException('Modello non trovato: $id.');
    }
  });
}
