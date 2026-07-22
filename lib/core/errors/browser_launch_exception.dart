import 'package:repair_parts_finder/core/errors/app_exception.dart';

/// Errore restituito quando non e' possibile aprire il browser esterno.
final class BrowserLaunchException extends AppException {
  const BrowserLaunchException(super.message, {super.cause});
}
