import 'package:repair_parts_finder/application/dto/prepared_search.dart';

/// Costruisce la query testuale condivisa da ricerca e preferiti.
///
/// I termini alternativi distinti vengono inclusi, mentre duplicati che
/// differiscono solo per maiuscole/minuscole o spazi vengono rimossi.
String buildSearchQuery(PreparedSearch prepared) {
  final seenParts = <String>{};
  final queryParts = <String>[
    prepared.brand.name,
    prepared.deviceModel.name,
    if (prepared.deviceModel.modelCode != null) prepared.deviceModel.modelCode!,
    ...prepared.deviceModel.alternativeSearchTerms,
    prepared.component.name,
  ];

  return queryParts
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .where((part) => seenParts.add(part.toLowerCase()))
      .join(' ');
}
