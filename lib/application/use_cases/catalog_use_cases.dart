import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/repositories/brand_repository.dart';
import 'package:repair_parts_finder/domain/repositories/component_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_model_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_type_repository.dart';

/// Casi d'uso del modulo Catalogo.
final class CatalogUseCases {
  const CatalogUseCases({
    required DeviceTypeRepository deviceTypeRepository,
    required BrandRepository brandRepository,
    required DeviceModelRepository deviceModelRepository,
    required ComponentRepository componentRepository,
  }) : _deviceTypeRepository = deviceTypeRepository,
       _brandRepository = brandRepository,
       _deviceModelRepository = deviceModelRepository,
       _componentRepository = componentRepository;

  final DeviceTypeRepository _deviceTypeRepository;
  final BrandRepository _brandRepository;
  final DeviceModelRepository _deviceModelRepository;
  final ComponentRepository _componentRepository;

  Future<List<DeviceType>> getDeviceTypes({bool activeOnly = false}) async {
    final items = await _deviceTypeRepository.getAll();
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<List<Brand>> getBrands({bool activeOnly = false}) async {
    final items = await _brandRepository.getAll();
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<List<DeviceModel>> getDeviceModels({bool activeOnly = false}) async {
    final items = await _deviceModelRepository.getAll();
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<List<DeviceModel>> getDeviceModelsForSelection({
    required String deviceTypeId,
    required String brandId,
    bool activeOnly = false,
  }) async {
    final items = await _deviceModelRepository.getByDeviceTypeAndBrand(
      deviceTypeId,
      brandId,
    );
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<List<Component>> getComponents({bool activeOnly = false}) async {
    final items = await _componentRepository.getAll();
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<List<Component>> getCompatibleComponents(
    String deviceTypeId, {
    bool activeOnly = false,
  }) async {
    final items = await _deviceTypeRepository.getCompatibleComponents(
      deviceTypeId,
    );
    return activeOnly ? items.where((item) => item.isActive).toList() : items;
  }

  Future<void> createDeviceType(DeviceType deviceType) =>
      _deviceTypeRepository.create(deviceType);

  Future<void> updateDeviceType(DeviceType deviceType) =>
      _deviceTypeRepository.update(deviceType);

  Future<void> deleteDeviceType(String id) => _deviceTypeRepository.delete(id);

  Future<void> createBrand(Brand brand) => _brandRepository.create(brand);

  Future<void> updateBrand(Brand brand) => _brandRepository.update(brand);

  Future<void> deleteBrand(String id) => _brandRepository.delete(id);

  Future<void> createDeviceModel(DeviceModel deviceModel) =>
      _deviceModelRepository.create(deviceModel);

  Future<void> updateDeviceModel(DeviceModel deviceModel) =>
      _deviceModelRepository.update(deviceModel);

  Future<void> deleteDeviceModel(String id) =>
      _deviceModelRepository.delete(id);

  Future<void> createComponent(Component component) =>
      _componentRepository.create(component);

  Future<void> updateComponent(Component component) =>
      _componentRepository.update(component);

  Future<void> deleteComponent(String id) => _componentRepository.delete(id);

  Future<void> addCompatibleComponent(String deviceTypeId, String componentId) {
    return _deviceTypeRepository.addCompatibleComponent(
      deviceTypeId,
      componentId,
    );
  }

  Future<void> removeCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) {
    return _deviceTypeRepository.removeCompatibleComponent(
      deviceTypeId,
      componentId,
    );
  }
}
