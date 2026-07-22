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

Responsabilita future:

- salvataggio delle combinazioni frequenti;
- associazione dei fornitori preferiti;
- ripetizione rapida della ricerca.

## History

Responsabilita future:

- salvataggio delle ricerche;
- visualizzazione cronologica;
- ripetizione;
- eliminazione;
- conversione in preferito.

## Settings

Responsabilita future:

- limite massimo di pagine da aprire;
- conferma prima dell'apertura multipla;
- gestione della cronologia;
- configurazioni locali;
- futuro backup ed esportazione.
