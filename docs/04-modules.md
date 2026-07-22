# Modules

## Search

Responsabilita future:

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

Responsabilita future:

- aggiunta fornitore;
- modifica fornitore;
- attivazione e disattivazione;
- ordinamento;
- compatibilita con i tipi di dispositivo;
- configurazione template URL;
- test del template.

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
