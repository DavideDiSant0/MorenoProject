import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/data/database/database_connection.dart';
import 'package:repair_parts_finder/data/mappers/device_type_mapper.dart';
import 'package:repair_parts_finder/data/seed/app_demo_data_seeder.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  test('apre un database su file reale e fa un round-trip', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'repair_parts_finder_test_',
    );
    addTearDown(() => tempDir.delete(recursive: true));

    final database = AppDatabase(openConnectionAt(tempDir.path));
    addTearDown(database.close);

    final deviceType = DeviceType(id: '1', name: 'Smartphone');
    await database
        .into(database.deviceTypes)
        .insert(deviceTypeToCompanion(deviceType));

    final rows = await database.select(database.deviceTypes).get();

    expect(rows, hasLength(1));
    expect(rows.single.name, 'Smartphone');
    expect(
      Directory(tempDir.path).listSync().any(
        (entry) => entry.path.endsWith('repair_parts_finder.sqlite'),
      ),
      isTrue,
    );
  });

  test(
    'riapertura su disco conserva dati e impostazioni senza riseed',
    () async {
      final tempDir = await Directory.systemTemp.createTemp(
        'repair_parts_finder_reopen_test_',
      );
      addTearDown(() => tempDir.delete(recursive: true));

      final firstDatabase = AppDatabase(openConnectionAt(tempDir.path));
      expect(await AppDemoDataSeeder(firstDatabase).seedIfEmpty(), isTrue);
      await firstDatabase.appSettingsDao.save(
        AppSettingsTableCompanion.insert(
          id: appSettingsRowId,
          maxPagesToOpen: const Value(9),
          requireConfirmation: const Value(false),
          historyEnabled: const Value(false),
          demoSeedVersion: const Value(currentDemoSeedVersion),
        ),
      );
      await firstDatabase.close();

      final reopenedDatabase = AppDatabase(openConnectionAt(tempDir.path));
      addTearDown(reopenedDatabase.close);

      expect(await AppDemoDataSeeder(reopenedDatabase).seedIfEmpty(), isFalse);
      expect(
        await reopenedDatabase.select(reopenedDatabase.deviceTypes).get(),
        hasLength(3),
      );
      expect(
        await reopenedDatabase.select(reopenedDatabase.suppliers).get(),
        hasLength(3),
      );
      final settings = await reopenedDatabase.appSettingsDao.getOrCreate();
      expect(settings.maxPagesToOpen, 9);
      expect(settings.requireConfirmation, isFalse);
      expect(settings.historyEnabled, isFalse);
    },
  );
}
