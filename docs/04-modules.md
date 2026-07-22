# Modules

## Search

Implementato:

- selezione progressiva del dispositivo;
- selezione marca;
- selezione modello;
- selezione componente;
- selezione fornitori;
- generazione query;
- generazione URL;
- anteprima;
- apertura delle pagine;
- salvataggio della cronologia.

Regole:

- le opzioni dipendenti vengono ricalcolate dal controller tramite casi d'uso;
- i modelli dipendono da tipo dispositivo e marca;
- componenti e fornitori dipendono dalla compatibilita del tipo dispositivo;
- la UI non costruisce URL e non importa `url_launcher`;
- l'apertura passa da `OpenExternalUrlUseCase`;
- il limite massimo pagine, la conferma e la cronologia rispettano
  `AppSettings`;
- ogni apertura registra URL e risultato in cronologia quando la cronologia e'
  abilitata.

## Catalog

Implementato:

- CRUD tipi di dispositivo;
- CRUD marche;
- CRUD modelli con tipo dispositivo, marca, codice modello e termini
  alternativi;
- CRUD componenti;
- gestione compatibilita tra tipo di dispositivo e componente;
- caricamento stato tramite Riverpod, casi d'uso e repository Drift.

Regole:

- la UI non accede direttamente a Drift;
- la UI chiama `CatalogController`, che delega ai casi d'uso;
- eliminazioni e duplicati continuano a rispettare i vincoli del repository;
- i modelli possono essere creati solo quando esistono almeno un tipo
  dispositivo e una marca.

## Suppliers

Implementato:

- aggiunta, modifica ed eliminazione fornitore;
- attivazione e disattivazione;
- ordinamento;
- compatibilita con i tipi di dispositivo;
- configurazione template URL;
- validazione template URL in create/update;
- test del template con URL generato da valori di prova;
- caricamento stato tramite Riverpod, casi d'uso e repository Drift.

Regole:

- la UI non usa direttamente il generatore URL;
- la UI non apre il browser durante il test template;
- `SupplierUseCases` valida il template prima di salvare;
- gli schemi non sicuri continuano a essere bloccati dal generatore URL;
- l'ordinamento e' persistito tramite `displayOrder`.

## Favorites

Implementato:

- salvataggio delle combinazioni frequenti;
- associazione dei fornitori preferiti;
- ripetizione rapida della ricerca.

Regole:

- un preferito salva ID di catalogo e fornitori preferiti;
- il rilancio ricostruisce la ricerca tramite `PrepareSearchUseCase`;
- se catalogo o fornitori non sono piu attivi/compatibili, il rilancio viene
  bloccato da validazioni applicative;
- l'apertura passa da `OpenExternalUrlUseCase`;
- limite massimo pagine, conferma e cronologia rispettano `AppSettings`;
- la UI non genera URL direttamente e non importa `url_launcher`.

## History

Implementato:

- salvataggio delle ricerche;
- visualizzazione cronologica;
- dettaglio di query, snapshot catalogo e URL fornitori;
- ripetizione tramite riapertura degli URL salvati;
- eliminazione singola voce;
- svuotamento cronologia.

Responsabilita future:

- conversione in preferito.

Regole:

- la cronologia mostra snapshot testuali, quindi resta leggibile anche se
  catalogo o fornitori cambiano;
- ripetere una ricerca riapre gli URL salvati, non ricostruisce le selezioni;
- l'apertura passa da `OpenExternalUrlUseCase`;
- limite massimo pagine e conferma rispettano `AppSettings`;
- la UI non accede direttamente al database e non importa `url_launcher`.

## Settings

Implementato:

- limite massimo di pagine da aprire;
- conferma prima dell'apertura multipla;
- gestione del salvataggio cronologia;
- lettura e aggiornamento persistente tramite `AppSettingsUseCases`;
- caricamento stato tramite Riverpod e repository Drift.

Responsabilita future:

- futuro backup ed esportazione.

Regole:

- le impostazioni restano locali e non contengono dati sensibili;
- la UI chiama `SettingsController`, che delega ai casi d'uso;
- ricerca, cronologia e preferiti devono rispettare sempre `AppSettings`.

## Demo Data

Implementato:

- seed iniziale per tipi dispositivo, marche, modelli e componenti;
- compatibilita dispositivo/componente;
- fornitori demo con template URL validi;
- compatibilita fornitori/tipi dispositivo;
- un preferito dimostrativo.

Regole:

- il seed viene applicato dal provider del database reale, non dalla migration;
- i test DAO possono continuare a creare database vuoti;
- il seed parte solo se catalogo e fornitori sono vuoti, cosi' non mescola
  dati demo con dati gia inseriti dall'utente;
- gli ID demo usano prefisso `demo-` e sono stabili.
