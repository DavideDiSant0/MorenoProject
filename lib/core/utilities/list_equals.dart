/// Confronta due liste elemento per elemento.
///
/// Il dominio non puo dipendere da Flutter (`AGENTS.md`), quindi non si usa
/// `package:flutter/foundation.dart`. Usata dalle entita' che contengono
/// collezioni per implementare `==` in modo coerente.
bool listEquals<T>(List<T> a, List<T> b) {
  if (identical(a, b)) return true;
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
