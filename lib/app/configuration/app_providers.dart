import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/use_cases/catalog_use_cases.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/database_connection.dart';
import 'package:repair_parts_finder/data/repositories/drift_brand_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_component_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_model_repository.dart';
import 'package:repair_parts_finder/data/repositories/drift_device_type_repository.dart';

final idGeneratorProvider = Provider<IdGenerator>((ref) => UuidIdGenerator());

final appDatabaseProvider = FutureProvider<AppDatabase>((ref) async {
  final database = AppDatabase(await openConnection());
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
