/// Verifica che [value] non sia vuoto o composto solo da spazi.
///
/// Usato nei costruttori delle entita' di dominio per garantire l'invariante
/// anche in build di release, dove `assert` verrebbe rimosso.
void requireNotBlank(String value, String fieldName) {
  if (value.trim().isEmpty) {
    throw ArgumentError.value(value, fieldName, 'Non puo essere vuoto.');
  }
}
