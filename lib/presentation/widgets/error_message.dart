import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Estrae un messaggio comprensibile per l'utente da un errore catturato
/// nella UI, senza mostrare mai un'eccezione tecnica grezza.
String describeError(Object error) {
  if (error is AppException) {
    return error.message;
  }
  if (error is ArgumentError && error.message != null) {
    return error.message.toString();
  }
  return 'Si e\' verificato un errore inatteso.';
}
