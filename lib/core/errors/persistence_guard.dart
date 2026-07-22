import 'package:repair_parts_finder/core/errors/app_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_exception.dart';

/// Esegue [action] e converte qualunque eccezione tecnica imprevista in una
/// [PersistenceException]. Le [AppException] gia' tipizzate (es.
/// [NotFoundException] sollevata volontariamente da un repository)
/// attraversano senza essere ri-mappate.
Future<T> guardPersistence<T>(Future<T> Function() action) async {
  try {
    return await action();
  } on AppException {
    rethrow;
  } catch (error) {
    throw PersistenceException(
      'Errore durante l\'accesso ai dati locali.',
      cause: error,
    );
  }
}
