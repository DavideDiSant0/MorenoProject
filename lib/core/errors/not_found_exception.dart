import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Errore restituito quando un'entita' richiesta tramite id non esiste.
final class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.cause});
}
