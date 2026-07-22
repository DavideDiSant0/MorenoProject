import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Estrae un messaggio comprensibile per l'utente da un errore catturato
/// nella UI, senza mostrare mai un'eccezione tecnica grezza.
String describeError(Object error) {
  return error is AppException ? error.message : error.toString();
}
