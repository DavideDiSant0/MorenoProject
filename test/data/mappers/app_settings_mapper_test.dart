import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/data/mappers/app_settings_mapper.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';

void main() {
  test('converte una riga in entita\' di dominio', () {
    const row = AppSettingsRow(
      id: appSettingsRowId,
      maxPagesToOpen: 3,
      requireConfirmation: false,
      historyEnabled: true,
    );

    final entity = appSettingsFromRow(row);

    expect(entity.maxPagesToOpen, 3);
    expect(entity.requireConfirmation, isFalse);
  });

  test('la companion usa sempre l\'id fisso della riga singleton', () {
    final companion = appSettingsToCompanion(AppSettings());

    expect(companion.id.value, appSettingsRowId);
  });
}
