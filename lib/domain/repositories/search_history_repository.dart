import 'package:repair_parts_finder/domain/entities/search_history.dart';

/// Contratto di persistenza per [SearchHistory]. La cronologia e' di sola
/// aggiunta e cancellazione: non esiste un'operazione di modifica.
abstract interface class SearchHistoryRepository {
  Future<List<SearchHistory>> getAll();

  Future<SearchHistory?> getById(String id);

  Future<void> create(SearchHistory entry);

  Future<void> delete(String id);

  Future<void> deleteAll();
}
