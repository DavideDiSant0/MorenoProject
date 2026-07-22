/// Fornisce il tempo corrente ai casi d'uso senza renderli dipendenti da
/// `DateTime.now()` nei test.
abstract interface class DateTimeProvider {
  DateTime now();
}

final class SystemDateTimeProvider implements DateTimeProvider {
  const SystemDateTimeProvider();

  @override
  DateTime now() => DateTime.now();
}
