# ADR-002 - SQLite Locale Con Drift

## Stato

Accettata.

## Contesto

L'app deve conservare catalogo, fornitori, preferiti, impostazioni e cronologia
su macchina locale, senza backend.

## Decisione

Usare SQLite come database locale e Drift come layer Dart tipizzato.

## Motivazioni

SQLite e' stabile, locale, leggero e adatto a dati relazionali. Drift offre
query tipizzate, migrazioni, testabilita e integrazione con Dart.

## Alternative Considerate

- File JSON: semplice, ma meno robusto per relazioni e query.
- Hive o store chiave-valore: utile per dati semplici, meno adatto a relazioni.
- Database remoto: non coerente con MVP locale.

## Conseguenze Positive

- Persistenza locale affidabile.
- Schema versionato.
- Migrazioni esplicite.
- Buona testabilita.

## Conseguenze Negative

- Richiede gestione migrazioni.
- Richiede generazione codice quando saranno definite le tabelle.

## Condizioni Di Revisione

Rivedere se il modello dati diventa non relazionale o se emergono requisiti di
sincronizzazione multi-dispositivo.
