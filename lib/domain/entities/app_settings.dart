/// Impostazioni locali dell'applicazione. Concetto singleton: non ha un id
/// dal punto di vista del dominio. Non deve mai contenere dati sensibili.
final class AppSettings {
  AppSettings({
    this.maxPagesToOpen = 5,
    this.requireConfirmation = true,
    this.historyEnabled = true,
  }) {
    if (maxPagesToOpen <= 0) {
      throw ArgumentError.value(
        maxPagesToOpen,
        'maxPagesToOpen',
        'Deve essere maggiore di zero.',
      );
    }
  }

  final int maxPagesToOpen;
  final bool requireConfirmation;
  final bool historyEnabled;

  AppSettings copyWith({
    int? maxPagesToOpen,
    bool? requireConfirmation,
    bool? historyEnabled,
  }) {
    return AppSettings(
      maxPagesToOpen: maxPagesToOpen ?? this.maxPagesToOpen,
      requireConfirmation: requireConfirmation ?? this.requireConfirmation,
      historyEnabled: historyEnabled ?? this.historyEnabled,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettings &&
          other.maxPagesToOpen == maxPagesToOpen &&
          other.requireConfirmation == requireConfirmation &&
          other.historyEnabled == historyEnabled);

  @override
  int get hashCode =>
      Object.hash(maxPagesToOpen, requireConfirmation, historyEnabled);

  @override
  String toString() =>
      'AppSettings(maxPagesToOpen: $maxPagesToOpen, '
      'requireConfirmation: $requireConfirmation, '
      'historyEnabled: $historyEnabled)';
}
