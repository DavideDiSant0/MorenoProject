import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/repositories/drift_app_settings_repository.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';

void main() {
  late AppDatabase database;
  late DriftAppSettingsRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftAppSettingsRepository(database.appSettingsDao);
  });

  tearDown(() async {
    await database.close();
  });

  test('get restituisce le impostazioni di default al primo accesso', () async {
    final settings = await repository.get();

    expect(settings.maxPagesToOpen, 5);
    expect(settings.requireConfirmation, isTrue);
  });

  test('update sostituisce le impostazioni esistenti', () async {
    await repository.get();

    await repository.update(
      AppSettings(maxPagesToOpen: 8, requireConfirmation: false),
    );

    final settings = await repository.get();
    expect(settings.maxPagesToOpen, 8);
    expect(settings.requireConfirmation, isFalse);
  });
}
