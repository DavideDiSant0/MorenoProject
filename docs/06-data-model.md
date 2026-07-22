# Data Model

Questo documento descrive il modello dati locale implementato nella Fase 1.

## Persistenza

La persistenza e' SQLite tramite Drift. Il database e' locale al dispositivo
e non contiene password, token, dati di pagamento o credenziali.

## Strategia Identificativi

Gli id sono stringhe UUID v4 generate lato Dart (pacchetto `uuid`) prima che
l'entita' raggiunga il repository, non interi autoincrement. Motivazione
completa in [ADR-008](decisions/ADR-008-identifiers-as-uuid-strings.md).

## Tabelle Implementate

- `device_types`;
- `brands`;
- `device_models` (indice unique su `brand_id, name`);
- `components`;
- `device_type_components`;
- `suppliers`;
- `supplier_device_types`;
- `search_history`;
- `search_history_suppliers`;
- `favorites`;
- `favorite_suppliers`;
- `app_settings` (una sola riga, id fisso).

## Comportamento Delle Cancellazioni (ON DELETE)

Coerente con la regola "nessuna modifica distruttiva silenziosa":

- `device_models.device_type_id` / `.brand_id`: `RESTRICT`. Eliminare un tipo
  o una marca con modelli collegati fallisce esplicitamente; il percorso
  normale per rimuovere un tipo/marca dal catalogo attivo e' disattivarlo
  (`is_active = false`).
- `favorites.*` (tutte e 4 le FK verso il catalogo): `RESTRICT`. Un preferito
  e' contenuto creato dall'utente, non metadato usa-e-getta.
- `device_type_components.*`, `supplier_device_types.*`: `CASCADE`. Relazioni
  molti-a-molti pure, senza valore indipendente dalle righe collegate.
- `favorite_suppliers.favorite_id` / `.supplier_id`: `CASCADE`. Perdere un
  fornitore candidato non invalida il preferito; se il preferito sparisce,
  le sue associazioni non hanno piu' motivo di esistere.
- `search_history_suppliers.search_history_id`: `CASCADE`. Riga figlia senza
  vita propria fuori dal genitore.
- `search_history_suppliers.supplier_id`: `SET NULL`. Lo snapshot testuale
  (`supplier_name`) sopravvive; solo il collegamento "vivo" sparisce.

`PRAGMA foreign_keys = ON` e' impostato in `beforeOpen` (SQLite lo disattiva
per default).

## Snapshot O Riferimenti

Per catalogo e preferiti sono utili riferimenti agli identificativi locali,
perche devono seguire il dato corrente.

Per la cronologia sono preferibili snapshot testuali dei valori visibili:

- nome tipo dispositivo;
- nome marca;
- nome modello;
- codice modello;
- nome componente;
- query generata;
- URL generati;
- nome fornitore al momento della ricerca.

Questo evita che una modifica futura al catalogo renda incomprensibili le
ricerche passate.

## Migrazioni

Lo schema attuale e' la versione 1 (`schemaVersion` in
`lib/data/database/app_database.dart`), creata tramite `onCreate`. Non
essendoci ancora una versione precedente, `onUpgrade` e' vuoto e documentato
con un commento che spiega come aggiungere il primo step quando
`schemaVersion` verra' incrementato.

Nota tooling: la generazione dello snapshot JSON dello schema
(`dart run drift_dev schema dump`), la convenzione ufficiale Drift per
testare le migrazioni future, fallisce con la combinazione di versioni
attualmente pinnate (`drift 2.34.2` / `drift_dev 2.34.0`) per un problema
interno del generatore non legato allo schema di questo progetto. Da
rivalutare quando le versioni verranno aggiornate.

## Seed Demo Iniziale

Il seed demo e' implementato in
`lib/data/seed/app_demo_data_seeder.dart` e viene chiamato da
`appDatabaseProvider` dopo l'apertura del database.

Non fa parte della migration Drift: lo schema resta testabile come database
vuoto nei test DAO e il seed resta logica applicativa di bootstrap. Il seeder
inserisce dati solo se catalogo e fornitori non contengono ancora righe
visibili all'utente.

Contenuto attuale:

- tipi dispositivo: smartphone, tablet, laptop;
- marche: Apple, Samsung, Xiaomi;
- modelli dimostrativi;
- componenti riparabili comuni;
- compatibilita dispositivo/componente;
- fornitori con template URL validi;
- compatibilita fornitore/tipo dispositivo;
- un preferito demo.

## Indici E Vincoli

Gli indici sono introdotti solo quando motivati dai flussi di ricerca o da
vincoli di unicita, non preventivamente. Implementato:

- `device_models(brand_id, name)`, unique: candidato esplicito nei requisiti
  ("coppia marca/modello"), nessun giudizio di normalizzazione richiesto.

Rimandati a fasi successive, quando la funzionalita' che li richiede esistera':

- nome marca normalizzato (dipende dalla policy di normalizzazione del caso
  d'uso "aggiungi marca", Fase 2);
- ordinamento fornitori (poche righe attese, nessun vantaggio reale ora);
- data della cronologia (nessuna funzionalita' di filtro la richiede ancora).

## Separazione

- Le tabelle Drift stanno in `lib/data/database/tables`.
- I DAO stanno in `lib/data/database/daos`.
- Le migrazioni stanno in `lib/data/database/migrations`.
- I repository concreti stanno in `lib/data/repositories`.
- I contratti repository stanno in `lib/domain/repositories`.

La UI non deve eseguire query SQL e non deve importare Drift.
