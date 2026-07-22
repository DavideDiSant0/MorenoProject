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

## Test Futuri

- Unit test per value object, validazioni e generatore URL.
- Test per casi d'uso applicativi.
- Test per mapper e repository con database locale controllato.
- Widget test per stati UI rilevanti.
- Test di migrazione Drift quando lo schema cambia.

In questa fase sono predisposti solo i test Flutter generati dal bootstrap.
