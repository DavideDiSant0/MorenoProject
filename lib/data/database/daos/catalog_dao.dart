import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/tables/brands_table.dart';
import 'package:repair_parts_finder/data/database/tables/components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_models_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_type_components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';

part 'catalog_dao.g.dart';

/// Raggruppa l'accesso ai dati del modulo Catalogo (`docs/04-modules.md`):
/// tipi dispositivo, marche, modelli, componenti e la loro compatibilita'.
@DriftAccessor(
  tables: [DeviceTypes, Brands, DeviceModels, Components, DeviceTypeComponents],
)
class CatalogDao extends DatabaseAccessor<AppDatabase> with _$CatalogDaoMixin {
  CatalogDao(super.db);

  Future<List<DeviceTypeRow>> getAllDeviceTypes() => select(deviceTypes).get();

  Future<DeviceTypeRow?> getDeviceTypeById(String id) =>
      (select(deviceTypes)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertDeviceType(DeviceTypesCompanion entry) =>
      into(deviceTypes).insert(entry);

  Future<bool> updateDeviceType(DeviceTypesCompanion entry) =>
      update(deviceTypes).replace(entry);

  Future<int> deleteDeviceType(String id) =>
      (delete(deviceTypes)..where((t) => t.id.equals(id))).go();

  Future<List<BrandRow>> getAllBrands() => select(brands).get();

  Future<BrandRow?> getBrandById(String id) =>
      (select(brands)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertBrand(BrandsCompanion entry) => into(brands).insert(entry);

  Future<bool> updateBrand(BrandsCompanion entry) =>
      update(brands).replace(entry);

  Future<int> deleteBrand(String id) =>
      (delete(brands)..where((t) => t.id.equals(id))).go();

  Future<List<ComponentRow>> getAllComponents() => select(components).get();

  Future<ComponentRow?> getComponentById(String id) =>
      (select(components)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> insertComponent(ComponentsCompanion entry) =>
      into(components).insert(entry);

  Future<bool> updateComponent(ComponentsCompanion entry) =>
      update(components).replace(entry);

  Future<int> deleteComponent(String id) =>
      (delete(components)..where((t) => t.id.equals(id))).go();

  Future<List<DeviceModelRow>> getAllDeviceModels() =>
      select(deviceModels).get();

  Future<DeviceModelRow?> getDeviceModelById(String id) =>
      (select(deviceModels)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<DeviceModelRow>> getDeviceModelsByDeviceTypeAndBrand(
    String deviceTypeId,
    String brandId,
  ) =>
      (select(deviceModels)..where(
            (t) =>
                t.deviceTypeId.equals(deviceTypeId) & t.brandId.equals(brandId),
          ))
          .get();

  Future<void> insertDeviceModel(DeviceModelsCompanion entry) =>
      into(deviceModels).insert(entry);

  Future<bool> updateDeviceModel(DeviceModelsCompanion entry) =>
      update(deviceModels).replace(entry);

  Future<int> deleteDeviceModel(String id) =>
      (delete(deviceModels)..where((t) => t.id.equals(id))).go();

  Future<List<ComponentRow>> getCompatibleComponents(String deviceTypeId) {
    final query = select(components).join([
      innerJoin(
        deviceTypeComponents,
        deviceTypeComponents.componentId.equalsExp(components.id),
      ),
    ])..where(deviceTypeComponents.deviceTypeId.equals(deviceTypeId));
    return query.map((row) => row.readTable(components)).get();
  }

  Future<void> addCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) => into(deviceTypeComponents).insert(
    DeviceTypeComponentsCompanion.insert(
      deviceTypeId: deviceTypeId,
      componentId: componentId,
    ),
  );

  Future<int> removeCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) =>
      (delete(deviceTypeComponents)..where(
            (t) =>
                t.deviceTypeId.equals(deviceTypeId) &
                t.componentId.equals(componentId),
          ))
          .go();
}
