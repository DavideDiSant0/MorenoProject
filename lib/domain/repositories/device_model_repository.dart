import 'package:repair_parts_finder/domain/entities/device_model.dart';

/// Contratto di persistenza per [DeviceModel].
abstract interface class DeviceModelRepository {
  Future<List<DeviceModel>> getAll();

  Future<DeviceModel?> getById(String id);

  Future<List<DeviceModel>> getByDeviceTypeAndBrand(
    String deviceTypeId,
    String brandId,
  );

  Future<void> create(DeviceModel deviceModel);

  Future<void> update(DeviceModel deviceModel);

  Future<void> delete(String id);
}
