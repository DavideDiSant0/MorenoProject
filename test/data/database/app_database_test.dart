import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('la versione dello schema e\' 2', () {
    expect(database.schemaVersion, 2);
  });

  test('tutte le 12 tabelle previste esistono', () async {
    final tableNames = database.allTables.map((t) => t.actualTableName).toSet();

    expect(tableNames, {
      'device_types',
      'brands',
      'device_models',
      'components',
      'device_type_components',
      'suppliers',
      'supplier_device_types',
      'search_history',
      'search_history_suppliers',
      'favorites',
      'favorite_suppliers',
      'app_settings',
    });
  });

  test('le foreign key sono attive dopo l\'apertura', () async {
    final result = await database
        .customSelect('PRAGMA foreign_keys')
        .getSingle();
    expect(result.data['foreign_keys'], 1);
  });

  test('un database appena creato non contiene righe', () async {
    final deviceTypes = await database.select(database.deviceTypes).get();
    expect(deviceTypes, isEmpty);
  });
}
