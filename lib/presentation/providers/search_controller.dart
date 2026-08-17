import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/dto/record_search_history_command.dart';
import 'package:repair_parts_finder/application/dto/search_selection.dart';
import 'package:repair_parts_finder/application/state/search_state.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/build_search_query.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/open_external_url_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/prepare_search_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/search_history_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/supplier_use_cases.dart';
import 'package:repair_parts_finder/core/errors/app_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

final searchControllerProvider =
    AsyncNotifierProvider<SearchController, SearchState>(SearchController.new);

class SearchController extends AsyncNotifier<SearchState> {
  late CatalogUseCases _catalogUseCases;
  late SupplierUseCases _supplierUseCases;
  late PrepareSearchUseCase _prepareSearchUseCase;
  late SearchHistoryUseCases _searchHistoryUseCases;
  late AppSettingsUseCases _appSettingsUseCases;
  late OpenExternalUrlUseCase _openExternalUrlUseCase;
  late UrlTemplateGenerator _urlTemplateGenerator;
  Future<void> _pendingSelectionUpdate = Future<void>.value();
  bool _isOpeningUrls = false;

  @override
  Future<SearchState> build() async {
    _catalogUseCases = await ref.watch(catalogUseCasesProvider.future);
    _supplierUseCases = await ref.watch(supplierUseCasesProvider.future);
    _prepareSearchUseCase = await ref.watch(
      prepareSearchUseCaseProvider.future,
    );
    _searchHistoryUseCases = await ref.watch(
      searchHistoryUseCasesProvider.future,
    );
    _appSettingsUseCases = await ref.watch(appSettingsUseCasesProvider.future);
    _openExternalUrlUseCase = ref.watch(openExternalUrlUseCaseProvider);
    _urlTemplateGenerator = ref.watch(urlTemplateGeneratorProvider);
    return _buildStateForSelection(
      deviceTypeId: null,
      brandId: null,
      deviceModelId: null,
      componentId: null,
      supplierIds: const <String>{},
    );
  }

  Future<void> refresh() => _enqueueSelectionUpdate(() async {
    final current = _currentState;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _buildStateForSelection(
        deviceTypeId: current?.selectedDeviceTypeId,
        brandId: current?.selectedBrandId,
        deviceModelId: current?.selectedDeviceModelId,
        componentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  });

  Future<void> selectDeviceType(String? id) =>
      _enqueueSelectionUpdate(() async {
        final current = _currentState;
        state = await AsyncValue.guard(
          () => _buildStateForSelection(
            deviceTypeId: id,
            brandId: current?.selectedBrandId,
            deviceModelId: null,
            componentId: null,
            supplierIds: const <String>{},
          ),
        );
      });

  Future<void> selectBrand(String? id) => _enqueueSelectionUpdate(() async {
    final current = _currentState;
    state = await AsyncValue.guard(
      () => _buildStateForSelection(
        deviceTypeId: current?.selectedDeviceTypeId,
        brandId: id,
        deviceModelId: null,
        componentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  });

  Future<void> selectDeviceModel(String? id) =>
      _enqueueSelectionUpdate(() async {
        final current = _currentState;
        state = await AsyncValue.guard(
          () => _buildStateForSelection(
            deviceTypeId: current?.selectedDeviceTypeId,
            brandId: current?.selectedBrandId,
            deviceModelId: id,
            componentId: current?.selectedComponentId,
            supplierIds: current?.selectedSupplierIds ?? const <String>{},
          ),
        );
      });

  Future<void> selectComponent(String? id) => _enqueueSelectionUpdate(() async {
    final current = _currentState;
    state = await AsyncValue.guard(
      () => _buildStateForSelection(
        deviceTypeId: current?.selectedDeviceTypeId,
        brandId: current?.selectedBrandId,
        deviceModelId: current?.selectedDeviceModelId,
        componentId: id,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  });

  Future<void> setSupplierSelected(String supplierId, bool isSelected) =>
      _enqueueSelectionUpdate(() async {
        final current = _currentState;
        if (current == null) {
          return;
        }
        final supplierIds = {...current.selectedSupplierIds};
        if (isSelected) {
          supplierIds.add(supplierId);
        } else {
          supplierIds.remove(supplierId);
        }
        state = await AsyncValue.guard(
          () => _buildStateForSelection(
            deviceTypeId: current.selectedDeviceTypeId,
            brandId: current.selectedBrandId,
            deviceModelId: current.selectedDeviceModelId,
            componentId: current.selectedComponentId,
            supplierIds: supplierIds,
          ),
        );
      });

  Future<void> generatePreview() async {
    await _pendingSelectionUpdate;
    final current = _requireCurrentState();
    _ensureWithinPageLimit(current);
    final prepared = await _prepareSearchUseCase(_selectionFromState(current));
    final generatedQuery = buildSearchQuery(prepared);
    final values = UrlTemplateValues(
      query: generatedQuery,
      deviceType: prepared.deviceType.name,
      brand: prepared.brand.name,
      model: prepared.deviceModel.name,
      modelCode: prepared.deviceModel.modelCode,
      component: prepared.component.name,
    );
    final previewItems = [
      for (final supplier in prepared.suppliers)
        SearchPreviewItem(
          supplierId: supplier.id,
          supplierName: supplier.name,
          url: _urlTemplateGenerator.generate(supplier.urlTemplate, values),
        ),
    ];

    state = AsyncData(
      current.copyWith(
        previewItems: previewItems,
        generatedQuery: generatedQuery,
        lastResultMessage: 'Anteprima pronta',
      ),
    );
  }

  Future<void> openPreviewedUrls() async {
    await _pendingSelectionUpdate;
    if (_isOpeningUrls) {
      throw const ValidationException(
        'L\'apertura delle pagine e\' gia in corso.',
      );
    }
    final current = _requireCurrentState();
    if (current.previewItems.isEmpty || current.generatedQuery == null) {
      throw const ValidationException('Generare prima l\'anteprima URL.');
    }
    _ensureWithinPageLimit(current);

    _isOpeningUrls = true;
    try {
      final openedItems = <SearchPreviewItem>[];
      for (final item in current.previewItems) {
        try {
          await _openExternalUrlUseCase(item.url);
          openedItems.add(item.copyWith(openResult: 'opened'));
        } catch (error) {
          openedItems.add(item.copyWith(openResult: _messageFor(error)));
        }
      }

      if (current.settings.historyEnabled) {
        await _searchHistoryUseCases.recordSearch(
          RecordSearchHistoryCommand(
            deviceType: _nameForId(
              current.deviceTypes,
              current.selectedDeviceTypeId,
            ),
            brand: _nameForId(current.brands, current.selectedBrandId),
            deviceModel: _nameForId(
              current.deviceModels,
              current.selectedDeviceModelId,
            ),
            deviceModelCode: _modelCodeForId(
              current.deviceModels,
              current.selectedDeviceModelId,
            ),
            component: _nameForId(
              current.components,
              current.selectedComponentId,
            ),
            generatedQuery: current.generatedQuery!,
            suppliers: [
              for (final item in openedItems)
                RecordSearchHistorySupplierCommand(
                  supplierId: item.supplierId,
                  supplierName: item.supplierName,
                  generatedUrl: item.url.toString(),
                  openResult: item.openResult,
                ),
            ],
          ),
        );
      }

      state = AsyncData(
        current.copyWith(
          previewItems: openedItems,
          lastResultMessage: _openResultMessage(
            openedItems,
            historyEnabled: current.settings.historyEnabled,
          ),
        ),
      );
    } finally {
      _isOpeningUrls = false;
    }
  }

  Future<void> _enqueueSelectionUpdate(Future<void> Function() update) {
    final operation = _pendingSelectionUpdate.then((_) => update());
    _pendingSelectionUpdate = operation.catchError((Object _, StackTrace _) {});
    return operation;
  }

  Future<SearchState> _buildStateForSelection({
    required String? deviceTypeId,
    required String? brandId,
    required String? deviceModelId,
    required String? componentId,
    required Set<String> supplierIds,
  }) async {
    final deviceTypes = _sortByName(
      await _catalogUseCases.getDeviceTypes(activeOnly: true),
      (item) => item.name,
    );
    final brands = _sortByName(
      await _catalogUseCases.getBrands(activeOnly: true),
      (item) => item.name,
    );
    final selectedDeviceTypeId = _validId(deviceTypes, deviceTypeId);
    final selectedBrandId = _validId(brands, brandId);

    final deviceModels = selectedDeviceTypeId == null || selectedBrandId == null
        ? <DeviceModel>[]
        : _sortByName(
            await _catalogUseCases.getDeviceModelsForSelection(
              deviceTypeId: selectedDeviceTypeId,
              brandId: selectedBrandId,
              activeOnly: true,
            ),
            (item) => item.name,
          );
    final selectedDeviceModelId = _validId(deviceModels, deviceModelId);

    final components = selectedDeviceTypeId == null
        ? <Component>[]
        : _sortByName(
            await _catalogUseCases.getCompatibleComponents(
              selectedDeviceTypeId,
              activeOnly: true,
            ),
            (item) => item.name,
          );
    final selectedComponentId = _validId(components, componentId);

    final suppliers = selectedDeviceTypeId == null
        ? <Supplier>[]
        : _sortSuppliers(
            await _supplierUseCases.getCompatibleSuppliers(
              selectedDeviceTypeId,
              activeOnly: true,
            ),
          );
    final validSupplierIds = suppliers.map((supplier) => supplier.id).toSet();

    return SearchState(
      deviceTypes: deviceTypes,
      brands: brands,
      deviceModels: deviceModels,
      components: components,
      suppliers: suppliers,
      selectedSupplierIds: supplierIds.intersection(validSupplierIds),
      previewItems: const [],
      settings: await _appSettingsUseCases.getSettings(),
      selectedDeviceTypeId: selectedDeviceTypeId,
      selectedBrandId: selectedBrandId,
      selectedDeviceModelId: selectedDeviceModelId,
      selectedComponentId: selectedComponentId,
    );
  }

  SearchState _requireCurrentState() {
    final current = _currentState;
    if (current == null) {
      throw const ValidationException('La ricerca non e\' ancora pronta.');
    }
    return current;
  }

  SearchSelection _selectionFromState(SearchState state) {
    if (!state.hasCompleteSelection) {
      throw const ValidationException(
        'Completare selezione e fornitori prima dell\'anteprima.',
      );
    }
    return SearchSelection(
      deviceTypeId: state.selectedDeviceTypeId ?? '',
      brandId: state.selectedBrandId ?? '',
      deviceModelId: state.selectedDeviceModelId ?? '',
      componentId: state.selectedComponentId ?? '',
      supplierIds: state.selectedSupplierIds.toList(),
    );
  }

  void _ensureWithinPageLimit(SearchState state) {
    if (state.selectedSupplierIds.length > state.settings.maxPagesToOpen) {
      throw ValidationException(
        'Selezionare al massimo ${state.settings.maxPagesToOpen} fornitori.',
      );
    }
  }

  SearchState? get _currentState => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  String? _validId<T extends Object>(List<T> items, String? id) {
    if (id == null) {
      return null;
    }
    return items.any((item) => _idFor(item) == id) ? id : null;
  }

  String _idFor(Object item) {
    return switch (item) {
      DeviceType(:final id) => id,
      Brand(:final id) => id,
      DeviceModel(:final id) => id,
      Component(:final id) => id,
      Supplier(:final id) => id,
      _ => throw ArgumentError.value(
        item,
        'item',
        'Elemento di ricerca non supportato.',
      ),
    };
  }

  String _nameForId<T extends Object>(List<T> items, String? id) {
    Object? selectedItem;
    for (final item in items) {
      if (_idFor(item) == id) {
        selectedItem = item;
        break;
      }
    }
    return switch (selectedItem) {
      DeviceType(:final name) => name,
      Brand(:final name) => name,
      DeviceModel(:final name) => name,
      Component(:final name) => name,
      Supplier(:final name) => name,
      _ => '',
    };
  }

  String? _modelCodeForId(List<DeviceModel> items, String? id) {
    for (final item in items) {
      if (item.id == id) {
        return item.modelCode;
      }
    }
    return null;
  }

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

  String _messageFor(Object error) {
    return error is AppException
        ? error.message
        : 'Errore inatteso durante l\'apertura.';
  }

  String _openResultMessage(
    List<SearchPreviewItem> openedItems, {
    required bool historyEnabled,
  }) {
    final openedCount = openedItems
        .where((item) => item.openResult == _openedResult)
        .length;
    final failedCount = openedItems.length - openedCount;
    final baseMessage = failedCount == 0
        ? 'Aperti $openedCount URL'
        : 'Aperti $openedCount URL, $failedCount non riusciti';
    return historyEnabled
        ? '$baseMessage e salvati nella cronologia'
        : baseMessage;
  }
}

const _openedResult = 'opened';
