# ADR-007 - Template URL Configurabili

## Stato

Accettata.

## Contesto

I fornitori possono avere formati di ricerca diversi. Hardcodare URL nella UI
renderebbe il progetto fragile e difficile da mantenere.

## Decisione

Usare template URL configurabili con placeholder supportati e validazione
centralizzata.

## Motivazioni

I template permettono di aggiungere o modificare fornitori senza cambiare la UI.
La validazione centralizzata riduce il rischio di URL non sicuri o incompleti.

## Alternative Considerate

- URL hardcoded nella UI: semplice, ma viola separazione e manutenzione.
- Script per fornitore: potente, ma troppo rischioso e fuori scope.
- Scraping: vietato dal progetto.

## Conseguenze Positive

- Fornitori configurabili.
- Regole testabili.
- Nessun URL hardcoded nella UI.
- Migliore controllo di sicurezza.

## Conseguenze Negative

- Serve validazione accurata.
- Template errati devono essere gestiti con messaggi chiari.

## Condizioni Di Revisione

Rivedere se i fornitori richiedono integrazioni ufficiali non rappresentabili da
template URL sicuri.
