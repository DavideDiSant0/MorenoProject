# Navigation And UI

La navigazione e' gestita da GoRouter. Lo stato attuale include una shell
desktop tecnica con `NavigationRail` laterale e schermate minime per le sezioni
principali. Non sono ancora presenti CRUD, form definitivi o logica
applicativa nella UI.

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

## Regole UI

- I widget mostrano stato e raccolgono input.
- I widget delegano azioni a controller, provider o casi d'uso.
- I widget non costruiscono URL dei fornitori.
- I widget non aprono direttamente il browser e non importano `url_launcher`.
- I widget non eseguono query SQL.
- La UI deve gestire stati di caricamento, vuoto, errore e conferma quando il
  relativo flusso verra implementato.
- Le schermate tecniche attuali possono mostrare solo struttura e sezioni
  previste; non devono simulare dati reali.

## Browser Esterno

L'apertura del browser e' esposta tramite `ExternalBrowserService` in
`lib/core/services/external_browser_service.dart`. L'implementazione concreta
basata su `url_launcher` si trova in
`lib/data/services/url_launcher_external_browser_service.dart` e forza
`LaunchMode.externalApplication`.

La UI futura deve passare da `OpenExternalUrlUseCase` o dal contratto astratto,
mai chiamare direttamente `url_launcher`.

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
