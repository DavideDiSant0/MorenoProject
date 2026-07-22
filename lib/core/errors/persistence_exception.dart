import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Errore restituito quando un'operazione sul database locale fallisce per
/// una causa tecnica (es. eccezione SQLite).
final class PersistenceException extends AppException {
  const PersistenceException(super.message, {super.cause});
}
