# ADR-004 - Architettura A Livelli

## Stato

Accettata.

## Contesto

Il progetto avra UI, stato, regole di dominio, persistenza e integrazione con
browser esterno. Serve separazione chiara per evitare coupling e codice difficile
da testare.

## Decisione

Usare livelli `presentation`, `application`, `domain`, `data` e `core`, con
dipendenze verso l'interno e organizzazione futura per feature.

## Motivazioni

La separazione mantiene testabili regole, casi d'uso e integrazioni. Drift,
Riverpod, Flutter e url_launcher restano confinati nei livelli appropriati.

## Alternative Considerate

- Struttura piatta: rapida all'inizio, ma fragile quando crescono i moduli.
- Feature-only senza livelli: comoda, ma rischia duplicazioni di regole.
- Clean Architecture completa e rigida: solida, ma puo creare astrazioni
  premature.

## Conseguenze Positive

- Confini chiari.
- Test piu semplici.
- Meno dipendenze circolari.
- Maggiore leggibilita.

## Conseguenze Negative

- Richiede disciplina.
- Alcune cartelle restano vuote nel bootstrap.

## Condizioni Di Revisione

Rivedere se la struttura produce duplicazioni reali o ostacola feature piccole.
