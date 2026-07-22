import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/configuration/app_providers.dart';
import 'package:repair_parts_finder/application/use_cases/app_settings_use_cases.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/presentation/providers/favorite_controller.dart';
import 'package:repair_parts_finder/presentation/providers/history_controller.dart';
import 'package:repair_parts_finder/presentation/providers/search_controller.dart';

final settingsControllerProvider =
    AsyncNotifierProvider<SettingsController, AppSettings>(
      SettingsController.new,
    );

class SettingsController extends AsyncNotifier<AppSettings> {
  late AppSettingsUseCases _useCases;

  @override
  Future<AppSettings> build() async {
    _useCases = await ref.watch(appSettingsUseCasesProvider.future);
    return _useCases.getSettings();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_useCases.getSettings);
  }

  Future<void> updateMaxPagesToOpen(int value) async {
    final current = _requireCurrentSettings();
    await _save(current.copyWith(maxPagesToOpen: value));
  }

  Future<void> updateRequireConfirmation(bool value) async {
    final current = _requireCurrentSettings();
    await _save(current.copyWith(requireConfirmation: value));
  }

  Future<void> updateHistoryEnabled(bool value) async {
    final current = _requireCurrentSettings();
    await _save(current.copyWith(historyEnabled: value));
  }

  Future<void> _save(AppSettings settings) async {
    await _useCases.updateSettings(settings);
    state = AsyncData(settings);
    ref.invalidate(searchControllerProvider);
    ref.invalidate(historyControllerProvider);
    ref.invalidate(favoriteControllerProvider);
  }

  AppSettings _requireCurrentSettings() {
    final current = _currentSettings;
    if (current == null) {
      throw StateError('Le impostazioni non sono ancora pronte.');
    }
    return current;
  }

  AppSettings? get _currentSettings => switch (state) {
    AsyncData(:final value) => value,
    _ => null,
  };
}
