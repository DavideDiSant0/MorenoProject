import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Errore restituito quando un input applicativo non rispetta le regole del
/// caso d'uso richiesto.
final class ValidationException extends AppException {
  const ValidationException(super.message, {super.cause});
}
