# Navigation And UI

La navigazione e' gestita da GoRouter. Lo stato attuale include una shell
desktop con `NavigationRail` laterale e UI operative per ricerca, catalogo,
fornitori, cronologia, preferiti e impostazioni.

## Route Future

- `/search`;
- `/favorites`;
- `/history`;
- `/catalog`;
- `/suppliers`;
- `/settings`.

## Regole GoRouter

- GoRouter gestisce solo la navigazione.
- Le route non contengono logica di business.
- Le route non accedono direttamente al database.
- Eventuali redirect devono essere semplici e motivati.

## Implementato

- `MaterialApp.router` in `lib/main.dart`.
- Configurazione GoRouter in `lib/app/routing/app_router.dart`.
- Destinazioni centralizzate in `lib/app/routing/app_destination.dart`.
- Shell desktop in `lib/presentation/widgets/app_shell.dart`.
- Schermate tecniche in `lib/presentation/screens`.
- Redirect tecnico da `/` a `/search`.
- Schermata `/catalog` con gestione operativa di tipi dispositivo, marche,
  modelli, componenti e compatibilita.
- Schermata `/suppliers` con gestione operativa di fornitori, template URL,
  ordinamento e compatibilita con tipi dispositivo.
- Schermata `/search` con selezioni dipendenti, preview URL, conferma,
  apertura browser e salvataggio cronologia.
- Schermata `/history` con elenco ricerche salvate, dettaglio, ripetizione,
  eliminazione e svuotamento.
- Schermata `/favorites` con salvataggio combinazioni frequenti e rilancio.
- Schermata `/settings` con limite pagine, conferma apertura e cronologia
  attiva/disattiva.

## Regole UI

- I widget mostrano stato e raccolgono input.
- I widget delegano azioni a controller, provider o casi d'uso.
- I widget non costruiscono URL dei fornitori.
- I widget non aprono direttamente il browser e non importano `url_launcher`.
- I widget non eseguono query SQL.
- La UI deve gestire stati di caricamento, vuoto, errore e conferma quando il
  relativo flusso viene implementato.
- Le schermate tecniche non operative possono mostrare solo struttura e sezioni
  previste; non devono simulare dati reali.

## Catalogo

`/catalog` usa `CatalogController` in
`lib/presentation/providers/catalog_controller.dart` e i provider di
composizione in `lib/app/configuration/app_providers.dart`.

La schermata espone cinque tab:

- tipi dispositivo;
- marche;
- modelli;
- componenti;
- compatibilita.

Le operazioni di creazione, modifica, eliminazione e assegnazione
compatibilita passano dai casi d'uso applicativi. Gli errori di dominio o
persistenza vengono mostrati come messaggi UI senza bypassare i layer.

## Fornitori

`/suppliers` usa `SupplierController` in
`lib/presentation/providers/supplier_controller.dart` e i provider di
composizione in `lib/app/configuration/app_providers.dart`.

La schermata espone:

- lista fornitori ordinata per `displayOrder`;
- dialog CRUD per nome, base URL, template URL, ordine, note e stato attivo;
- test template con URL generato da valori di prova;
- controlli di spostamento su/giu;
- compatibilita con i tipi dispositivo tramite checkbox.

Le operazioni passano da `SupplierUseCases`. Il salvataggio valida il template
URL prima di toccare il repository, mentre il test template genera solo un
`Uri` e non apre il browser.

## Ricerca

`/search` usa `SearchController` in
`lib/presentation/providers/search_controller.dart` e lo stato in
`lib/application/state/search_state.dart`.

La schermata espone:

- selezione tipo dispositivo;
- selezione marca;
- selezione modello filtrata per tipo e marca;
- selezione componente compatibile;
- selezione fornitori attivi e compatibili;
- query generata;
- anteprima URL per fornitore;
- conferma prima dell'apertura quando richiesta dalle impostazioni;
- apertura nel browser esterno tramite caso d'uso;
- salvataggio in cronologia quando abilitato.

Il controller orchestra casi d'uso applicativi e servizi astratti. I widget
mostrano stato e raccolgono input, ma non generano URL, non aprono il browser
e non accedono al database.

## Cronologia

`/history` usa `HistoryController` in
`lib/presentation/providers/history_controller.dart` e lo stato in
`lib/application/state/history_state.dart`.

La schermata espone:

- lista delle ricerche salvate ordinate dalla piu recente;
- dettaglio dello snapshot salvato;
- URL generati per ogni fornitore;
- ripetizione della ricerca tramite riapertura degli URL salvati;
- eliminazione della voce selezionata;
- svuotamento completo.

La ripetizione non ricostruisce le selezioni originali: usa gli URL registrati
nella cronologia, cosi' funziona anche se catalogo o fornitori sono cambiati.

## Preferiti

`/favorites` usa `FavoriteController` in
`lib/presentation/providers/favorite_controller.dart` e lo stato in
`lib/application/state/favorite_state.dart`.

La schermata espone:

- lista delle combinazioni salvate;
- builder con selezioni dipendenti di catalogo;
- selezione fornitori preferiti compatibili;
- salvataggio di una nuova combinazione;
- dettaglio del preferito selezionato;
- rilancio tramite ricostruzione della ricerca e apertura URL;
- eliminazione del preferito.

Il rilancio usa gli ID salvati e passa da `PrepareSearchUseCase`: se la
combinazione non e' piu valida, viene mostrato un errore applicativo invece di
aprire URL non coerenti.

## Impostazioni

`/settings` usa `SettingsController` in
`lib/presentation/providers/settings_controller.dart` e `AppSettings`.

La schermata espone:

- limite massimo di pagine fornitore da aprire;
- conferma prima dell'apertura;
- salvataggio cronologia attivo/disattivo;
- refresh delle impostazioni persistite.

Le modifiche passano da `AppSettingsUseCases`. I flussi di ricerca, cronologia
e preferiti leggono `AppSettings` e applicano gli stessi limiti.

## Browser Esterno

L'apertura del browser e' esposta tramite `ExternalBrowserService` in
`lib/core/services/external_browser_service.dart`. L'implementazione concreta
basata su `url_launcher` si trova in
`lib/data/services/url_launcher_external_browser_service.dart` e forza
`LaunchMode.externalApplication`.

La UI deve passare da `OpenExternalUrlUseCase` o dal contratto astratto, mai
chiamare direttamente `url_launcher`.

## Stato Della Ricerca

Ordine delle selezioni:

```text
Device type -> Brand -> Device model -> Component -> Suppliers
```

Quando cambia un valore superiore, i valori dipendenti devono essere azzerati o
rivalidati.

Esempio: se cambia il tipo di dispositivo, il modello precedente deve essere
eliminato, il componente deve essere rivalidato, i fornitori non compatibili
devono essere deselezionati e la query deve essere rigenerata.

La ricerca puo essere eseguita solo se sono presenti:

- tipo di dispositivo;
- marca;
- modello;
- componente;
- almeno un fornitore attivo e compatibile.
