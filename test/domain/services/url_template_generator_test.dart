import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

void main() {
  const generator = UrlTemplateGenerator();

  UrlTemplateValues buildValues({
    String? query = 'Apple iPhone 12 screen',
    String? deviceType = 'Smartphone',
    String? brand = 'Apple',
    String? model = 'iPhone 12',
    String? modelCode = 'A2403',
    String? component = 'OLED & frame',
  }) {
    return UrlTemplateValues(
      query: query,
      deviceType: deviceType,
      brand: brand,
      model: model,
      modelCode: modelCode,
      component: component,
    );
  }

  group('generate', () {
    test('sostituisce query con URL encoding', () {
      final uri = generator.generate(
        'https://supplier.example/search?q={query}',
        buildValues(query: 'iPhone 12 screen black'),
      );

      expect(
        uri.toString(),
        'https://supplier.example/search?q=iPhone%2012%20screen%20black',
      );
    });

    test('sostituisce piu placeholder nello stesso template', () {
      final uri = generator.generate(
        'https://supplier.example/search?brand={brand}&model={model}'
        '&part={component}',
        buildValues(),
      );

      expect(
        uri.toString(),
        'https://supplier.example/search?brand=Apple&model=iPhone%2012'
        '&part=OLED%20%26%20frame',
      );
    });

    test('rimuove spazi esterni da template e valori', () {
      final uri = generator.generate(
        '  https://supplier.example/{modelCode}?q={query}  ',
        buildValues(query: '  battery cover  ', modelCode: ' A2403 '),
      );

      expect(
        uri.toString(),
        'https://supplier.example/A2403?q=battery%20cover',
      );
    });

    test(
      'sostituisce tutte le occorrenze ripetute dello stesso placeholder',
      () {
        final uri = generator.generate(
          'https://supplier.example/search?q={brand}+{brand}+{component}',
          buildValues(component: 'screen'),
        );

        expect(
          uri.toString(),
          'https://supplier.example/search?q=Apple+Apple+screen',
        );
      },
    );

    test('rifiuta valori mancanti', () {
      expect(
        () => generator.generate(
          'https://supplier.example/search?code={modelCode}',
          buildValues(modelCode: null),
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta valori vuoti o composti solo da spazi', () {
      expect(
        () => generator.generate(
          'https://supplier.example/search?q={query}',
          buildValues(query: '   '),
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });

  group('validateTemplate', () {
    test('accetta un template HTTP o HTTPS con placeholder supportato', () {
      expect(
        () => generator.validateTemplate(
          'https://supplier.example/search?q={query}',
        ),
        returnsNormally,
      );
      expect(
        () => generator.validateTemplate(
          'http://supplier.example/search?q={brand}',
        ),
        returnsNormally,
      );
    });

    test('rifiuta template senza placeholder supportati', () {
      expect(
        () => generator.validateTemplate('https://supplier.example/search'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta placeholder sconosciuti', () {
      expect(
        () => generator.validateTemplate(
          'https://supplier.example/search?q={unknown}',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta placeholder malformati', () {
      expect(
        () => generator.validateTemplate(
          'https://supplier.example/search?q={query',
        ),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta schemi non sicuri', () {
      expect(
        () => generator.validateTemplate('file:///tmp/{query}'),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => generator.validateTemplate('javascript:alert({query})'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta URL relativi o host assente', () {
      expect(
        () => generator.validateTemplate('/search?q={query}'),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => generator.validateTemplate('https:///search?q={query}'),
        throwsA(isA<ValidationException>()),
      );
    });

    test('rifiuta spazi grezzi nel template', () {
      expect(
        () => generator.validateTemplate(
          'https://supplier.example/search path?q={query}',
        ),
        throwsA(isA<ValidationException>()),
      );
    });
  });
}
