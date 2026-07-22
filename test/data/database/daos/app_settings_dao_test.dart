import 'package:drift/drift.dart' hide isNotNull, isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';

void main() {
  late AppDatabase database;
  late AppSettingsDao dao;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    dao = database.appSettingsDao;
  });

  tearDown(() async {
    await database.close();
  });

  test('getOrCreate crea la riga di default al primo accesso', () async {
    final row = await dao.getOrCreate();

    expect(row.id, appSettingsRowId);
    expect(row.maxPagesToOpen, 5);
    expect(row.requireConfirmation, isTrue);
    expect(row.historyEnabled, isTrue);
  });

  test(
    'getOrCreate restituisce la stessa riga alla seconda chiamata',
    () async {
      final first = await dao.getOrCreate();
      final second = await dao.getOrCreate();

      expect(second.id, first.id);
      final allRows = await database.select(database.appSettingsTable).get();
      expect(allRows, hasLength(1));
    },
  );

  test('save aggiorna la riga esistente invece di duplicarla', () async {
    await dao.getOrCreate();

    await dao.save(
      AppSettingsTableCompanion.insert(
        id: appSettingsRowId,
        maxPagesToOpen: const Value(10),
        requireConfirmation: const Value(false),
      ),
    );

    final row = await dao.getOrCreate();
    expect(row.maxPagesToOpen, 10);
    expect(row.requireConfirmation, isFalse);

    final allRows = await database.select(database.appSettingsTable).get();
    expect(allRows, hasLength(1));
  });
}
