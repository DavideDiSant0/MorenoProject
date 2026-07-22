import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/favorite_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/open_external_url_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/prepare_search_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/search_history_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/supplier_use_cases.dart';
import 'package:repair_parts_finder/core/services/date_time_provider.dart';
import 'package:repair_parts_finder/core/services/external_browser_service.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/database_connection.dart';
import 'package:repair_parts_finder/data/repositories/drift_app_settings_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_brand_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_component_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_model_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_type_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_favorite_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_search_history_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_supplier_repository.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/data/services/url_launcher_external_browser_service.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';

final idGeneratorProvider = Provider<IdGenerator>((ref) => UuidIdGenerator());

final dateTimeProvider = Provider<DateTimeProvider>(
  (ref) => const SystemDateTimeProvider(),
);

final externalBrowserServiceProvider = Provider<ExternalBrowserService>(
  (ref) => UrlLauncherExternalBrowserService(),
);

final urlTemplateGeneratorProvider = Provider<UrlTemplateGenerator>(
  (ref) => const UrlTemplateGenerator(),
);

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database = AppDatabase(await openConnection());
  await AppDemoDataSeeder(database).seedIfEmpty();
  ref.onDispose(() => unawaited(database.close()));
  return database;
});

final catalogUseCasesProvider = FutureProvider<CatalogUseCases>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  final catalogDao = database.catalogDao;

  return CatalogUseCases(
    deviceTypeRepository: DriftDeviceTypeRepository(catalogDao),
    brandRepository: DriftBrandRepository(catalogDao),
    deviceModelRepository: DriftDeviceModelRepository(catalogDao),
    componentRepository: DriftComponentRepository(catalogDao),
  );
});

final supplierUseCasesProvider = FutureProvider<SupplierUseCases>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  final urlTemplateGenerator = ref.watch(urlTemplateGeneratorProvider);

  return SupplierUseCases(
    DriftSupplierRepository(database.supplierDao),
    urlTemplateGenerator: urlTemplateGenerator,
  );
});

final appSettingsUseCasesProvider = FutureProvider<AppSettingsUseCases>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return AppSettingsUseCases(
    DriftAppSettingsRepository(database.appSettingsDao),
  );
});

final searchHistoryUseCasesProvider = FutureProvider<SearchHistoryUseCases>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return SearchHistoryUseCases(
    repository: DriftSearchHistoryRepository(database.searchHistoryDao),
    idGenerator: ref.watch(idGeneratorProvider),
    dateTimeProvider: ref.watch(dateTimeProvider),
  );
});

final favoriteUseCasesProvider = FutureProvider<FavoriteUseCases>((ref) async {
  final database = await ref.watch(appDatabaseProvider.future);
  return FavoriteUseCases(
    repository: DriftFavoriteRepository(database.favoriteDao),
    idGenerator: ref.watch(idGeneratorProvider),
    dateTimeProvider: ref.watch(dateTimeProvider),
  );
});

final prepareSearchUseCaseProvider = FutureProvider<PrepareSearchUseCase>((
  ref,
) async {
  final database = await ref.watch(appDatabaseProvider.future);
  final catalogDao = database.catalogDao;
  return PrepareSearchUseCase(
    deviceTypeRepository: DriftDeviceTypeRepository(catalogDao),
    brandRepository: DriftBrandRepository(catalogDao),
    deviceModelRepository: DriftDeviceModelRepository(catalogDao),
    componentRepository: DriftComponentRepository(catalogDao),
    supplierRepository: DriftSupplierRepository(database.supplierDao),
  );
});

final openExternalUrlUseCaseProvider = Provider<OpenExternalUrlUseCase>((ref) {
  return OpenExternalUrlUseCase(ref.watch(externalBrowserServiceProvider));
});
