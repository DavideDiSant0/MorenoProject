import 'package:repair_parts_finder/domain/services/url_template_placeholder.dart';

/// Valori disponibili per sostituire i placeholder di un template URL.
final class UrlTemplateValues {
  const UrlTemplateValues({
    this.query,
    this.deviceType,
    this.brand,
    this.model,
    this.modelCode,
    this.component,
  });

  final String? query;
  final String? deviceType;
  final String? brand;
  final String? model;
  final String? modelCode;
  final String? component;

  String? valueFor(UrlTemplatePlaceholder placeholder) {
    return switch (placeholder) {
      UrlTemplatePlaceholder.query => query,
      UrlTemplatePlaceholder.deviceType => deviceType,
      UrlTemplatePlaceholder.brand => brand,
      UrlTemplatePlaceholder.model => model,
      UrlTemplatePlaceholder.modelCode => modelCode,
      UrlTemplatePlaceholder.component => component,
    };
  }
}
