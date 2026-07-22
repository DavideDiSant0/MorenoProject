import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/repositories/app_settings_repository.dart';

/// Casi d'uso per lettura e aggiornamento delle impostazioni locali.
final class AppSettingsUseCases {
  const AppSettingsUseCases(this._repository);

  final AppSettingsRepository _repository;

  Future<AppSettings> getSettings() => _repository.get();

  Future<void> updateSettings(AppSettings settings) =>
      _repository.update(settings);
}
