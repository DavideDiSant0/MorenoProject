# Development Guidelines

## Prima Di Modificare

1. Leggere `AGENTS.md`.
2. Leggere i documenti pertinenti in `docs/`.
3. Analizzare il codice esistente.
4. Limitare la modifica alla richiesta.
5. Aggiornare documentazione e ADR quando cambia una decisione.

## Qualita Codice

- Nomi in inglese nel codice.
- Documentazione in italiano.
- Codice semplice, leggibile e testabile.
- Null safety.
- Funzioni brevi.
- File piccoli e coesi.
- Una responsabilita principale per classe.
- KISS, DRY e Single Responsibility.
- Nessuna astrazione prematura.
- Nessuna classe "god object".

## Dipendenze

Non introdurre nuove librerie senza motivazione tecnica. Prima di aggiungere una
dipendenza, verificare se Flutter, Dart o lo stack gia approvato risolvono il
problema.

## Git

Il repository usa Git. Non eseguire push e non configurare remoti senza
richiesta esplicita.

Strategia futura semplice:

- `main`;
- `develop`;
- `feature/*`;
- `fix/*`;
- `docs/*`.

Non creare questi branch finche non servono.

## Comandi

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

Avvio locale:

```bash
flutter run -d macos
flutter run -d windows
```

`flutter run -d windows` richiede una macchina Windows configurata.

## Test Implementati (Fase 1)

- Unit test per le entita' di dominio: costruzione, invarianti, `==`,
  `copyWith` (`test/domain/entities`).
- Test dei mapper entita' <-> Drift, incluso il round-trip dei termini
  alternativi (`test/data/mappers`).
- Test del database Drift: versione schema, tabelle attese, foreign key
  attive (`test/data/database`).
- Test dei DAO: CRUD, join di compatibilita', comportamento
  cascade/restrict/set-null, vincolo unique (`test/data/database/daos`).
- Test dei repository: traduzione errori (`NotFoundException`,
  `PersistenceException`), mapping end-to-end (`test/data/repositories`).

## Test Futuri

- Unit test per value object e generatore URL, quando implementati (Fase 3).
- Test per casi d'uso applicativi (Fase 2 in poi).
- Widget test per stati UI rilevanti (quando esisteranno schermate reali).
- Test di migrazione Drift quando lo schema cambiera' (dalla versione 2 in
  poi).
