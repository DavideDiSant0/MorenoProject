import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';

final class HistoryState {
  const HistoryState({
    required this.entries,
    required this.settings,
    this.selectedEntryId,
    this.lastResultMessage,
  });

  final List<SearchHistory> entries;
  final AppSettings settings;
  final String? selectedEntryId;
  final String? lastResultMessage;

  SearchHistory? get selectedEntry {
    for (final entry in entries) {
      if (entry.id == selectedEntryId) {
        return entry;
      }
    }
    return null;
  }
}
