import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/application/use_cases/open_external_url_use_case.dart';
import 'package:repair_parts_finder/core/services/external_browser_service.dart';

void main() {
  test('delega apertura URL al browser service astratto', () async {
    final browserService = FakeExternalBrowserService();
    final useCase = OpenExternalUrlUseCase(browserService);
    final uri = Uri.parse('https://supplier.example/search?q=screen');

    await useCase(uri);

    expect(browserService.openedUrls, [uri]);
  });
}

final class FakeExternalBrowserService implements ExternalBrowserService {
  final List<Uri> openedUrls = [];

  @override
  Future<void> open(Uri url) async {
    openedUrls.add(url);
  }
}
