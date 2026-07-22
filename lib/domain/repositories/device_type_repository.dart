import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

/// Contratto di persistenza per [DeviceType] e per la sua compatibilita' con
/// i componenti (relazione `device_type_components`).
abstract interface class DeviceTypeRepository {
  Future<List<DeviceType>> getAll();

  Future<DeviceType?> getById(String id);

  Future<void> create(DeviceType deviceType);

  Future<void> update(DeviceType deviceType);

  Future<void> delete(String id);

  Future<List<Component>> getCompatibleComponents(String deviceTypeId);

  Future<void> addCompatibleComponent(String deviceTypeId, String componentId);

  Future<void> removeCompatibleComponent(
    String deviceTypeId,
    String componentId,
  );
}
