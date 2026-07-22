import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';

void main() {
  test('applica i valori di default', () {
    final settings = AppSettings();

    expect(settings.maxPagesToOpen, 5);
    expect(settings.requireConfirmation, isTrue);
    expect(settings.historyEnabled, isTrue);
  });

  test('rifiuta un maxPagesToOpen non positivo', () {
    expect(() => AppSettings(maxPagesToOpen: 0), throwsArgumentError);
    expect(() => AppSettings(maxPagesToOpen: -1), throwsArgumentError);
  });

  test('copyWith aggiorna solo il campo indicato', () {
    final original = AppSettings();
    final updated = original.copyWith(historyEnabled: false);

    expect(updated.historyEnabled, isFalse);
    expect(updated.maxPagesToOpen, original.maxPagesToOpen);
    expect(updated.requireConfirmation, original.requireConfirmation);
  });
}
