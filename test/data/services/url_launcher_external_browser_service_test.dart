import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/browser_launch_exception.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/data/services/url_launcher_external_browser_service.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

void main() {
  test('apre URL HTTP nel browser esterno', () async {
    final launcher = FakeLauncher();
    final service = UrlLauncherExternalBrowserService(
      launchUrl: launcher.launch,
    );
    final uri = Uri.parse('https://supplier.example/search?q=screen');

    await service.open(uri);

    expect(launcher.openedUrls, [uri]);
    expect(launcher.modes, [url_launcher.LaunchMode.externalApplication]);
  });

  test('accetta anche URL HTTP', () async {
    final launcher = FakeLauncher();
    final service = UrlLauncherExternalBrowserService(
      launchUrl: launcher.launch,
    );
    final uri = Uri.parse('http://supplier.example/search?q=screen');

    await service.open(uri);

    expect(launcher.openedUrls, [uri]);
  });

  test('blocca schemi non consentiti prima di chiamare url_launcher', () async {
    final launcher = FakeLauncher();
    final service = UrlLauncherExternalBrowserService(
      launchUrl: launcher.launch,
    );

    expect(
      () => service.open(Uri.parse('file:///tmp/result.html')),
      throwsA(isA<ValidationException>()),
    );
    expect(
      () => service.open(Uri.parse('javascript:alert(1)')),
      throwsA(isA<ValidationException>()),
    );
    expect(launcher.openedUrls, isEmpty);
  });

  test('rifiuta URL senza host', () async {
    final service = UrlLauncherExternalBrowserService(
      launchUrl: FakeLauncher().launch,
    );

    expect(
      () => service.open(Uri.parse('https:///search?q=screen')),
      throwsA(isA<ValidationException>()),
    );
  });

  test('converte un esito false in BrowserLaunchException', () async {
    final service = UrlLauncherExternalBrowserService(
      launchUrl: FakeLauncher(shouldLaunch: false).launch,
    );

    expect(
      () => service.open(Uri.parse('https://supplier.example/search')),
      throwsA(isA<BrowserLaunchException>()),
    );
  });

  test('converte eccezioni tecniche in BrowserLaunchException', () async {
    final service = UrlLauncherExternalBrowserService(
      launchUrl: FakeLauncher(error: StateError('boom')).launch,
    );

    expect(
      () => service.open(Uri.parse('https://supplier.example/search')),
      throwsA(isA<BrowserLaunchException>()),
    );
  });
}

final class FakeLauncher {
  FakeLauncher({this.shouldLaunch = true, this.error});

  final bool shouldLaunch;
  final Object? error;
  final List<Uri> openedUrls = [];
  final List<url_launcher.LaunchMode> modes = [];

  Future<bool> launch(
    Uri url, {
    url_launcher.LaunchMode mode = url_launcher.LaunchMode.platformDefault,
  }) async {
    if (error != null) {
      throw error!;
    }
    openedUrls.add(url);
    modes.add(mode);
    return shouldLaunch;
  }
}
