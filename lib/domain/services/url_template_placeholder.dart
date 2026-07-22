/// Placeholder supportati nei template URL dei fornitori.
enum UrlTemplatePlaceholder {
  query('query'),
  deviceType('deviceType'),
  brand('brand'),
  model('model'),
  modelCode('modelCode'),
  component('component');

  const UrlTemplatePlaceholder(this.name);

  final String name;

  String get token => '{$name}';

  static UrlTemplatePlaceholder? fromName(String name) {
    for (final placeholder in values) {
      if (placeholder.name == name) {
        return placeholder;
      }
    }
    return null;
  }
}
