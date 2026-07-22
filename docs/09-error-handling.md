# Error Handling

Gli errori tecnici devono essere convertiti in errori applicativi comprensibili
prima di arrivare alla UI.

## Categorie Future

- errori di validazione input;
- errori di template URL;
- errori di persistenza locale (implementato: vedi sotto);
- errori di migrazione database;
- errori di apertura browser (implementato: vedi sotto);
- errori di stato incoerente;
- errori inattesi.

## Implementato: Errori Di Persistenza

`lib/core/errors` definisce una gerarchia minima: `AppException` (base,
`abstract base class` per restare estendibile da altri file pur non essendo
un'interfaccia pubblica arbitraria), `PersistenceException` e
`NotFoundException`. L'helper `guardPersistence` (in
`lib/core/errors/persistence_guard.dart`) converte qualunque eccezione
tecnica imprevista (es. `SqliteException`) in `PersistenceException`,
lasciando passare le `AppException` gia' tipizzate. I repository Drift in
`lib/data/repositories` sono l'unico punto che applica questa conversione; i
DAO possono lasciar propagare eccezioni Drift grezze. Non esiste ancora una
`ConstraintViolationException` dedicata: distinguere "nome duplicato" da
"riferimento ancora in uso" richiede di ispezionare i dettagli della
`SqliteException`, rimandato a quando un caso d'uso reale lo richieda.

## Implementato: Errori Browser Esterno

`BrowserLaunchException` rappresenta il fallimento dell'apertura del browser
esterno. `UrlLauncherExternalBrowserService` converte esiti `false` o eccezioni
tecniche di `url_launcher` in questo errore applicativo. URL con schema non
consentito o host assente vengono rifiutati con `ValidationException` prima di
chiamare `url_launcher`.

## Implementato: Errori Ricerca

La ricerca usa `ValidationException` per selezioni incomplete, componenti non
compatibili, fornitori non attivi o non compatibili e superamento del limite
massimo di pagine da aprire. Durante l'apertura multipla, il risultato di ogni
fornitore viene conservato per la cronologia; un fallimento di apertura viene
registrato come risultato del singolo URL senza accedere direttamente al
browser dalla UI.

## Regole

- Non mostrare messaggi tecnici grezzi all'utente finale.
- Non ingoiare errori in silenzio.
- Non usare `print` come gestione errori.
- Mappare eccezioni infrastrutturali in errori applicativi.
- Conservare dettagli tecnici solo dove utili per diagnosi locale e non
  sensibili.
- I casi d'uso devono dichiarare gli errori attesi.

## Esempi Di Messaggi Applicativi

- "Il template del fornitore non e' valido."
- "Manca un valore necessario per generare l'URL."
- "Non e' stato possibile aprire il browser."
- "La cronologia locale non e' disponibile."

## Test

Quando i moduli verranno implementati, i test dovranno coprire almeno:

- validazioni positive e negative;
- conversione degli errori tecnici;
- stato dipendente della ricerca;
- migrazioni database rilevanti;
- generazione URL senza apertura browser;
- apertura browser tramite servizio finto, senza avviare davvero il browser.
