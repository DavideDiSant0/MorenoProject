import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';

/// Seed iniziale per rendere utilizzabile un database appena creato.
///
/// Viene applicato solo quando catalogo e fornitori sono completamente vuoti:
/// in questo modo non mescola dati demo con dati gia inseriti dall'utente.
final class AppDemoDataSeeder {
  const AppDemoDataSeeder(this._database);

  final AppDatabase _database;

  Future<bool> seedIfEmpty() async {
    if (await _hasUserVisibleData()) {
      return false;
    }

    await _database.transaction(_insertDemoData);
    return true;
  }

  Future<bool> _hasUserVisibleData() async {
    final deviceTypes = await (_database.select(
      _database.deviceTypes,
    )..limit(1)).get();
    if (deviceTypes.isNotEmpty) {
      return true;
    }

    final brands = await (_database.select(_database.brands)..limit(1)).get();
    if (brands.isNotEmpty) {
      return true;
    }

    final models = await (_database.select(
      _database.deviceModels,
    )..limit(1)).get();
    if (models.isNotEmpty) {
      return true;
    }

    final components = await (_database.select(
      _database.components,
    )..limit(1)).get();
    if (components.isNotEmpty) {
      return true;
    }

    final suppliers = await (_database.select(
      _database.suppliers,
    )..limit(1)).get();
    return suppliers.isNotEmpty;
  }

  Future<void> _insertDemoData() async {
    await _insertDeviceTypes();
    await _insertBrands();
    await _insertComponents();
    await _insertDeviceModels();
    await _insertDeviceTypeComponents();
    await _insertSuppliers();
    await _insertSupplierDeviceTypes();
    await _insertFavorites();
  }

  Future<void> _insertDeviceTypes() async {
    for (final entry in _demoDeviceTypes) {
      await _database
          .into(_database.deviceTypes)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertBrands() async {
    for (final entry in _demoBrands) {
      await _database
          .into(_database.brands)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertComponents() async {
    for (final entry in _demoComponents) {
      await _database
          .into(_database.components)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertDeviceModels() async {
    for (final entry in _demoDeviceModels) {
      await _database
          .into(_database.deviceModels)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertDeviceTypeComponents() async {
    for (final entry in _demoDeviceTypeComponents) {
      await _database
          .into(_database.deviceTypeComponents)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertSuppliers() async {
    for (final entry in _demoSuppliers) {
      await _database
          .into(_database.suppliers)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertSupplierDeviceTypes() async {
    for (final entry in _demoSupplierDeviceTypes) {
      await _database
          .into(_database.supplierDeviceTypes)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }

  Future<void> _insertFavorites() async {
    for (final entry in _demoFavorites) {
      await _database
          .into(_database.favorites)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }

    for (final entry in _demoFavoriteSuppliers) {
      await _database
          .into(_database.favoriteSuppliers)
          .insert(entry, mode: InsertMode.insertOrIgnore);
    }
  }
}

const demoDeviceTypeSmartphoneId = 'demo-device-smartphone';
const demoDeviceTypeTabletId = 'demo-device-tablet';
const demoDeviceTypeLaptopId = 'demo-device-laptop';

const demoBrandAppleId = 'demo-brand-apple';
const demoBrandSamsungId = 'demo-brand-samsung';
const demoBrandXiaomiId = 'demo-brand-xiaomi';

const demoModelIphone13Id = 'demo-model-iphone-13';
const demoModelIphone14Id = 'demo-model-iphone-14';
const demoModelGalaxyS22Id = 'demo-model-galaxy-s22';
const demoModelGalaxyTabS8Id = 'demo-model-galaxy-tab-s8';
const demoModelRedmiNote12Id = 'demo-model-redmi-note-12';
const demoModelMacbookAirM1Id = 'demo-model-macbook-air-m1';

const demoComponentDisplayId = 'demo-component-display';
const demoComponentBatteryId = 'demo-component-battery';
const demoComponentChargingPortId = 'demo-component-charging-port';
const demoComponentBackCoverId = 'demo-component-back-cover';
const demoComponentCameraId = 'demo-component-camera';
const demoComponentSpeakerId = 'demo-component-speaker';
const demoComponentKeyboardId = 'demo-component-keyboard';

const demoSupplierIfixitId = 'demo-supplier-ifixit';
const demoSupplierSosavId = 'demo-supplier-sosav';
const demoSupplierEbayId = 'demo-supplier-ebay';

const demoFavoriteIphoneDisplayId = 'demo-favorite-iphone-display';

final List<DeviceTypesCompanion> _demoDeviceTypes = [
  DeviceTypesCompanion.insert(
    id: demoDeviceTypeSmartphoneId,
    name: 'Smartphone',
    description: Value('Telefoni iOS e Android di uso comune.'),
  ),
  DeviceTypesCompanion.insert(
    id: demoDeviceTypeTabletId,
    name: 'Tablet',
    description: Value('Tablet consumer e professionali.'),
  ),
  DeviceTypesCompanion.insert(
    id: demoDeviceTypeLaptopId,
    name: 'Laptop',
    description: Value('Notebook compatti e ultrabook.'),
  ),
];

final List<BrandsCompanion> _demoBrands = [
  BrandsCompanion.insert(id: demoBrandAppleId, name: 'Apple'),
  BrandsCompanion.insert(id: demoBrandSamsungId, name: 'Samsung'),
  BrandsCompanion.insert(id: demoBrandXiaomiId, name: 'Xiaomi'),
];

final List<ComponentsCompanion> _demoComponents = [
  ComponentsCompanion.insert(
    id: demoComponentDisplayId,
    name: 'Display',
    description: Value('Schermo, touch o pannello completo.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentBatteryId,
    name: 'Batteria',
    description: Value('Batteria sostitutiva compatibile.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentChargingPortId,
    name: 'Connettore ricarica',
    description: Value('Porta di ricarica o flat dock.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentBackCoverId,
    name: 'Back cover',
    description: Value('Vetro posteriore o scocca.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentCameraId,
    name: 'Fotocamera',
    description: Value('Modulo camera anteriore o posteriore.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentSpeakerId,
    name: 'Speaker',
    description: Value('Altoparlante, capsula o buzzer.'),
  ),
  ComponentsCompanion.insert(
    id: demoComponentKeyboardId,
    name: 'Tastiera',
    description: Value('Tastiera o top case per notebook.'),
  ),
];

final List<DeviceModelsCompanion> _demoDeviceModels = [
  DeviceModelsCompanion.insert(
    id: demoModelIphone13Id,
    name: 'iPhone 13',
    modelCode: Value('A2633'),
    alternativeSearchTerms: Value('iphone 13|a2633'),
    deviceTypeId: demoDeviceTypeSmartphoneId,
    brandId: demoBrandAppleId,
  ),
  DeviceModelsCompanion.insert(
    id: demoModelIphone14Id,
    name: 'iPhone 14',
    modelCode: Value('A2882'),
    alternativeSearchTerms: Value('iphone 14|a2882'),
    deviceTypeId: demoDeviceTypeSmartphoneId,
    brandId: demoBrandAppleId,
  ),
  DeviceModelsCompanion.insert(
    id: demoModelGalaxyS22Id,
    name: 'Galaxy S22',
    modelCode: Value('SM-S901B'),
    alternativeSearchTerms: Value('s22|sm-s901b'),
    deviceTypeId: demoDeviceTypeSmartphoneId,
    brandId: demoBrandSamsungId,
  ),
  DeviceModelsCompanion.insert(
    id: demoModelGalaxyTabS8Id,
    name: 'Galaxy Tab S8',
    modelCode: Value('SM-X700'),
    alternativeSearchTerms: Value('tab s8|sm-x700'),
    deviceTypeId: demoDeviceTypeTabletId,
    brandId: demoBrandSamsungId,
  ),
  DeviceModelsCompanion.insert(
    id: demoModelRedmiNote12Id,
    name: 'Redmi Note 12',
    modelCode: Value('23021RAAEG'),
    alternativeSearchTerms: Value('redmi note 12|23021raaeg'),
    deviceTypeId: demoDeviceTypeSmartphoneId,
    brandId: demoBrandXiaomiId,
  ),
  DeviceModelsCompanion.insert(
    id: demoModelMacbookAirM1Id,
    name: 'MacBook Air M1',
    modelCode: Value('A2337'),
    alternativeSearchTerms: Value('macbook air m1|a2337'),
    deviceTypeId: demoDeviceTypeLaptopId,
    brandId: demoBrandAppleId,
  ),
];

final List<DeviceTypeComponentsCompanion> _demoDeviceTypeComponents = [
  for (final componentId in [
    demoComponentDisplayId,
    demoComponentBatteryId,
    demoComponentChargingPortId,
    demoComponentBackCoverId,
    demoComponentCameraId,
    demoComponentSpeakerId,
  ])
    DeviceTypeComponentsCompanion.insert(
      deviceTypeId: demoDeviceTypeSmartphoneId,
      componentId: componentId,
    ),
  for (final componentId in [
    demoComponentDisplayId,
    demoComponentBatteryId,
    demoComponentChargingPortId,
    demoComponentCameraId,
    demoComponentSpeakerId,
  ])
    DeviceTypeComponentsCompanion.insert(
      deviceTypeId: demoDeviceTypeTabletId,
      componentId: componentId,
    ),
  for (final componentId in [
    demoComponentDisplayId,
    demoComponentBatteryId,
    demoComponentChargingPortId,
    demoComponentSpeakerId,
    demoComponentKeyboardId,
  ])
    DeviceTypeComponentsCompanion.insert(
      deviceTypeId: demoDeviceTypeLaptopId,
      componentId: componentId,
    ),
];

final List<SuppliersCompanion> _demoSuppliers = [
  SuppliersCompanion.insert(
    id: demoSupplierIfixitId,
    name: 'iFixit',
    baseUrl: 'https://www.ifixit.com',
    urlTemplate: 'https://www.ifixit.com/Search?query={query}',
    displayOrder: Value(0),
    notes: Value('Catalogo tecnico utile per ricambi e guide.'),
  ),
  SuppliersCompanion.insert(
    id: demoSupplierSosavId,
    name: 'SOSav',
    baseUrl: 'https://www.sosav.com',
    urlTemplate:
        'https://www.sosav.com/store/search?controller=search&s={query}',
    displayOrder: Value(1),
    notes: Value('Esempio di fornitore europeo con ricerca testuale.'),
  ),
  SuppliersCompanion.insert(
    id: demoSupplierEbayId,
    name: 'eBay Ricambi',
    baseUrl: 'https://www.ebay.it',
    urlTemplate: 'https://www.ebay.it/sch/i.html?_nkw={query}',
    displayOrder: Value(2),
    notes: Value('Marketplace generico per confronto disponibilita e prezzi.'),
  ),
];

final List<SupplierDeviceTypesCompanion> _demoSupplierDeviceTypes = [
  for (final deviceTypeId in [
    demoDeviceTypeSmartphoneId,
    demoDeviceTypeTabletId,
    demoDeviceTypeLaptopId,
  ])
    SupplierDeviceTypesCompanion.insert(
      supplierId: demoSupplierIfixitId,
      deviceTypeId: deviceTypeId,
    ),
  for (final deviceTypeId in [
    demoDeviceTypeSmartphoneId,
    demoDeviceTypeTabletId,
  ])
    SupplierDeviceTypesCompanion.insert(
      supplierId: demoSupplierSosavId,
      deviceTypeId: deviceTypeId,
    ),
  for (final deviceTypeId in [
    demoDeviceTypeSmartphoneId,
    demoDeviceTypeTabletId,
    demoDeviceTypeLaptopId,
  ])
    SupplierDeviceTypesCompanion.insert(
      supplierId: demoSupplierEbayId,
      deviceTypeId: deviceTypeId,
    ),
];

final List<FavoritesCompanion> _demoFavorites = [
  FavoritesCompanion.insert(
    id: demoFavoriteIphoneDisplayId,
    name: 'iPhone 13 display',
    deviceTypeId: demoDeviceTypeSmartphoneId,
    brandId: demoBrandAppleId,
    deviceModelId: demoModelIphone13Id,
    componentId: demoComponentDisplayId,
    createdAt: DateTime.utc(2026),
  ),
];

final List<FavoriteSuppliersCompanion> _demoFavoriteSuppliers = [
  FavoriteSuppliersCompanion.insert(
    favoriteId: demoFavoriteIphoneDisplayId,
    supplierId: demoSupplierIfixitId,
  ),
  FavoriteSuppliersCompanion.insert(
    favoriteId: demoFavoriteIphoneDisplayId,
    supplierId: demoSupplierEbayId,
  ),
];
