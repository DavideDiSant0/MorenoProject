import 'package:repair_parts_finder/core/errors/validation_exception.dart';
import 'package:repair_parts_finder/domain/services/url_template_placeholder.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

/// Genera URL sicuri e testabili a partire dai template configurati per i
/// fornitori. Non apre il browser e non dipende dalla UI.
final class UrlTemplateGenerator {
  static final RegExp _placeholderPattern = RegExp(r'\{([^{}]+)\}');

  const UrlTemplateGenerator();

  /// Valida il template senza richiedere valori di sostituzione.
  void validateTemplate(String template) {
    final normalizedTemplate = template.trim();
    if (normalizedTemplate.isEmpty) {
      throw const ValidationException('Il template URL non puo essere vuoto.');
    }

    final placeholders = _extractPlaceholders(normalizedTemplate);
    if (placeholders.isEmpty) {
      throw const ValidationException(
        'Il template URL deve contenere almeno un placeholder supportato.',
      );
    }

    final templateForParsing = _replacePlaceholdersForParsing(
      normalizedTemplate,
      placeholders,
    );
    final uri = Uri.tryParse(templateForParsing);
    if (uri == null || !uri.hasScheme) {
      throw const ValidationException('Il template URL non e\' valido.');
    }
    if (!_isAllowedScheme(uri.scheme)) {
      throw const ValidationException(
        'Il template URL deve usare solo HTTP o HTTPS.',
      );
    }
    if (uri.host.trim().isEmpty || RegExp(r'\s').hasMatch(templateForParsing)) {
      throw const ValidationException('Il template URL non e\' valido.');
    }
  }

  /// Genera l'URL finale sostituendo i placeholder con valori codificati.
  Uri generate(String template, UrlTemplateValues values) {
    final normalizedTemplate = template.trim();
    final placeholders = _extractPlaceholders(normalizedTemplate);
    validateTemplate(normalizedTemplate);

    var generated = normalizedTemplate;
    for (final placeholder in placeholders) {
      final value = values.valueFor(placeholder)?.trim();
      if (value == null || value.isEmpty) {
        throw ValidationException(
          'Manca il valore per il placeholder ${placeholder.token}.',
        );
      }
      generated = generated.replaceAll(
        placeholder.token,
        Uri.encodeComponent(value),
      );
    }

    final uri = Uri.tryParse(generated);
    if (uri == null || !uri.hasScheme) {
      throw const ValidationException('L\'URL generato non e\' valido.');
    }
    if (!_isAllowedScheme(uri.scheme)) {
      throw const ValidationException('L\'URL generato non e\' valido.');
    }
    if (uri.host.trim().isEmpty ||
        generated.contains('{') ||
        generated.contains('}')) {
      throw const ValidationException('L\'URL generato non e\' valido.');
    }

    return uri;
  }

  Set<UrlTemplatePlaceholder> _extractPlaceholders(String template) {
    final matches = _placeholderPattern.allMatches(template).toList();
    _ensureNoMalformedBraces(template, matches);

    final placeholders = <UrlTemplatePlaceholder>{};
    for (final match in matches) {
      final name = match.group(1);
      final placeholder = name == null
          ? null
          : UrlTemplatePlaceholder.fromName(name);
      if (placeholder == null) {
        throw ValidationException(
          'Placeholder non supportato nel template URL: {$name}.',
        );
      }
      placeholders.add(placeholder);
    }
    return placeholders;
  }

  void _ensureNoMalformedBraces(
    String template,
    List<RegExpMatch> placeholderMatches,
  ) {
    var cursor = 0;
    for (final match in placeholderMatches) {
      final beforeMatch = template.substring(cursor, match.start);
      if (beforeMatch.contains('{') || beforeMatch.contains('}')) {
        throw const ValidationException(
          'Il template URL contiene placeholder non validi.',
        );
      }
      cursor = match.end;
    }

    final afterLastMatch = template.substring(cursor);
    if (afterLastMatch.contains('{') || afterLastMatch.contains('}')) {
      throw const ValidationException(
        'Il template URL contiene placeholder non validi.',
      );
    }
  }

  String _replacePlaceholdersForParsing(
    String template,
    Set<UrlTemplatePlaceholder> placeholders,
  ) {
    var templateForParsing = template;
    for (final placeholder in placeholders) {
      templateForParsing = templateForParsing.replaceAll(
        placeholder.token,
        'value',
      );
    }
    return templateForParsing;
  }

  bool _isAllowedScheme(String scheme) {
    final normalizedScheme = scheme.toLowerCase();
    return normalizedScheme == 'http' || normalizedScheme == 'https';
  }
}
