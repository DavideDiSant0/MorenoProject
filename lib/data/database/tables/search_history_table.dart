import 'package:drift/drift.dart';

/// Nota: la classe non si chiama `SearchHistory` per evitare la collisione
/// con l'entita' di dominio omonima quando entrambe sono importate nello
/// stesso file (mapper, repository). Il nome SQL resta `search_history`.
@DataClassName('SearchHistoryRow')
class SearchHistoryEntries extends Table {
  @override
  String get tableName => 'search_history';

  TextColumn get id => text()();
  DateTimeColumn get searchedAt => dateTime()();
  TextColumn get deviceType => text()();
  TextColumn get brand => text()();
  TextColumn get deviceModel => text()();
  TextColumn get deviceModelCode => text().nullable()();
  TextColumn get component => text()();
  TextColumn get generatedQuery => text()();

  @override
  Set<Column> get primaryKey => {id};
}
