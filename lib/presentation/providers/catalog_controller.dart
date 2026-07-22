import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/state/catalog_state.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

final catalogControllerProvider =
    AsyncNotifierProvider<CatalogController, CatalogState>(
      CatalogController.new,
    );

class CatalogController extends AsyncNotifier<CatalogState> {
  late CatalogUseCases _useCases;
  late IdGenerator _idGenerator;

  @override
  Future<CatalogState> build() async {
    _useCases = await ref.watch(catalogUseCasesProvider.future);
    _idGenerator = ref.watch(idGeneratorProvider);
    return _loadCatalogState();
  }

  Future<void> refresh() async {
    final current = _currentState;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _loadCatalogState(
        selectedDeviceTypeId: current?.selectedCompatibilityDeviceTypeId,
      ),
    );
  }

  Future<void> selectCompatibilityDeviceType(String? deviceTypeId) async {
    final current = _currentState;
    if (current == null) {
      return;
    }
    state = AsyncData(
      await _loadCatalogState(selectedDeviceTypeId: deviceTypeId),
    );
  }

  Future<void> saveDeviceType({
    String? id,
    required String name,
    String? description,
    required bool isActive,
  }) async {
    final entity = DeviceType(
      id: id ?? _idGenerator.nextId(),
      name: name,
      description: _blankToNull(description),
      isActive: isActive,
    );
    if (id == null) {
      await _useCases.createDeviceType(entity);
    } else {
      await _useCases.updateDeviceType(entity);
    }
    await refresh();
  }

  Future<void> deleteDeviceType(String id) async {
    await _useCases.deleteDeviceType(id);
    await refresh();
  }

  Future<void> saveBrand({
    String? id,
    required String name,
    required bool isActive,
  }) async {
    final entity = Brand(
      id: id ?? _idGenerator.nextId(),
      name: name,
      isActive: isActive,
    );
    if (id == null) {
      await _useCases.createBrand(entity);
    } else {
      await _useCases.updateBrand(entity);
    }
    await refresh();
  }

  Future<void> deleteBrand(String id) async {
    await _useCases.deleteBrand(id);
    await refresh();
  }

  Future<void> saveComponent({
    String? id,
    required String name,
    String? description,
    required bool isActive,
  }) async {
    final entity = Component(
      id: id ?? _idGenerator.nextId(),
      name: name,
      description: _blankToNull(description),
      isActive: isActive,
    );
    if (id == null) {
      await _useCases.createComponent(entity);
    } else {
      await _useCases.updateComponent(entity);
    }
    await refresh();
  }

  Future<void> deleteComponent(String id) async {
    await _useCases.deleteComponent(id);
    await refresh();
  }

  Future<void> saveDeviceModel({
    String? id,
    required String name,
    String? modelCode,
    required List<String> alternativeSearchTerms,
    required String deviceTypeId,
    required String brandId,
    required bool isActive,
  }) async {
    final entity = DeviceModel(
      id: id ?? _idGenerator.nextId(),
      name: name,
      modelCode: _blankToNull(modelCode),
      alternativeSearchTerms: alternativeSearchTerms,
      deviceTypeId: deviceTypeId,
      brandId: brandId,
      isActive: isActive,
    );
    if (id == null) {
      await _useCases.createDeviceModel(entity);
    } else {
      await _useCases.updateDeviceModel(entity);
    }
    await refresh();
  }

  Future<void> deleteDeviceModel(String id) async {
    await _useCases.deleteDeviceModel(id);
    await refresh();
  }

  Future<void> setComponentCompatibility({
    required String deviceTypeId,
    required String componentId,
    required bool isCompatible,
  }) async {
    if (isCompatible) {
      await _useCases.addCompatibleComponent(deviceTypeId, componentId);
    } else {
      await _useCases.removeCompatibleComponent(deviceTypeId, componentId);
    }
    state = AsyncData(
      await _loadCatalogState(selectedDeviceTypeId: deviceTypeId),
    );
  }

  Future<CatalogState> _loadCatalogState({String? selectedDeviceTypeId}) async {
    final deviceTypes = _sortByName(
      await _useCases.getDeviceTypes(),
      (item) => item.name,
    );
    final brands = _sortByName(
      await _useCases.getBrands(),
      (item) => item.name,
    );
    final deviceModels = _sortByName(
      await _useCases.getDeviceModels(),
      (item) => item.name,
    );
    final components = _sortByName(
      await _useCases.getComponents(),
      (item) => item.name,
    );
    final selectedId = _resolveSelectedDeviceTypeId(
      deviceTypes,
      selectedDeviceTypeId ?? _currentState?.selectedCompatibilityDeviceTypeId,
    );
    final compatibleComponents = selectedId == null
        ? <Component>[]
        : await _useCases.getCompatibleComponents(selectedId);

    return CatalogState(
      deviceTypes: deviceTypes,
      brands: brands,
      deviceModels: deviceModels,
      components: components,
      compatibleComponents: _sortByName(
        compatibleComponents,
        (item) => item.name,
      ),
      selectedCompatibilityDeviceTypeId: selectedId,
    );
  }

  CatalogState? get _currentState => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  List<T> _sortByName<T>(List<T> items, String Function(T item) getName) {
    final sorted = [...items];
    sorted.sort(
      (a, b) => getName(a).toLowerCase().compareTo(getName(b).toLowerCase()),
    );
    return sorted;
  }

  String? _resolveSelectedDeviceTypeId(
    List<DeviceType> deviceTypes,
    String? requestedId,
  ) {
    if (requestedId != null &&
        deviceTypes.any((deviceType) => deviceType.id == requestedId)) {
      return requestedId;
    }
    return deviceTypes.isEmpty ? null : deviceTypes.first.id;
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
