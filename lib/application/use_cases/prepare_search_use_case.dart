import 'package:repair_parts_finder/application/dto/prepared_search.dart';
import 'package:repair_parts_finder/application/dto/search_selection.dart';
import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/repositories/brand_repository.dart';
import 'package:repair_parts_finder/domain/repositories/component_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_model_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_type_repository.dart';
import 'package:repair_parts_finder/domain/repositories/supplier_repository.dart';

/// Prepara una ricerca eseguibile validando selezioni, stato attivo e
/// compatibilita' tra catalogo e fornitori.
final class PrepareSearchUseCase {
  const PrepareSearchUseCase({
    required DeviceTypeRepository deviceTypeRepository,
    required BrandRepository brandRepository,
    required DeviceModelRepository deviceModelRepository,
    required ComponentRepository componentRepository,
    required SupplierRepository supplierRepository,
  }) : _deviceTypeRepository = deviceTypeRepository,
       _brandRepository = brandRepository,
       _deviceModelRepository = deviceModelRepository,
       _componentRepository = componentRepository,
       _supplierRepository = supplierRepository;

  final DeviceTypeRepository _deviceTypeRepository;
  final BrandRepository _brandRepository;
  final DeviceModelRepository _deviceModelRepository;
  final ComponentRepository _componentRepository;
  final SupplierRepository _supplierRepository;

  Future<PreparedSearch> call(SearchSelection selection) async {
    if (selection.supplierIds.isEmpty) {
      throw const ValidationException(
        'Selezionare almeno un fornitore attivo e compatibile.',
      );
    }

    final deviceType = await _requireDeviceType(selection.deviceTypeId);
    final brand = await _requireBrand(selection.brandId);
    final deviceModel = await _requireDeviceModel(selection.deviceModelId);
    final component = await _requireComponent(selection.componentId);

    _requireActiveDeviceType(deviceType);
    _requireActiveBrand(brand);
    _requireActiveDeviceModel(deviceModel);
    _requireActiveComponent(component);
    _requireModelBelongsToSelection(deviceModel, deviceType, brand);
    await _requireCompatibleComponent(deviceType.id, component.id);

    final suppliers = <Supplier>[];
    for (final supplierId in selection.supplierIds) {
      final supplier = await _requireSupplier(supplierId);
      _requireActiveSupplier(supplier);
      suppliers.add(supplier);
    }
    await _requireCompatibleSuppliers(deviceType.id, suppliers);

    return PreparedSearch(
      deviceType: deviceType,
      brand: brand,
      deviceModel: deviceModel,
      component: component,
      suppliers: suppliers,
    );
  }

  Future<DeviceType> _requireDeviceType(String id) async {
    final item = await _deviceTypeRepository.getById(id);
    if (item == null) {
      throw NotFoundException('Tipo dispositivo non trovato: $id.');
    }
    return item;
  }

  Future<Brand> _requireBrand(String id) async {
    final item = await _brandRepository.getById(id);
    if (item == null) {
      throw NotFoundException('Marca non trovata: $id.');
    }
    return item;
  }

  Future<DeviceModel> _requireDeviceModel(String id) async {
    final item = await _deviceModelRepository.getById(id);
    if (item == null) {
      throw NotFoundException('Modello non trovato: $id.');
    }
    return item;
  }

  Future<Component> _requireComponent(String id) async {
    final item = await _componentRepository.getById(id);
    if (item == null) {
      throw NotFoundException('Componente non trovato: $id.');
    }
    return item;
  }

  Future<Supplier> _requireSupplier(String id) async {
    final item = await _supplierRepository.getById(id);
    if (item == null) {
      throw NotFoundException('Fornitore non trovato: $id.');
    }
    return item;
  }

  void _requireActiveDeviceType(DeviceType item) {
    if (!item.isActive) {
      throw const ValidationException('Il tipo dispositivo non e\' attivo.');
    }
  }

  void _requireActiveBrand(Brand item) {
    if (!item.isActive) {
      throw const ValidationException('La marca non e\' attiva.');
    }
  }

  void _requireActiveDeviceModel(DeviceModel item) {
    if (!item.isActive) {
      throw const ValidationException('Il modello non e\' attivo.');
    }
  }

  void _requireActiveComponent(Component item) {
    if (!item.isActive) {
      throw const ValidationException('Il componente non e\' attivo.');
    }
  }

  void _requireActiveSupplier(Supplier item) {
    if (!item.isActive) {
      throw ValidationException('Il fornitore ${item.name} non e\' attivo.');
    }
  }

  void _requireModelBelongsToSelection(
    DeviceModel model,
    DeviceType deviceType,
    Brand brand,
  ) {
    if (model.deviceTypeId != deviceType.id || model.brandId != brand.id) {
      throw const ValidationException(
        'Il modello selezionato non appartiene al tipo dispositivo e alla '
        'marca selezionati.',
      );
    }
  }

  Future<void> _requireCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) async {
    final compatibleComponents = await _deviceTypeRepository
        .getCompatibleComponents(deviceTypeId);
    final isCompatible = compatibleComponents.any(
      (component) => component.id == componentId,
    );
    if (!isCompatible) {
      throw const ValidationException(
        'Il componente non e\' compatibile con il tipo dispositivo selezionato.',
      );
    }
  }

  Future<void> _requireCompatibleSuppliers(
    String deviceTypeId,
    List<Supplier> selectedSuppliers,
  ) async {
    final compatibleSuppliers = await _supplierRepository
        .getCompatibleWithDeviceType(deviceTypeId);
    final compatibleIds = compatibleSuppliers
        .map((supplier) => supplier.id)
        .toSet();
    for (final supplier in selectedSuppliers) {
      if (!compatibleIds.contains(supplier.id)) {
        throw ValidationException(
          'Il fornitore ${supplier.name} non e\' compatibile con il '
          'tipo dispositivo selezionato.',
        );
      }
    }
  }
}
