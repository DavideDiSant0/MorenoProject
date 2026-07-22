# URL Template System

Il sistema dei template URL e' responsabile della generazione sicura e
testabile degli URL dei fornitori. E' implementato come servizio di dominio
puro in `lib/domain/services/url_template_generator.dart`: non apre il browser,
non dipende dalla UI e non conosce `url_launcher`.

## Placeholder Supportati

- `{query}`;
- `{deviceType}`;
- `{brand}`;
- `{model}`;
- `{modelCode}`;
- `{component}`.

## Esempi

```text
https://supplier.example/search?q={query}
https://supplier.example/search?brand={brand}&model={model}&part={component}
```

## Regole

- Il template deve essere un URL HTTP o HTTPS valido.
- Il template deve contenere almeno un placeholder supportato.
- I valori devono essere codificati correttamente per gli URL.
- I placeholder sconosciuti devono produrre un errore di validazione.
- Gli spazi inutili devono essere rimossi.
- Valori mancanti non devono produrre URL incompleti in silenzio.
- L'apertura avviene solo dopo un'azione esplicita dell'utente.
- Gli URL configurati sono input non affidabili.
- Schemi come `file:`, `javascript:` o comandi locali non sono ammessi.
- Il generatore URL deve essere indipendente dalla UI.
- Il generatore URL deve essere indipendente dal browser service.
- Deve essere possibile testare la generazione senza aprire il browser.

## Implementazione

File principali:

- `url_template_placeholder.dart`: definisce i placeholder centralizzati.
- `url_template_values.dart`: raccoglie i valori disponibili per la
  sostituzione.
- `url_template_generator.dart`: valida template e genera l'URL finale.
- `SupplierUseCases.testTemplate`: usa il generatore per provare un template
  fornitore senza aprire il browser.
- `SearchController.generatePreview`: usa il generatore con i dati della
  ricerca preparata per produrre l'anteprima URL.

Il generatore:

- rimuove spazi esterni dal template e dai valori;
- sostituisce tutte le occorrenze dei placeholder supportati;
- usa `Uri.encodeComponent` sui valori;
- rifiuta placeholder sconosciuti o malformati;
- rifiuta template senza placeholder supportati;
- rifiuta schemi diversi da `http` e `https`;
- rifiuta valori mancanti o vuoti per placeholder usati;
- restituisce un `Uri` gia' validato.

## Validazione

La validazione restituisce errori applicativi chiari tramite
`ValidationException`, per esempio:

- schema non consentito;
- URL non valido;
- nessun placeholder supportato;
- placeholder sconosciuto;
- valore obbligatorio mancante;
- risultato finale non valido.

## Responsabilita

Il generatore URL appartiene al livello `domain/services` perche contiene regole
indipendenti da casi d'uso specifici, UI e browser service. Il servizio di
apertura browser deve essere astratto in `core` o `domain` e implementato fuori
dalla UI.

`url_launcher` non deve comparire nei widget.

## Test

I test unitari sono in
`test/domain/services/url_template_generator_test.dart` e coprono:

- generazione con uno o piu placeholder;
- URL encoding;
- trim di template e valori;
- valori mancanti;
- placeholder sconosciuti o malformati;
- blocco di `file:` e `javascript:`;
- URL relativi, host assente e spazi grezzi.
