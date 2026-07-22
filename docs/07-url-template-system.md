# URL Template System

Il sistema dei template URL sara responsabile della generazione sicura e
testabile degli URL dei fornitori. Non e' implementato in questa fase.

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

## Validazione

La validazione futura dovra restituire errori applicativi chiari, per esempio:

- schema non consentito;
- URL non valido;
- nessun placeholder supportato;
- placeholder sconosciuto;
- valore obbligatorio mancante;
- risultato finale non valido.

## Responsabilita

Il generatore URL appartiene al livello `application` o a un servizio di dominio
se contiene regole indipendenti dai casi d'uso. Il servizio di apertura browser
deve essere astratto in `core` o `domain` e implementato fuori dalla UI.

`url_launcher` non deve comparire nei widget.
