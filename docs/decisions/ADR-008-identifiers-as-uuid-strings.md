# ADR-008 - Identificativi Come Stringhe UUID

## Stato

Accettata.

## Contesto

Con l'implementazione della Fase 1 (dominio e database) serviva una strategia
di identificazione per tutte le entita' e le tabelle Drift. Le alternative
concrete erano id generati dal database (interi autoincrement) oppure id
generati lato Dart prima della persistenza.

## Decisione

Tutti gli id sono stringhe UUID v4, generate lato Dart con il pacchetto
`uuid` (gia' nello stack approvato) prima che l'entita' raggiunga il
repository. Le colonne Drift corrispondenti sono `TextColumn` usate come
chiave primaria, senza autoincrement.

## Motivazioni

Un'entita' deve essere completa, id incluso, prima di attraversare il
confine verso il repository: i casi d'uso futuri (Fase 2 e successive)
possono cosi' costruire riferimenti (preferiti, cronologia, relazioni
molti-a-molti) senza un round-trip di scrittura per scoprire l'id assegnato
dal database. La dipendenza `uuid' era gia' presente nello stack approvato
proprio in previsione di questo utilizzo.

## Alternative Considerate

- Interi autoincrement: piu' compatti, ma l'id esiste solo dopo l'insert,
  complicando la costruzione di aggregati con figli (es. `SearchHistory` e i
  suoi fornitori) che devono conoscere l'id del padre prima di scrivere le
  righe collegate.
- UUID generati nel livello data anziche' nel dominio: avrebbe spostato una
  responsabilita' concettualmente di dominio (l'identita' dell'entita') nel
  livello data, in tensione con le regole architetturali.

## Conseguenze Positive

- Le entita' sono sempre complete, anche prima di essere salvate.
- Nessun round-trip necessario per conoscere l'id dopo un insert.
- Scritture transazionali di aggregati (padre piu' figli) piu' semplici.

## Conseguenze Negative

- Le chiavi primarie testuali occupano piu' spazio delle chiavi intere.
- Nessun ordinamento naturale per data di creazione basato sull'id.

## Condizioni Di Revisione

Rivedere se emergono requisiti di sincronizzazione con sistemi esterni che
richiedono un formato id diverso, o se il volume dati locale rendesse
rilevante l'overhead delle chiavi testuali.
