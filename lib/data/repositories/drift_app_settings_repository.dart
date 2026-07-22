import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/app_settings_dao.dart';
import 'package:repair_parts_finder/data/mappers/app_settings_mapper.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/repositories/app_settings_repository.dart';

class DriftAppSettingsRepository implements AppSettingsRepository {
  DriftAppSettingsRepository(this._dao);

  final AppSettingsDao _dao;

  @override
  Future<AppSettings> get() => guardPersistence(() async {
    final row = await _dao.getOrCreate();
    return appSettingsFromRow(row);
  });

  @override
  Future<void> update(AppSettings settings) =>
      guardPersistence(() => _dao.save(appSettingsToCompanion(settings)));
}
