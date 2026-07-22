import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const _databaseFileName = 'repair_parts_finder.sqlite';

/// Apre la connessione al database reale su disco, nella cartella dei dati
/// applicativi (non i documenti dell'utente, dato che questo file non e'
/// contenuto che l'utente gestisce direttamente).
Future<QueryExecutor> openConnection() async {
  final supportDirectory = await getApplicationSupportDirectory();
  return openConnectionAt(supportDirectory.path);
}

/// Apre la connessione a un file di database nella cartella [directoryPath].
///
/// Separata da [openConnection] perche' non dipende da plugin Flutter: puo'
/// essere testata direttamente con una directory temporanea, senza
/// `MissingPluginException` in assenza del binding del motore Flutter.
QueryExecutor openConnectionAt(String directoryPath) {
  final file = File(p.join(directoryPath, _databaseFileName));
  return NativeDatabase.createInBackground(file);
}
