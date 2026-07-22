/// Contratto per aprire URL nel browser esterno.
///
/// La UI deve dipendere da questo contratto, mai direttamente da
/// `url_launcher`.
abstract interface class ExternalBrowserService {
  Future<void> open(Uri url);
}
