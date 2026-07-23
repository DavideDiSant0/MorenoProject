# Report Di Collaudo Finale

Data del collaudo: 23 luglio 2026.

## Esito

Il codice applicativo e il bundle macOS superano la qualification funzionale
eseguita. La distribuzione esterna non e' ancora un "go" definitivo: firma e
notarizzazione macOS, icone prodotto e build nativa Windows restano attivita'
obbligatorie prima di consegnare installer pubblici.

Una demo sul Mac di sviluppo e' tecnicamente eseguibile.

## Ambiente Verificato

- Flutter 3.41.7 stable;
- Dart 3.11.5;
- macOS 26.5.2 su Apple Silicon;
- Xcode 26.6;
- database SQLite locale tramite Drift;
- bundle versione `1.0.0+1`.

`flutter doctor -v` non ha segnalato problemi sull'ambiente.

## Qualification Automatica

- `flutter pub get`: superato;
- `dart format .`: superato, 153 file verificati e zero modifiche;
- `flutter analyze`: superato, zero issue;
- `flutter test`: 179 test superati;
- seconda esecuzione completa con coverage: 179 test superati;
- copertura linee, escluso codice generato Drift: 86,95%;
- `flutter build macos --release`: superato dopo una ricostruzione pulita.

Il bundle macOS risultante:

- si chiama `Repair Parts Finder.app`;
- contiene un eseguibile universale `arm64` e `x86_64`;
- supera `codesign --verify --deep --strict`;
- pesa circa 47 MB;
- si avvia come processo nativo;
- crea il database nella Application Support del container;
- supera `PRAGMA integrity_check`;
- applica correttamente il seed demo.

Una build incrementale successiva al cambio del nome prodotto ha inizialmente
conservato una firma interna incoerente. La ricostruzione dopo `flutter clean`
ha eliminato il problema e il bundle finale supera la verifica severa. Le build
candidate alla distribuzione devono quindi essere prodotte da uno stato pulito.

## Stress E Regressioni

Sono coperti esplicitamente:

- 300 ricerche persistite, ordinate e cancellate con verifica della cascata;
- 1000 input variabili con caratteri Unicode, riservati e whitespace nel
  generatore URL;
- chiusura e riapertura del database reale su disco;
- seed idempotente e conservazione delle impostazioni;
- aggiornamenti concorrenti delle impostazioni;
- selezioni concorrenti dei fornitori in ricerca e preferiti;
- apertura e salvataggio preferito immediati dopo una selezione ancora
  pendente;
- doppio comando di apertura, senza duplicare URL o cronologia;
- limite massimo pagine;
- cronologia disattivata;
- fallimenti parziali del browser;
- CRUD UI completo del catalogo;
- CRUD, template, compatibilita' e riordino fornitori;
- flussi completi di ricerca, cronologia e preferiti;
- viewport desktop compatte e molto piccole;
- validazioni negative dei dialog senza perdita dell'input;
- query con termini alternativi e deduplicazione.

## Difetti Corretti Durante Il Collaudo

- race condition che perdeva aggiornamenti simultanei delle impostazioni;
- race condition che perdeva selezioni fornitore rapide;
- apertura o salvataggio eseguiti su una selezione fornitore non ancora
  stabilizzata;
- possibilita' di duplicare aperture e cronologia con un doppio comando;
- dialog catalogo, fornitore e preferito chiusi anche dopo un salvataggio
  fallito;
- messaggi tecnici grezzi mostrabili in UI;
- ordine fornitore non numerico accettato silenziosamente;
- termini di ricerca alternativi salvati ma non usati;
- query duplicata tra ricerca e preferiti;
- dipendenza diretta `sqlite3_flutter_libs` EOL e non piu necessaria con
  `sqlite3` 3.x;
- nome tecnico `repair_parts_finder` mostrato come nome prodotto su macOS e
  Windows.

## Blocchi Prima Della Distribuzione Esterna

1. Il bundle macOS usa ancora una firma ad-hoc, senza `TeamIdentifier`.
   Servono certificato Developer ID, firma di distribuzione e notarizzazione.
   Gatekeeper non puo quindi considerare questo artefatto un pacchetto finale.
2. Le icone launcher macOS e Windows sono ancora quelle predefinite di Flutter.
   Serve un asset prodotto approvato dal cliente, esportato in tutti i formati
   e le risoluzioni richieste.
3. La build e l'esecuzione Windows non possono essere qualificate da macOS.
   Prima del rilascio Windows occorre eseguire su una macchina Windows:

   ```bash
   flutter pub get
   dart format --output=none --set-exit-if-changed .
   flutter analyze
   flutter test
   flutter build windows --release
   ```

   Dopo la build servono inoltre smoke test di avvio, persistenza, apertura
   browser e packaging installer.

## Decisione Di Rilascio

- Demo locale sul Mac collaudato: **GO tecnico**.
- Distribuzione macOS a un cliente esterno: **NO-GO** fino a firma,
  notarizzazione e sostituzione icona.
- Distribuzione Windows: **NO-GO** fino alla qualification su Windows e alla
  sostituzione icona.
