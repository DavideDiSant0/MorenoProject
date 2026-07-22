# ADR-006 - Riverpod

## Stato

Accettata.

## Contesto

L'app avra stato di ricerca dipendente, caricamento dati locali, preferiti,
cronologia e impostazioni.

## Decisione

Usare Riverpod per collegare UI, stato applicativo, casi d'uso e servizi.

## Motivazioni

Riverpod offre dependency injection, provider testabili, buona composizione e
gestione esplicita delle dipendenze senza accedere a stato globale non
controllato.

## Alternative Considerate

- setState: sufficiente solo per esempi piccoli.
- Provider classico: valido, ma meno flessibile per injection e test.
- BLoC: solido, ma piu verboso per l'MVP.

## Conseguenze Positive

- Stato testabile.
- Dipendenze dichiarate.
- Integrazione naturale con Flutter.
- Buon supporto per stati asincroni futuri.

## Conseguenze Negative

- Richiede convenzioni chiare per evitare provider troppo grandi.
- Va evitato l'uso di provider come sostituti del dominio.

## Condizioni Di Revisione

Rivedere se la complessita dello stato richiede un pattern piu specifico o se
Riverpod diventa fonte di coupling improprio.
