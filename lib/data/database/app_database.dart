import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';
import 'package:repair_parts_finder/data/database/daos/favorite_dao.dart';
import 'package:repair_parts_finder/data/database/daos/search_history_dao.dart';
import 'package:repair_parts_finder/data/database/daos/supplier_dao.dart';
import 'package:repair_parts_finder/data/database/tables/app_settings_table.dart';
import 'package:repair_parts_finder/data/database/tables/brands_table.dart';
import 'package:repair_parts_finder/data/database/tables/components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_models_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_type_components_table.dart';
import 'package:repair_parts_finder/data/database/tables/device_types_table.dart';
import 'package:repair_parts_finder/data/database/tables/favorite_suppliers_table.dart';
import 'package:repair_parts_finder/data/database/tables/favorites_table.dart';
import 'package:repair_parts_finder/data/database/tables/search_history_suppliers_table.dart';
import 'package:repair_parts_finder/data/database/tables/search_history_table.dart';
import 'package:repair_parts_finder/data/database/tables/supplier_device_types_table.dart';
import 'package:repair_parts_finder/data/database/tables/suppliers_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    DeviceTypes,
    Brands,
    DeviceModels,
    Components,
    DeviceTypeComponents,
    Suppliers,
    SupplierDeviceTypes,
    SearchHistoryEntries,
    SearchHistorySuppliers,
    Favorites,
    FavoriteSuppliers,
    AppSettingsTable,
  ],
  daos: [
    CatalogDao,
    SupplierDao,
    SearchHistoryDao,
    FavoriteDao,
    AppSettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(
          appSettingsTable,
          appSettingsTable.demoSeedVersion,
        );
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
