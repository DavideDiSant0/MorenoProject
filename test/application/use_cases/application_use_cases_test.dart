import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/application/dto/create_favorite_command.dart';
import 'package:repair_parts_finder/application/dto/record_search_history_command.dart';
import 'package:repair_parts_finder/application/dto/search_selection.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/favorite_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/prepare_search_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/search_history_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/supplier_use_cases.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/core/services/date_time_provider.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/repositories/app_settings_repository.dart';
import 'package:repair_parts_finder/domain/repositories/brand_repository.dart';
import 'package:repair_parts_finder/domain/repositories/component_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_model_repository.dart';
import 'package:repair_parts_finder/domain/repositories/device_type_repository.dart';
import 'package:repair_parts_finder/domain/repositories/favorite_repository.dart';
import 'package:repair_parts_finder/domain/repositories/search_history_repository.dart';
import 'package:repair_parts_finder/domain/repositories/supplier_repository.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

void main() {
  group('CatalogUseCases', () {
    test('filtra gli elementi attivi', () async {
      final deviceTypes = FakeDeviceTypeRepository([
        DeviceType(id: 'phone', name: 'Phone'),
        DeviceType(id: 'tablet', name: 'Tablet', isActive: false),
      ]);
      final useCases = buildCatalogUseCases(deviceTypeRepository: deviceTypes);

      final result = await useCases.getDeviceTypes(activeOnly: true);

      expect(result, [DeviceType(id: 'phone', name: 'Phone')]);
    });
  });

  group('SupplierUseCases', () {
    test('filtra i fornitori compatibili e attivi', () async {
      final repository = FakeSupplierRepository([
        buildSupplier('s1'),
        buildSupplier('s2', isActive: false),
      ])..compatibleByDeviceType['phone'] = {'s1', 's2'};
      final useCases = SupplierUseCases(repository);

      final result = await useCases.getCompatibleSuppliers(
        'phone',
        activeOnly: true,
      );

      expect(result, [buildSupplier('s1')]);
    });

    test('rifiuta la creazione con template URL non sicuro', () async {
      final repository = FakeSupplierRepository(const []);
      final useCases = SupplierUseCases(repository);

      expect(
        () => useCases.createSupplier(
          Supplier(
            id: 'bad',
            name: 'Bad Supplier',
            baseUrl: 'https://supplier.example',
            urlTemplate: 'javascript:alert({query})',
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
      expect(repository.items, isEmpty);
    });

    test('genera un URL di prova dal template del fornitore', () {
      final useCases = SupplierUseCases(FakeSupplierRepository(const []));

      final uri = useCases.testTemplate(
        'https://supplier.example/search?q={query}&brand={brand}',
        const UrlTemplateValues(query: 'iPhone 12 screen', brand: 'Apple'),
      );

      expect(
        uri.toString(),
        'https://supplier.example/search?q=iPhone%2012%20screen&brand=Apple',
      );
    });
  });

  group('PrepareSearchUseCase', () {
    test(
      'restituisce una ricerca preparata quando la selezione e valida',
      () async {
        final fixture = SearchFixture();

        final prepared = await fixture.useCase(
          SearchSelection(
            deviceTypeId: 'phone',
            brandId: 'apple',
            deviceModelId: 'iphone12',
            componentId: 'screen',
            supplierIds: const ['parts'],
          ),
        );

        expect(prepared.deviceType.id, 'phone');
        expect(prepared.brand.id, 'apple');
        expect(prepared.deviceModel.id, 'iphone12');
        expect(prepared.component.id, 'screen');
        expect(prepared.suppliers.map((supplier) => supplier.id), ['parts']);
      },
    );

    test('rifiuta una ricerca senza fornitori', () async {
      final fixture = SearchFixture();

      expect(
        () => fixture.useCase(
          SearchSelection(
            deviceTypeId: 'phone',
            brandId: 'apple',
            deviceModelId: 'iphone12',
            componentId: 'screen',
            supplierIds: const [],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta un componente non compatibile', () async {
      final fixture = SearchFixture()
        ..deviceTypes.compatibleComponentsByDeviceType.clear();

      expect(
        () => fixture.useCase(
          SearchSelection(
            deviceTypeId: 'phone',
            brandId: 'apple',
            deviceModelId: 'iphone12',
            componentId: 'screen',
            supplierIds: const ['parts'],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta un fornitore disattivato', () async {
      final fixture = SearchFixture()
        ..suppliers.items['parts'] = buildSupplier('parts', isActive: false);

      expect(
        () => fixture.useCase(
          SearchSelection(
            deviceTypeId: 'phone',
            brandId: 'apple',
            deviceModelId: 'iphone12',
            componentId: 'screen',
            supplierIds: const ['parts'],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('FavoriteUseCases', () {
    test('crea un preferito con id e data controllati', () async {
      final repository = FakeFavoriteRepository();
      final useCases = FavoriteUseCases(
        repository: repository,
        idGenerator: SequenceIdGenerator(['fav-1']),
        dateTimeProvider: FixedDateTimeProvider(DateTime(2026, 7, 22)),
      );

      final favorite = await useCases.createFavorite(
        CreateFavoriteCommand(
          name: 'iPhone screen',
          deviceTypeId: 'phone',
          brandId: 'apple',
          deviceModelId: 'iphone12',
          componentId: 'screen',
          supplierIds: const ['parts'],
        ),
      );

      expect(favorite.id, 'fav-1');
      expect(favorite.createdAt, DateTime(2026, 7, 22));
      expect(repository.items['fav-1'], favorite);
    });
  });

  group('SearchHistoryUseCases', () {
    test('registra una ricerca generando id per voce e fornitori', () async {
      final repository = FakeSearchHistoryRepository();
      final useCases = SearchHistoryUseCases(
        repository: repository,
        idGenerator: SequenceIdGenerator(['history-1', 'supplier-row-1']),
        dateTimeProvider: FixedDateTimeProvider(DateTime(2026, 7, 22, 10)),
      );

      final entry = await useCases.recordSearch(
        RecordSearchHistoryCommand(
          deviceType: 'Phone',
          brand: 'Apple',
          deviceModel: 'iPhone 12',
          deviceModelCode: 'A2403',
          component: 'Screen',
          generatedQuery: 'Apple iPhone 12 A2403 Screen',
          suppliers: [
            RecordSearchHistorySupplierCommand(
              supplierId: 'parts',
              supplierName: 'Parts',
              generatedUrl: 'https://example.test/search?q=screen',
            ),
          ],
        ),
      );

      expect(entry.id, 'history-1');
      expect(entry.suppliers.single.id, 'supplier-row-1');
      expect(repository.items['history-1'], entry);
    });

    test('rifiuta la registrazione senza fornitori', () async {
      final useCases = SearchHistoryUseCases(
        repository: FakeSearchHistoryRepository(),
        idGenerator: SequenceIdGenerator(['history-1']),
        dateTimeProvider: FixedDateTimeProvider(DateTime(2026, 7, 22)),
      );

      expect(
        () => useCases.recordSearch(
          RecordSearchHistoryCommand(
            deviceType: 'Phone',
            brand: 'Apple',
            deviceModel: 'iPhone 12',
            component: 'Screen',
            generatedQuery: 'Apple iPhone 12 Screen',
            suppliers: const [],
          ),
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('AppSettingsUseCases', () {
    test('aggiorna e legge le impostazioni', () async {
      final repository = FakeAppSettingsRepository();
      final useCases = AppSettingsUseCases(repository);

      await useCases.updateSettings(AppSettings(maxPagesToOpen: 3));

      expect((await useCases.getSettings()).maxPagesToOpen, 3);
    });
  });
}

CatalogUseCases buildCatalogUseCases({
  FakeDeviceTypeRepository? deviceTypeRepository,
  FakeBrandRepository? brandRepository,
  FakeDeviceModelRepository? deviceModelRepository,
  FakeComponentRepository? componentRepository,
}) {
  return CatalogUseCases(
    deviceTypeRepository:
        deviceTypeRepository ?? FakeDeviceTypeRepository(const []),
    brandRepository: brandRepository ?? FakeBrandRepository(const []),
    deviceModelRepository:
        deviceModelRepository ?? FakeDeviceModelRepository(const []),
    componentRepository:
        componentRepository ?? FakeComponentRepository(const []),
  );
}

Supplier buildSupplier(String id, {bool isActive = true}) {
  return Supplier(
    id: id,
    name: 'Supplier $id',
    baseUrl: 'https://$id.example.test',
    urlTemplate: 'https://$id.example.test/search?q={query}',
    isActive: isActive,
  );
}

final class SearchFixture {
  SearchFixture()
    : deviceTypes = FakeDeviceTypeRepository([
        DeviceType(id: 'phone', name: 'Phone'),
      ]),
      brands = FakeBrandRepository([Brand(id: 'apple', name: 'Apple')]),
      models = FakeDeviceModelRepository([
        DeviceModel(
          id: 'iphone12',
          name: 'iPhone 12',
          deviceTypeId: 'phone',
          brandId: 'apple',
        ),
      ]),
      components = FakeComponentRepository([
        Component(id: 'screen', name: 'Screen'),
      ]),
      suppliers = FakeSupplierRepository([buildSupplier('parts')]) {
    deviceTypes.componentRepository = components;
    deviceTypes.compatibleComponentsByDeviceType['phone'] = {'screen'};
    suppliers.compatibleByDeviceType['phone'] = {'parts'};
    useCase = PrepareSearchUseCase(
      deviceTypeRepository: deviceTypes,
      brandRepository: brands,
      deviceModelRepository: models,
      componentRepository: components,
      supplierRepository: suppliers,
    );
  }

  final FakeDeviceTypeRepository deviceTypes;
  final FakeBrandRepository brands;
  final FakeDeviceModelRepository models;
  final FakeComponentRepository components;
  final FakeSupplierRepository suppliers;
  late final PrepareSearchUseCase useCase;
}

final class SequenceIdGenerator implements IdGenerator {
  SequenceIdGenerator(this._ids);

  final List<String> _ids;
  int _index = 0;

  @override
  String nextId() => _ids[_index++];
}

final class FixedDateTimeProvider implements DateTimeProvider {
  const FixedDateTimeProvider(this.value);

  final DateTime value;

  @override
  DateTime now() => value;
}

final class FakeAppSettingsRepository implements AppSettingsRepository {
  AppSettings _settings = AppSettings();

  @override
  Future<AppSettings> get() async => _settings;

  @override
  Future<void> update(AppSettings settings) async {
    _settings = settings;
  }
}

final class FakeDeviceTypeRepository implements DeviceTypeRepository {
  FakeDeviceTypeRepository(List<DeviceType> initialItems)
    : items = {for (final item in initialItems) item.id: item};

  final Map<String, DeviceType> items;
  final Map<String, Set<String>> compatibleComponentsByDeviceType = {};
  late FakeComponentRepository componentRepository;

  @override
  Future<void> addCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) async {
    compatibleComponentsByDeviceType
        .putIfAbsent(deviceTypeId, () => <String>{})
        .add(componentId);
  }

  @override
  Future<void> create(DeviceType deviceType) async {
    items[deviceType.id] = deviceType;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<DeviceType>> getAll() async => items.values.toList();

  @override
  Future<DeviceType?> getById(String id) async => items[id];

  @override
  Future<List<Component>> getCompatibleComponents(String deviceTypeId) async {
    final componentIds =
        compatibleComponentsByDeviceType[deviceTypeId] ?? const <String>{};
    return [
      for (final id in componentIds)
        if (componentRepository.items[id] != null)
          componentRepository.items[id]!,
    ];
  }

  @override
  Future<void> removeCompatibleComponent(
    String deviceTypeId,
    String componentId,
  ) async {
    compatibleComponentsByDeviceType[deviceTypeId]?.remove(componentId);
  }

  @override
  Future<void> update(DeviceType deviceType) async {
    items[deviceType.id] = deviceType;
  }
}

final class FakeBrandRepository implements BrandRepository {
  FakeBrandRepository(List<Brand> initialItems)
    : items = {for (final item in initialItems) item.id: item};

  final Map<String, Brand> items;

  @override
  Future<void> create(Brand brand) async {
    items[brand.id] = brand;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<Brand>> getAll() async => items.values.toList();

  @override
  Future<Brand?> getById(String id) async => items[id];

  @override
  Future<void> update(Brand brand) async {
    items[brand.id] = brand;
  }
}

final class FakeComponentRepository implements ComponentRepository {
  FakeComponentRepository(List<Component> initialItems)
    : items = {for (final item in initialItems) item.id: item};

  final Map<String, Component> items;

  @override
  Future<void> create(Component component) async {
    items[component.id] = component;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<Component>> getAll() async => items.values.toList();

  @override
  Future<Component?> getById(String id) async => items[id];

  @override
  Future<void> update(Component component) async {
    items[component.id] = component;
  }
}

final class FakeDeviceModelRepository implements DeviceModelRepository {
  FakeDeviceModelRepository(List<DeviceModel> initialItems)
    : items = {for (final item in initialItems) item.id: item};

  final Map<String, DeviceModel> items;

  @override
  Future<void> create(DeviceModel deviceModel) async {
    items[deviceModel.id] = deviceModel;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<DeviceModel>> getAll() async => items.values.toList();

  @override
  Future<DeviceModel?> getById(String id) async => items[id];

  @override
  Future<List<DeviceModel>> getByDeviceTypeAndBrand(
    String deviceTypeId,
    String brandId,
  ) async {
    return items.values
        .where(
          (model) =>
              model.deviceTypeId == deviceTypeId && model.brandId == brandId,
        )
        .toList();
  }

  @override
  Future<void> update(DeviceModel deviceModel) async {
    items[deviceModel.id] = deviceModel;
  }
}

final class FakeSupplierRepository implements SupplierRepository {
  FakeSupplierRepository(List<Supplier> initialItems)
    : items = {for (final item in initialItems) item.id: item};

  final Map<String, Supplier> items;
  final Map<String, Set<String>> compatibleByDeviceType = {};
  final Map<String, Set<String>> compatibleDeviceTypesBySupplier = {};

  @override
  Future<void> addCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) async {
    compatibleByDeviceType
        .putIfAbsent(deviceTypeId, () => <String>{})
        .add(supplierId);
    compatibleDeviceTypesBySupplier
        .putIfAbsent(supplierId, () => <String>{})
        .add(deviceTypeId);
  }

  @override
  Future<void> create(Supplier supplier) async {
    items[supplier.id] = supplier;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<Supplier>> getAll() async => items.values.toList();

  @override
  Future<Supplier?> getById(String id) async => items[id];

  @override
  Future<List<DeviceType>> getCompatibleDeviceTypes(String supplierId) async {
    final deviceTypeIds =
        compatibleDeviceTypesBySupplier[supplierId] ?? const <String>{};
    return [for (final id in deviceTypeIds) DeviceType(id: id, name: id)];
  }

  @override
  Future<List<Supplier>> getCompatibleWithDeviceType(
    String deviceTypeId,
  ) async {
    final supplierIds =
        compatibleByDeviceType[deviceTypeId] ?? const <String>{};
    return [
      for (final id in supplierIds)
        if (items[id] != null) items[id]!,
    ];
  }

  @override
  Future<void> removeCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) async {
    compatibleByDeviceType[deviceTypeId]?.remove(supplierId);
    compatibleDeviceTypesBySupplier[supplierId]?.remove(deviceTypeId);
  }

  @override
  Future<void> update(Supplier supplier) async {
    items[supplier.id] = supplier;
  }
}

final class FakeFavoriteRepository implements FavoriteRepository {
  final Map<String, Favorite> items = {};

  @override
  Future<void> create(Favorite favorite) async {
    items[favorite.id] = favorite;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<List<Favorite>> getAll() async => items.values.toList();

  @override
  Future<Favorite?> getById(String id) async => items[id];

  @override
  Future<void> update(Favorite favorite) async {
    items[favorite.id] = favorite;
  }
}

final class FakeSearchHistoryRepository implements SearchHistoryRepository {
  final Map<String, SearchHistory> items = {};

  @override
  Future<void> create(SearchHistory entry) async {
    items[entry.id] = entry;
  }

  @override
  Future<void> delete(String id) async {
    items.remove(id);
  }

  @override
  Future<void> deleteAll() async {
    items.clear();
  }

  @override
  Future<List<SearchHistory>> getAll() async => items.values.toList();

  @override
  Future<SearchHistory?> getById(String id) async => items[id];
}
