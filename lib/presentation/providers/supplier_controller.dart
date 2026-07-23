import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/state/supplier_state.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/supplier_use_cases.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

final supplierControllerProvider =
    AsyncNotifierProvider<SupplierController, SupplierState>(
      SupplierController.new,
    );

class SupplierController extends AsyncNotifier<SupplierState> {
  late SupplierUseCases _supplierUseCases;
  late CatalogUseCases _catalogUseCases;
  late IdGenerator _idGenerator;

  @override
  Future<SupplierState> build() async {
    _supplierUseCases = await ref.watch(supplierUseCasesProvider.future);
    _catalogUseCases = await ref.watch(catalogUseCasesProvider.future);
    _idGenerator = ref.watch(idGeneratorProvider);
    return _loadSupplierState();
  }

  Future<void> refresh() async {
    final current = _currentState;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _loadSupplierState(selectedSupplierId: current?.selectedSupplierId),
    );
  }

  Future<void> selectSupplier(String? supplierId) async {
    state = await AsyncValue.guard(
      () => _loadSupplierState(selectedSupplierId: supplierId),
    );
  }

  Future<void> saveSupplier({
    String? id,
    required String name,
    required String baseUrl,
    required String urlTemplate,
    required int displayOrder,
    String? notes,
    required bool isActive,
  }) async {
    final supplier = Supplier(
      id: id ?? _idGenerator.nextId(),
      name: name,
      baseUrl: baseUrl,
      urlTemplate: urlTemplate,
      displayOrder: displayOrder,
      notes: _blankToNull(notes),
      isActive: isActive,
    );

    if (id == null) {
      await _supplierUseCases.createSupplier(supplier);
    } else {
      await _supplierUseCases.updateSupplier(supplier);
    }
    state = AsyncData(
      await _loadSupplierState(selectedSupplierId: supplier.id),
    );
  }

  Future<void> deleteSupplier(String id) async {
    await _supplierUseCases.deleteSupplier(id);
    state = AsyncData(await _loadSupplierState());
  }

  Future<void> setDeviceTypeCompatibility({
    required String supplierId,
    required String deviceTypeId,
    required bool isCompatible,
  }) async {
    if (isCompatible) {
      await _supplierUseCases.addCompatibleDeviceType(supplierId, deviceTypeId);
    } else {
      await _supplierUseCases.removeCompatibleDeviceType(
        supplierId,
        deviceTypeId,
      );
    }
    state = AsyncData(await _loadSupplierState(selectedSupplierId: supplierId));
  }

  Future<void> moveSupplier(String supplierId, int direction) async {
    final current = _currentState;
    if (current == null) {
      return;
    }

    final ordered = [...current.suppliers];
    final oldIndex = ordered.indexWhere(
      (supplier) => supplier.id == supplierId,
    );
    if (oldIndex == -1) {
      return;
    }

    final newIndex = oldIndex + direction;
    if (newIndex < 0 || newIndex >= ordered.length) {
      return;
    }

    final moved = ordered.removeAt(oldIndex);
    ordered.insert(newIndex, moved);
    for (var index = 0; index < ordered.length; index++) {
      await _supplierUseCases.updateSupplier(
        ordered[index].copyWith(displayOrder: index),
      );
    }
    state = AsyncData(await _loadSupplierState(selectedSupplierId: supplierId));
  }

  Uri testTemplate(String template) {
    return _supplierUseCases.testTemplate(
      template,
      const UrlTemplateValues(
        query: 'iPhone 12 screen',
        deviceType: 'Smartphone',
        brand: 'Apple',
        model: 'iPhone 12',
        modelCode: 'A2403',
        component: 'Screen',
      ),
    );
  }

  Future<SupplierState> _loadSupplierState({String? selectedSupplierId}) async {
    final suppliers = _sortSuppliers(await _supplierUseCases.getSuppliers());
    final deviceTypes = _sortByName(
      await _catalogUseCases.getDeviceTypes(),
      (item) => item.name,
    );
    final requestedSelectedId =
        selectedSupplierId ?? _currentState?.selectedSupplierId;
    final selectedId =
        requestedSelectedId != null &&
            suppliers.any((supplier) => supplier.id == requestedSelectedId)
        ? requestedSelectedId
        : (suppliers.isEmpty ? null : suppliers.first.id);
    final compatibleDeviceTypes = selectedId == null
        ? <DeviceType>[]
        : await _supplierUseCases.getCompatibleDeviceTypes(selectedId);

    return SupplierState(
      suppliers: suppliers,
      deviceTypes: deviceTypes,
      compatibleDeviceTypes: _sortByName(
        compatibleDeviceTypes,
        (item) => item.name,
      ),
      selectedSupplierId: selectedId,
    );
  }

  SupplierState? get _currentState => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  List<Supplier> _sortSuppliers(List<Supplier> suppliers) {
    final sorted = [...suppliers];
    sorted.sort((a, b) {
      final orderComparison = a.displayOrder.compareTo(b.displayOrder);
      if (orderComparison != 0) {
        return orderComparison;
      }
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    return sorted;
  }

  List<T> _sortByName<T>(List<T> items, String Function(T item) getName) {
    final sorted = [...items];
    sorted.sort(
      (a, b) => getName(a).toLowerCase().compareTo(getName(b).toLowerCase()),
    );
    return sorted;
  }

  String? _blankToNull(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }
}
