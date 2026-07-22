import 'package:repair_parts_finder/domain/entities/app_settings.dart';

/// Contratto di persistenza per [AppSettings]. Concetto singleton: [get]
/// non restituisce mai `null`, creando una riga di default al primo accesso.
abstract interface class AppSettingsRepository {
  Future<AppSettings> get();

  Future<void> update(AppSettings settings);
}
