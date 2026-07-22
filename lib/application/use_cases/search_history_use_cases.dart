import 'package:repair_parts_finder/application/dto/record_search_history_command.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/core/services/date_time_provider.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';
import 'package:repair_parts_finder/domain/repositories/search_history_repository.dart';

/// Casi d'uso del modulo Cronologia.
final class SearchHistoryUseCases {
  const SearchHistoryUseCases({
    required SearchHistoryRepository repository,
    required IdGenerator idGenerator,
    required DateTimeProvider dateTimeProvider,
  }) : _repository = repository,
       _idGenerator = idGenerator,
       _dateTimeProvider = dateTimeProvider;

  final SearchHistoryRepository _repository;
  final IdGenerator _idGenerator;
  final DateTimeProvider _dateTimeProvider;

  Future<List<SearchHistory>> getHistory() => _repository.getAll();

  Future<SearchHistory?> getHistoryEntry(String id) => _repository.getById(id);

  Future<SearchHistory> recordSearch(RecordSearchHistoryCommand command) async {
    if (command.suppliers.isEmpty) {
      throw const ValidationException(
        'La cronologia richiede almeno un fornitore.',
      );
    }

    final historyId = _idGenerator.nextId();
    final entry = SearchHistory(
      id: historyId,
      searchedAt: command.searchedAt ?? _dateTimeProvider.now(),
      deviceType: command.deviceType,
      brand: command.brand,
      deviceModel: command.deviceModel,
      deviceModelCode: command.deviceModelCode,
      component: command.component,
      generatedQuery: command.generatedQuery,
      suppliers: [
        for (final supplier in command.suppliers)
          SearchHistorySupplier(
            id: _idGenerator.nextId(),
            searchHistoryId: historyId,
            supplierId: supplier.supplierId,
            supplierName: supplier.supplierName,
            generatedUrl: supplier.generatedUrl,
            openResult: supplier.openResult,
          ),
      ],
    );

    await _repository.create(entry);
    return entry;
  }

  Future<void> deleteHistoryEntry(String id) => _repository.delete(id);

  Future<void> clearHistory() => _repository.deleteAll();
}
