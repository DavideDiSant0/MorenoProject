import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/dto/create_favorite_command.dart';
import 'package:repair_parts_finder/application/dto/prepared_search.dart';
import 'package:repair_parts_finder/application/dto/record_search_history_command.dart';
import 'package:repair_parts_finder/application/dto/search_selection.dart';
import 'package:repair_parts_finder/application/state/favorite_state.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/favorite_use_cases.dart';
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
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

final favoriteControllerProvider =
    AsyncNotifierProvider<FavoriteController, FavoriteState>(
      FavoriteController.new,
    );

class FavoriteController extends AsyncNotifier<FavoriteState> {
  late FavoriteUseCases _favoriteUseCases;
  late CatalogUseCases _catalogUseCases;
  late SupplierUseCases _supplierUseCases;
  late PrepareSearchUseCase _prepareSearchUseCase;
  late SearchHistoryUseCases _searchHistoryUseCases;
  late AppSettingsUseCases _appSettingsUseCases;
  late OpenExternalUrlUseCase _openExternalUrlUseCase;
  late UrlTemplateGenerator _urlTemplateGenerator;

  @override
  Future<FavoriteState> build() async {
    _favoriteUseCases = await ref.watch(favoriteUseCasesProvider.future);
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
    return _loadFavoriteState(
      selectedFavoriteId: null,
      selectedDeviceTypeId: null,
      selectedBrandId: null,
      selectedDeviceModelId: null,
      selectedComponentId: null,
      supplierIds: const <String>{},
    );
  }

  Future<void> refresh() async {
    final current = _currentState;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _loadFavoriteState(
        selectedFavoriteId: current?.selectedFavoriteId,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: current?.selectedDeviceModelId,
        selectedComponentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  }

  Future<void> selectFavorite(String? favoriteId) async {
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: favoriteId,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: current?.selectedDeviceModelId,
        selectedComponentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  }

  Future<void> selectDeviceType(String? id) async {
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: current?.selectedFavoriteId,
        selectedDeviceTypeId: id,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: null,
        selectedComponentId: null,
        supplierIds: const <String>{},
      ),
    );
  }

  Future<void> selectBrand(String? id) async {
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: current?.selectedFavoriteId,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: id,
        selectedDeviceModelId: null,
        selectedComponentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  }

  Future<void> selectDeviceModel(String? id) async {
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: current?.selectedFavoriteId,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: id,
        selectedComponentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  }

  Future<void> selectComponent(String? id) async {
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: current?.selectedFavoriteId,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: current?.selectedDeviceModelId,
        selectedComponentId: id,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
      ),
    );
  }

  Future<void> setSupplierSelected(String supplierId, bool isSelected) async {
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
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: current.selectedFavoriteId,
        selectedDeviceTypeId: current.selectedDeviceTypeId,
        selectedBrandId: current.selectedBrandId,
        selectedDeviceModelId: current.selectedDeviceModelId,
        selectedComponentId: current.selectedComponentId,
        supplierIds: supplierIds,
      ),
    );
  }

  Future<void> saveFavorite(String name) async {
    final current = _requireCurrentState();
    if (!current.canSaveFavorite) {
      throw const ValidationException(
        'Completare la combinazione prima di salvarla.',
      );
    }
    final favorite = await _favoriteUseCases.createFavorite(
      CreateFavoriteCommand(
        name: name,
        deviceTypeId: current.selectedDeviceTypeId!,
        brandId: current.selectedBrandId!,
        deviceModelId: current.selectedDeviceModelId!,
        componentId: current.selectedComponentId!,
        supplierIds: current.selectedSupplierIds.toList(),
      ),
    );
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: favorite.id,
        selectedDeviceTypeId: current.selectedDeviceTypeId,
        selectedBrandId: current.selectedBrandId,
        selectedDeviceModelId: current.selectedDeviceModelId,
        selectedComponentId: current.selectedComponentId,
        supplierIds: current.selectedSupplierIds,
        lastResultMessage: 'Favorite saved',
      ),
    );
  }

  Future<void> deleteFavorite(String favoriteId) async {
    await _favoriteUseCases.deleteFavorite(favoriteId);
    final current = _currentState;
    state = AsyncData(
      await _loadFavoriteState(
        selectedFavoriteId: null,
        selectedDeviceTypeId: current?.selectedDeviceTypeId,
        selectedBrandId: current?.selectedBrandId,
        selectedDeviceModelId: current?.selectedDeviceModelId,
        selectedComponentId: current?.selectedComponentId,
        supplierIds: current?.selectedSupplierIds ?? const <String>{},
        lastResultMessage: 'Favorite deleted',
      ),
    );
  }

  Future<void> launchFavorite(String favoriteId) async {
    final current = _requireCurrentState();
    final favorite = current.favorites.firstWhere(
      (favorite) => favorite.id == favoriteId,
      orElse: () => throw const ValidationException(
        'Selezionare un preferito da rilanciare.',
      ),
    );
    if (favorite.supplierIds.length > current.settings.maxPagesToOpen) {
      throw ValidationException(
        'Il preferito contiene ${favorite.supplierIds.length} fornitori: '
        'il limite attuale e\' ${current.settings.maxPagesToOpen}.',
      );
    }

    final prepared = await _prepareSearchUseCase(
      SearchSelection(
        deviceTypeId: favorite.deviceTypeId,
        brandId: favorite.brandId,
        deviceModelId: favorite.deviceModelId,
        componentId: favorite.componentId,
        supplierIds: favorite.supplierIds,
      ),
    );
    final generatedQuery = _buildQuery(prepared);
    final previewItems = _buildPreviewItems(prepared, generatedQuery);
    final openedItems = <_OpenedFavoriteUrl>[];
    for (final item in previewItems) {
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
          deviceType: prepared.deviceType.name,
          brand: prepared.brand.name,
          deviceModel: prepared.deviceModel.name,
          deviceModelCode: prepared.deviceModel.modelCode,
          component: prepared.component.name,
          generatedQuery: generatedQuery,
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
      await _loadFavoriteState(
        selectedFavoriteId: favorite.id,
        selectedDeviceTypeId: current.selectedDeviceTypeId,
        selectedBrandId: current.selectedBrandId,
        selectedDeviceModelId: current.selectedDeviceModelId,
        selectedComponentId: current.selectedComponentId,
        supplierIds: current.selectedSupplierIds,
        lastResultMessage: current.settings.historyEnabled
            ? 'Favorite launched and saved to history'
            : 'Favorite launched',
      ),
    );
  }

  Future<FavoriteState> _loadFavoriteState({
    required String? selectedFavoriteId,
    required String? selectedDeviceTypeId,
    required String? selectedBrandId,
    required String? selectedDeviceModelId,
    required String? selectedComponentId,
    required Set<String> supplierIds,
    String? lastResultMessage,
  }) async {
    final favorites = _sortFavorites(await _favoriteUseCases.getFavorites());
    final allDeviceTypes = await _catalogUseCases.getDeviceTypes();
    final allBrands = await _catalogUseCases.getBrands();
    final allDeviceModels = await _catalogUseCases.getDeviceModels();
    final allComponents = await _catalogUseCases.getComponents();
    final allSuppliers = await _supplierUseCases.getSuppliers();

    final deviceTypes = _sortByName(
      await _catalogUseCases.getDeviceTypes(activeOnly: true),
      (item) => item.name,
    );
    final brands = _sortByName(
      await _catalogUseCases.getBrands(activeOnly: true),
      (item) => item.name,
    );
    final resolvedDeviceTypeId = _validId(deviceTypes, selectedDeviceTypeId);
    final resolvedBrandId = _validId(brands, selectedBrandId);
    final deviceModels = resolvedDeviceTypeId == null || resolvedBrandId == null
        ? <DeviceModel>[]
        : _sortByName(
            await _catalogUseCases.getDeviceModelsForSelection(
              deviceTypeId: resolvedDeviceTypeId,
              brandId: resolvedBrandId,
              activeOnly: true,
            ),
            (item) => item.name,
          );
    final resolvedDeviceModelId = _validId(deviceModels, selectedDeviceModelId);
    final components = resolvedDeviceTypeId == null
        ? <Component>[]
        : _sortByName(
            await _catalogUseCases.getCompatibleComponents(
              resolvedDeviceTypeId,
              activeOnly: true,
            ),
            (item) => item.name,
          );
    final resolvedComponentId = _validId(components, selectedComponentId);
    final suppliers = resolvedDeviceTypeId == null
        ? <Supplier>[]
        : _sortSuppliers(
            await _supplierUseCases.getCompatibleSuppliers(
              resolvedDeviceTypeId,
              activeOnly: true,
            ),
          );
    final validSupplierIds = suppliers.map((supplier) => supplier.id).toSet();
    final resolvedFavoriteId =
        selectedFavoriteId != null &&
            favorites.any((favorite) => favorite.id == selectedFavoriteId)
        ? selectedFavoriteId
        : (favorites.isEmpty ? null : favorites.first.id);

    return FavoriteState(
      favorites: favorites,
      deviceTypes: deviceTypes,
      brands: brands,
      deviceModels: deviceModels,
      components: components,
      suppliers: suppliers,
      allDeviceTypes: allDeviceTypes,
      allBrands: allBrands,
      allDeviceModels: allDeviceModels,
      allComponents: allComponents,
      allSuppliers: allSuppliers,
      selectedSupplierIds: supplierIds.intersection(validSupplierIds),
      settings: await _appSettingsUseCases.getSettings(),
      selectedFavoriteId: resolvedFavoriteId,
      selectedDeviceTypeId: resolvedDeviceTypeId,
      selectedBrandId: resolvedBrandId,
      selectedDeviceModelId: resolvedDeviceModelId,
      selectedComponentId: resolvedComponentId,
      lastResultMessage: lastResultMessage ?? _currentState?.lastResultMessage,
    );
  }

  FavoriteState _requireCurrentState() {
    final current = _currentState;
    if (current == null) {
      throw const ValidationException('I preferiti non sono ancora pronti.');
    }
    return current;
  }

  FavoriteState? get _currentState => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  List<_OpenedFavoriteUrl> _buildPreviewItems(
    PreparedSearch prepared,
    String generatedQuery,
  ) {
    final values = UrlTemplateValues(
      query: generatedQuery,
      deviceType: prepared.deviceType.name,
      brand: prepared.brand.name,
      model: prepared.deviceModel.name,
      modelCode: prepared.deviceModel.modelCode,
      component: prepared.component.name,
    );
    return [
      for (final supplier in prepared.suppliers)
        _OpenedFavoriteUrl(
          supplierId: supplier.id,
          supplierName: supplier.name,
          url: _urlTemplateGenerator.generate(supplier.urlTemplate, values),
        ),
    ];
  }

  String _buildQuery(PreparedSearch prepared) {
    return [
      prepared.brand.name,
      prepared.deviceModel.name,
      prepared.deviceModel.modelCode,
      prepared.component.name,
    ].whereType<String>().where((part) => part.trim().isNotEmpty).join(' ');
  }

  List<Favorite> _sortFavorites(List<Favorite> favorites) {
    final sorted = [...favorites];
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
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
        'Unsupported favorite item.',
      ),
    };
  }

  String _messageFor(Object error) {
    return error is AppException ? error.message : error.toString();
  }
}

final class _OpenedFavoriteUrl {
  const _OpenedFavoriteUrl({
    required this.supplierId,
    required this.supplierName,
    required this.url,
    this.openResult,
  });

  final String supplierId;
  final String supplierName;
  final Uri url;
  final String? openResult;

  _OpenedFavoriteUrl copyWith({String? openResult}) {
    return _OpenedFavoriteUrl(
      supplierId: supplierId,
      supplierName: supplierName,
      url: url,
      openResult: openResult ?? this.openResult,
    );
  }
}
