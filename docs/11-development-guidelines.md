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

## Test Implementati (Application Layer)

- Test dei casi d'uso applicativi per catalogo, fornitori, impostazioni,
  preferiti, preparazione ricerca e cronologia (`test/application/use_cases`).
- Test delle validazioni applicative: selezione ricerca senza fornitori,
  componente non compatibile, fornitore non attivo, template fornitore non
  sicuro e cronologia senza fornitori.
- Test di generazione controllata di id e timestamp tramite servizi astratti
  (`IdGenerator`, `DateTimeProvider`).
- Test di generazione URL di prova tramite `SupplierUseCases.testTemplate`.
- Test di preparazione ricerca per selezioni valide, componenti incompatibili
  e fornitori non attivi/compatibili.

## Test Implementati (URL Template System)

- Unit test per generazione URL con placeholder supportati
  (`test/domain/services/url_template_generator_test.dart`).
- Test per URL encoding, trim, placeholder sconosciuti o malformati, valori
  mancanti e schemi non sicuri (`file:`, `javascript:`).

## Test Implementati (Browser Service)

- Unit test per `UrlLauncherExternalBrowserService`
  (`test/data/services/url_launcher_external_browser_service_test.dart`).
- Test che verificano `LaunchMode.externalApplication`, blocco di schemi non
  sicuri, host assente e conversione dei fallimenti in
  `BrowserLaunchException`.
- Test per `OpenExternalUrlUseCase`, che delega al contratto astratto senza
  conoscere `url_launcher`.

## Test Implementati (Demo Data)

- Test del seed iniziale in `test/data/seed/app_demo_data_seeder_test.dart`.
- Verifica di catalogo, fornitori, compatibilita e preferito demo.
- Verifica idempotenza: richiamare il seed due volte non duplica righe.
- Verifica che il seed non parta quando esistono gia dati utente.
- Verifica del marker `demo_seed_version`, per evitare reinserimenti futuri
  dopo una pulizia manuale del catalogo.
- Verifica che i template URL demo siano validi e generabili.

## Test Implementati (Provider UI)

- Test dei controller Riverpod in
  `test/presentation/providers/controller_integration_test.dart`.
- Verifica propagazione delle impostazioni verso ricerca, cronologia e
  preferiti.
- Verifica che refresh catalogo e fornitori preservino selezioni valide.
- Verifica del messaggio di ricerca quando alcune aperture URL falliscono.

## Test Implementati (UI Shell)

- Widget test per bootstrap della shell desktop con `MaterialApp.router` e
  `NavigationRail`.
- Smoke test per schermata `/search` operativa con selezioni e anteprima vuota.
- Widget test per navigazione da `/search` a `/catalog` tramite GoRouter.
- Widget test per navigazione da `/search` a `/suppliers` tramite GoRouter.
- Widget test per navigazione da `/search` a `/history` tramite GoRouter.
- Widget test per navigazione da `/search` a `/favorites` tramite GoRouter.
- Widget test per navigazione da `/search` a `/settings` tramite GoRouter.
- Widget test per aggiornamento preferenza cronologia in `/settings`.
- Override del database Drift in memoria nei widget test tramite Riverpod.
- Widget test avviati con seed demo, come il provider reale.
- Smoke test aggiornati per le schermate ricerca, catalogo, fornitori,
  cronologia, preferiti e impostazioni operative.

## Test Futuri

- Unit test per value object, quando saranno introdotti.
- Widget test aggiuntivi per i percorsi di errore UI meno frequenti.
- Test di migrazione Drift quando lo schema cambiera' (dalla versione 3 in
  poi).

## Test Di Regressione Rilascio

- Stress test su 300 ricerche persistite con cancellazione a cascata.
- Stress test su 1000 combinazioni di caratteri per l'URL encoding.
- Test di riapertura del database reale su disco con seed idempotente.
- Test di concorrenza per impostazioni e selezioni fornitore.
- Test contro doppi comandi di apertura URL.
- Widget test che mantengono aperti i dialog quando la validazione fallisce.
- Test della query condivisa con termini alternativi e deduplicazione.
