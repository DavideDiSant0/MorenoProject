# Data Model

Questo documento anticipa il modello dati locale. Non sono state implementate
tabelle Drift in questa fase.

## Persistenza

La persistenza prevista e' SQLite tramite Drift. Il database sara locale al
dispositivo e non conterra password, token, dati di pagamento o credenziali.

## Tabelle Concettuali Future

- `device_types`;
- `brands`;
- `device_models`;
- `components`;
- `device_type_components`;
- `suppliers`;
- `supplier_device_types`;
- `search_history`;
- `search_history_suppliers`;
- `favorites`;
- `favorite_suppliers`;
- `app_settings`.

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

Ogni schema Drift dovra avere versione esplicita. Le migrazioni dovranno essere
documentate, testate e prive di cancellazioni distruttive silenziose.

## Indici E Vincoli

Gli indici saranno introdotti solo quando motivati dai flussi di ricerca o da
vincoli di unicita. Possibili candidati futuri:

- nome marca normalizzato;
- coppia marca/modello;
- ordinamento fornitori;
- data della cronologia;
- relazioni molti-a-molti.

## Separazione

- Le tabelle Drift stanno in `lib/data/database/tables`.
- I DAO stanno in `lib/data/database/daos`.
- Le migrazioni stanno in `lib/data/database/migrations`.
- I repository concreti stanno in `lib/data/repositories`.
- I contratti repository stanno in `lib/domain/repositories`.

La UI non deve eseguire query SQL e non deve importare Drift.
