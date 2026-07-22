import 'package:repair_parts_finder/core/services/external_browser_service.dart';

/// Caso d'uso per aprire una pagina gia' validata nel browser esterno.
final class OpenExternalUrlUseCase {
  const OpenExternalUrlUseCase(this._browserService);

  final ExternalBrowserService _browserService;

  Future<void> call(Uri url) => _browserService.open(url);
}
