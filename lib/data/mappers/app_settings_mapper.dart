import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';

AppSettings appSettingsFromRow(AppSettingsRow row) {
  return AppSettings(
    maxPagesToOpen: row.maxPagesToOpen,
    requireConfirmation: row.requireConfirmation,
    historyEnabled: row.historyEnabled,
  );
}

AppSettingsTableCompanion appSettingsToCompanion(AppSettings settings) {
  return AppSettingsTableCompanion.insert(
    id: appSettingsRowId,
    maxPagesToOpen: Value(settings.maxPagesToOpen),
    requireConfirmation: Value(settings.requireConfirmation),
    historyEnabled: Value(settings.historyEnabled),
  );
}
