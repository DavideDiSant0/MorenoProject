import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/state/history_state.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/application/use_cases/open_external_url_use_case.dart';
import 'package:repair_parts_finder/application/use_cases/search_history_use_cases.dart';
import 'package:repair_parts_finder/core/errors/app_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';

final historyControllerProvider =
    AsyncNotifierProvider<HistoryController, HistoryState>(
      HistoryController.new,
    );

class HistoryController extends AsyncNotifier<HistoryState> {
  late SearchHistoryUseCases _searchHistoryUseCases;
  late AppSettingsUseCases _appSettingsUseCases;
  late OpenExternalUrlUseCase _openExternalUrlUseCase;
  bool _isRepeatingEntry = false;

  @override
  Future<HistoryState> build() async {
    _searchHistoryUseCases = await ref.watch(
      searchHistoryUseCasesProvider.future,
    );
    _appSettingsUseCases = await ref.watch(appSettingsUseCasesProvider.future);
    _openExternalUrlUseCase = ref.watch(openExternalUrlUseCaseProvider);
    return _loadHistoryState();
  }

  Future<void> refresh() async {
    final current = _currentState;
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => _loadHistoryState(selectedEntryId: current?.selectedEntryId),
    );
  }

  Future<void> selectEntry(String? entryId) async {
    state = await AsyncValue.guard(
      () => _loadHistoryState(selectedEntryId: entryId),
    );
  }

  Future<void> deleteEntry(String entryId) async {
    await _searchHistoryUseCases.deleteHistoryEntry(entryId);
    state = AsyncData(await _loadHistoryState());
  }

  Future<void> clearHistory() async {
    await _searchHistoryUseCases.clearHistory();
    state = AsyncData(
      await _loadHistoryState(lastResultMessage: 'Cronologia svuotata'),
    );
  }

  Future<void> repeatSelectedEntry() async {
    if (_isRepeatingEntry) {
      throw const ValidationException(
        'La ripetizione della ricerca e\' gia in corso.',
      );
    }
    final current = _requireCurrentState();
    final entry = current.selectedEntry;
    if (entry == null) {
      throw const ValidationException('Selezionare una ricerca da ripetere.');
    }
    if (entry.suppliers.length > current.settings.maxPagesToOpen) {
      throw ValidationException(
        'La ricerca salvata contiene ${entry.suppliers.length} URL: '
        'il limite attuale e\' ${current.settings.maxPagesToOpen}.',
      );
    }

    _isRepeatingEntry = true;
    try {
      var openedCount = 0;
      final errors = <String>[];
      for (final supplier in entry.suppliers) {
        try {
          await _openExternalUrlUseCase(Uri.parse(supplier.generatedUrl));
          openedCount++;
        } catch (error) {
          errors.add('${supplier.supplierName}: ${_messageFor(error)}');
        }
      }

      final message = errors.isEmpty
          ? 'Ricerca ripetuta: aperti $openedCount URL'
          : 'Aperti $openedCount URL, ${errors.length} non riusciti';
      state = AsyncData(
        await _loadHistoryState(
          selectedEntryId: entry.id,
          lastResultMessage: message,
        ),
      );
    } finally {
      _isRepeatingEntry = false;
    }
  }

  Future<HistoryState> _loadHistoryState({
    String? selectedEntryId,
    String? lastResultMessage,
  }) async {
    final entries = await _searchHistoryUseCases.getHistory();
    final requestedSelectedId =
        selectedEntryId ?? _currentState?.selectedEntryId;
    final resolvedSelectedId =
        requestedSelectedId != null &&
            entries.any((entry) => entry.id == requestedSelectedId)
        ? requestedSelectedId
        : (entries.isEmpty ? null : entries.first.id);

    return HistoryState(
      entries: entries,
      settings: await _appSettingsUseCases.getSettings(),
      selectedEntryId: resolvedSelectedId,
      lastResultMessage: lastResultMessage ?? _currentState?.lastResultMessage,
    );
  }

  HistoryState _requireCurrentState() {
    final current = _currentState;
    if (current == null) {
      throw const ValidationException('La cronologia non e\' ancora pronta.');
    }
    return current;
  }

  HistoryState? get _currentState => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };

  String _messageFor(Object error) {
    return error is AppException
        ? error.message
        : 'Errore inatteso durante l\'apertura.';
  }
}
