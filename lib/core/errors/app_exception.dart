/// Errore applicativo di base. Ogni eccezione tecnica che attraversa un
/// confine di livello deve essere convertita in una sottoclasse di questa
/// prima di raggiungere i livelli superiori (vedi `docs/09-error-handling.md`).
abstract base class AppException implements Exception {
  const AppException(this.message, {this.cause});

  /// Messaggio comprensibile per l'utente finale, in italiano.
  final String message;

  /// Eccezione tecnica originale, utile solo per diagnosi locale.
  final Object? cause;

  @override
  String toString() => message;
}
