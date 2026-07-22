# AGENTS.md

Questo file e' vincolante per ogni agente AI che modifica il progetto.
Prima di intervenire, leggere questo documento e i file pertinenti in `docs/`.

## Contesto

Repair Parts Finder e' una futura applicazione desktop locale per un riparatore
di dispositivi elettronici. L'obiettivo e' rendere rapida la ricerca di
componenti di ricambio tramite selezioni guidate e apertura delle pagine dei
fornitori nel browser esterno.

L'MVP non effettua acquisti, non salva password, non gestisce pagamenti, non
esegue login automatici e non usa servizi remoti.

## Stack Autorizzato

- Flutter Desktop;
- Dart;
- Riverpod;
- Drift e SQLite;
- GoRouter;
- url_launcher;
- linting Dart/Flutter;
- test Flutter.

## Stack Vietato Senza Approvazione

- backend;
- servizi cloud;
- Firebase;
- scraping;
- browser embedded;
- sistemi di pagamento;
- autenticazione;
- nuove librerie non motivate;
- API remote non approvate.

## Regole Architetturali

- Rispettare i livelli `presentation`, `application`, `domain`, `data` e
  `core`.
- Le dipendenze devono puntare verso l'interno dell'architettura.
- La UI non accede direttamente al database.
- La UI non usa direttamente `url_launcher`.
- I widget non costruiscono URL di fornitori.
- I widget non contengono logica di business.
- I repository astratti stanno nel livello `domain`.
- Le implementazioni repository stanno nel livello `data`.
- I casi d'uso stanno nel livello `application`.
- Drift e SQLite restano confinati nel livello `data`.
- I servizi esterni devono essere astratti dietro contratti testabili.
- Riverpod collega la UI a casi d'uso e servizi, senza diventare dominio.
- GoRouter gestisce solo la navigazione.
- Evitare dipendenze circolari.

## Regole Per Le Feature

Ogni nuova funzionalita deve dichiarare prima dell'implementazione:

- problema risolto;
- livello o modulo interessato;
- entita coinvolte;
- caso d'uso;
- dipendenze;
- validazioni;
- errori previsti;
- test previsti.

## Regole Di Modifica

Prima di modificare il progetto, l'agente deve:

1. leggere `AGENTS.md`;
2. leggere i documenti architetturali pertinenti;
3. analizzare il codice esistente;
4. evitare riscritture non richieste;
5. proporre o documentare eventuali variazioni architetturali;
6. non introdurre nuove dipendenze senza motivazione;
7. aggiornare la documentazione quando cambia una decisione;
8. creare un ADR per decisioni architetturali rilevanti.

Non eliminare o sovrascrivere contenuti esistenti senza averli prima analizzati.
Non introdurre codice placeholder inutile.

## Regole Di Qualita

- Usare nomi espliciti in inglese nel codice.
- Usare documentazione in italiano, salvo termini tecnici standard.
- Mantenere il codice semplice, leggibile e testabile.
- Applicare null safety.
- Tenere funzioni e file brevi.
- Dare una responsabilita principale a ogni classe.
- Applicare KISS, DRY e Single Responsibility.
- Evitare astrazioni premature.
- Evitare classi "god object".
- Gestire esplicitamente errori e casi limite.
- Non usare `print` nel codice definitivo.
- Non hardcodare dati sensibili.
- Non hardcodare URL di fornitori nella UI.
- Non inserire logica applicativa in `build`.
- Non usare accesso globale non controllato allo stato.

## Regole Database

- Lo schema Drift deve essere versionato.
- Le migrazioni devono essere esplicite.
- Vincoli e indici devono essere motivati.
- Le cancellazioni devono essere coerenti con il modello dati.
- Nessuna modifica distruttiva deve avvenire silenziosamente.
- Usare snapshot per i dati storici quando necessario.
- Separare DAO e repository.
- Nessuna query SQL deve partire dalla UI.
- Non creare tabelle Drift senza aggiornare documentazione e test.

## Regole Template URL

- I placeholder devono essere centralizzati.
- I template devono essere validati.
- I valori devono essere codificati con URL encoding.
- Sono ammessi solo URL `http` e `https`.
- Schemi come `file:`, `javascript:` o comandi locali sono vietati.
- Placeholder sconosciuti devono produrre errori di validazione.
- Valori mancanti non devono generare URL incompleti in silenzio.
- Il generatore URL deve essere indipendente da UI e browser service.
- I test unitari saranno obbligatori quando il modulo verra implementato.

## Definition Of Done

Una modifica e' completa solo se:

- rispetta l'architettura;
- compila;
- supera l'analisi statica;
- include i test necessari;
- gestisce errori e casi limite;
- aggiorna la documentazione pertinente;
- non introduce dipendenze non motivate.

## Comandi Di Verifica

Eseguire prima di considerare completata una modifica:

```bash
flutter pub get
dart format .
flutter analyze
flutter test
```

Per avvio manuale desktop:

```bash
flutter run -d macos
flutter run -d windows
```

`flutter run -d windows` va eseguito su una macchina Windows configurata.

## Git

Non eseguire push senza richiesta esplicita. Non configurare repository remoti
senza richiesta esplicita. Non creare commit automaticamente.

Strategia futura:

- `main`: stato stabile;
- `develop`: integrazione;
- `feature/*`: nuove funzionalita;
- `fix/*`: correzioni;
- `docs/*`: documentazione.
