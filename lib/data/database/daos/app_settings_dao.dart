import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/tables/app_settings_table.dart';

part 'app_settings_dao.g.dart';

/// Id fisso della singola riga di impostazioni: la tabella non ha un
/// concetto di identita' utente, esiste sempre e solo una riga.
const appSettingsRowId = 'app_settings';

/// Raggruppa l'accesso ai dati del modulo Impostazioni (`docs/04-modules.md`).
@DriftAccessor(tables: [AppSettingsTable])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<AppSettingsRow> getOrCreate() async {
    final existing = await (select(
      appSettingsTable,
    )..where((t) => t.id.equals(appSettingsRowId))).getSingleOrNull();
    if (existing != null) {
      return existing;
    }
    final defaults = AppSettingsTableCompanion.insert(id: appSettingsRowId);
    await into(appSettingsTable).insert(defaults);
    return (select(
      appSettingsTable,
    )..where((t) => t.id.equals(appSettingsRowId))).getSingle();
  }

  Future<void> save(AppSettingsTableCompanion entry) =>
      into(appSettingsTable).insertOnConflictUpdate(entry);
}
