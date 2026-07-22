import 'package:drift/drift.dart';

/// Nota: la classe non si chiama `AppSettings` per evitare la collisione con
/// l'entita' di dominio omonima. Il nome SQL resta `app_settings`. Una sola
/// riga esiste sempre, con id fisso [appSettingsRowId], applicato dal DAO.
@DataClassName('AppSettingsRow')
class AppSettingsTable extends Table {
  @override
  String get tableName => 'app_settings';

  TextColumn get id => text()();
  IntColumn get maxPagesToOpen => integer().withDefault(const Constant(5))();
  BoolColumn get requireConfirmation =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get historyEnabled =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
