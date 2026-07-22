import 'package:repair_parts_finder/core/errors/browser_launch_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/core/services/external_browser_service.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

typedef LaunchExternalUrl =
    Future<bool> Function(Uri url, {url_launcher.LaunchMode mode});

/// Implementazione di [ExternalBrowserService] basata su `url_launcher`.
///
/// Forza l'apertura nel browser/app esterna e valida di nuovo lo schema
/// dell'URL, anche se l'URL e' gia' stato generato dal template system.
final class UrlLauncherExternalBrowserService
    implements ExternalBrowserService {
  UrlLauncherExternalBrowserService({LaunchExternalUrl? launchUrl})
    : _launchUrl = launchUrl ?? url_launcher.launchUrl;

  final LaunchExternalUrl _launchUrl;

  @override
  Future<void> open(Uri url) async {
    _validateUrl(url);

    try {
      final launched = await _launchUrl(
        url,
        mode: url_launcher.LaunchMode.externalApplication,
      );
      if (!launched) {
        throw const BrowserLaunchException(
          'Non e\' stato possibile aprire il browser esterno.',
        );
      }
    } on BrowserLaunchException {
      rethrow;
    } catch (error) {
      throw BrowserLaunchException(
        'Non e\' stato possibile aprire il browser esterno.',
        cause: error,
      );
    }
  }

  void _validateUrl(Uri url) {
    final scheme = url.scheme.toLowerCase();
    if (scheme != 'http' && scheme != 'https') {
      throw const ValidationException(
        'Il browser esterno puo aprire solo URL HTTP o HTTPS.',
      );
    }
    if (url.host.trim().isEmpty) {
      throw const ValidationException('L\'URL da aprire non e\' valido.');
    }
  }
}
