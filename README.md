# Repair Parts Finder

Repair Parts Finder e' un progetto desktop locale per velocizzare la ricerca
di ricambi destinato a un riparatore di dispositivi elettronici.

L'applicazione guida l'utente nella selezione di dispositivo, marca,
modello, componente e fornitori, genera query/URL e apre le pagine dei
fornitori nel browser esterno. L'app non effettuera acquisti, non salvera
credenziali e non gestira pagamenti.

## Stato Attuale

Fase tecnica 7 - UI operative principali.

Questo repository contiene:

- progetto Flutter desktop inizializzato;
- dominio implementato: entita in `lib/domain/entities`, contratti
  repository in `lib/domain/repositories`;
- persistenza locale implementata: schema Drift (12 tabelle) in
  `lib/data/database`, DAO, mapper e repository concreti in `lib/data`;
- casi d'uso applicativi per catalogo, fornitori, ricerca, preferiti,
  cronologia e impostazioni;
- URL Template System con placeholder, validazione, blocco schemi non sicuri e
  URL encoding;
- Browser Service astratto con adapter `url_launcher` confinato nel layer data;
- shell desktop GoRouter con `NavigationRail`;
- catalogo operativo in `/catalog` per tipi dispositivo, marche, modelli,
  componenti e compatibilita dispositivo/componente;
- fornitori operativi in `/suppliers` con CRUD, template URL, test template,
  ordinamento e compatibilita con i tipi dispositivo;
- ricerca operativa in `/search` con selezioni dipendenti, generazione query,
  anteprima URL, conferma, apertura browser esterno e salvataggio cronologia;
- cronologia operativa in `/history` per vedere ricerche salvate, ripetere
  l'apertura URL, eliminare una voce e svuotare tutto;
- preferiti operativi in `/favorites` per salvare combinazioni frequenti con
  fornitori preferiti e rilanciarle;
- impostazioni operative in `/settings` per limite pagine, conferma apertura e
  salvataggio cronologia;
- dati demo iniziali per catalogo, fornitori, compatibilita e un preferito,
  applicati solo quando il database visibile all'utente e' vuoto;
- gestione errori di persistenza (`lib/core/errors`);
- test per entita, mapper, database, DAO, repository, casi d'uso, servizi URL,
  browser service e smoke test UI;
- documentazione tecnica e regole operative per agenti AI.

Non sono ancora stati implementati backup/export-import, scraping o
integrazioni remote.

## Tecnologie

- Flutter Desktop;
- Dart;
- Riverpod per lo stato;
- GoRouter per la navigazione interna;
- Drift con SQLite per la persistenza locale;
- url_launcher per aprire il browser esterno;
- flutter_lints, analisi statica e test Flutter.

## Piattaforme Previste

- macOS;
- Windows.

Il progetto e' inizializzato con i target desktop `macos` e `windows`.

## Architettura Sintetica

Il codice futuro dovra seguire un'architettura a livelli:

- `presentation`: widget, schermate e controller UI;
- `application`: casi d'uso, stato applicativo e DTO;
- `domain`: entita, value object, regole di dominio e contratti repository;
- `data`: Drift, SQLite, DAO, mapper, datasource e repository concreti;
- `core`: errori, costanti, servizi condivisi, validazioni e utility;
- `features`: organizzazione funzionale futura per search, catalog, suppliers,
  favorites, history e settings.

Le dipendenze devono puntare verso l'interno. La UI non accede direttamente al
database e non usa direttamente `url_launcher`.

## Struttura Del Repository

```text
lib/
  main.dart
  app/
  core/
  domain/
  application/
  data/
  presentation/
  features/
docs/
  decisions/
.vscode/
macos/
windows/
test/
```

La convenzione completa e' descritta in
[docs/03-architecture.md](docs/03-architecture.md).

## Preparazione Ambiente

Verificare la toolchain:

```bash
flutter --version
dart --version
flutter doctor -v
git --version
flutter devices
```

Abilitare i target desktop se necessario:

```bash
flutter config --enable-macos-desktop --enable-windows-desktop
```

Installare le dipendenze:

```bash
flutter pub get
```

## Comandi Di Verifica

Formattazione:

```bash
dart format .
```

Analisi statica:

```bash
flutter analyze
```

Test:

```bash
flutter test
```

Avvio desktop macOS:

```bash
flutter run -d macos
```

Avvio desktop Windows, da una macchina Windows configurata:

```bash
flutter run -d windows
```

## Documentazione

- [Overview](docs/01-project-overview.md)
- [Requisiti](docs/02-requirements-summary.md)
- [Architettura](docs/03-architecture.md)
- [Moduli](docs/04-modules.md)
- [Modello di dominio](docs/05-domain-model.md)
- [Modello dati](docs/06-data-model.md)
- [Template URL](docs/07-url-template-system.md)
- [Navigazione e UI](docs/08-navigation-and-ui.md)
- [Error handling](docs/09-error-handling.md)
- [Sicurezza e privacy](docs/10-security-and-privacy.md)
- [Linee guida sviluppo](docs/11-development-guidelines.md)
- [Roadmap](docs/12-roadmap.md)

ADR iniziali:

- [ADR-001 Flutter Desktop](docs/decisions/ADR-001-flutter-desktop.md)
- [ADR-002 SQLite e Drift](docs/decisions/ADR-002-local-sqlite-drift.md)
- [ADR-003 Nessun backend per MVP](docs/decisions/ADR-003-no-backend-for-mvp.md)
- [ADR-004 Architettura a livelli](docs/decisions/ADR-004-layered-architecture.md)
- [ADR-005 Browser esterno](docs/decisions/ADR-005-external-browser.md)
- [ADR-006 Riverpod](docs/decisions/ADR-006-riverpod.md)
- [ADR-007 Template URL configurabili](docs/decisions/ADR-007-configurable-url-templates.md)
- [ADR-008 Identificativi come stringhe UUID](docs/decisions/ADR-008-identifiers-as-uuid-strings.md)

## Funzionalita Escluse Dall'MVP

- backend;
- servizi cloud;
- Firebase;
- API remote;
- scraping;
- autenticazione;
- salvataggio credenziali;
- dati di pagamento;
- automazione checkout;
- browser embedded;
- acquisti diretti.

## Roadmap Sintetica

- Fase 0: bootstrap, dipendenze, struttura, documentazione e regole agenti;
- Fase 1: dominio e database;
- Fase 2: catalogo;
- Fase 3: fornitori;
- Fase 4: ricerca;
- Fase 5: cronologia e preferiti;
- Fase 6: impostazioni e backup;
- Fase 7: qualita e distribuzione.

La roadmap completa e' in [docs/12-roadmap.md](docs/12-roadmap.md).
