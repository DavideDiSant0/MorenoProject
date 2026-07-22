# ADR-003 - Nessun Backend Per L'MVP

## Stato

Accettata.

## Contesto

Il progetto deve essere locale, semplice e privo di autenticazione, cloud o API
remote nella prima versione.

## Decisione

Non introdurre backend nell'MVP.

## Motivazioni

I flussi richiesti possono essere gestiti localmente. Un backend introdurrebbe
deploy, sicurezza, autenticazione e manutenzione non necessari per la fase
iniziale.

## Alternative Considerate

- Backend REST: flessibile, ma eccessivo per il requisito attuale.
- Firebase: rapido, ma cloud e non richiesto.
- Sincronizzazione remota: utile in futuro, fuori scope ora.

## Conseguenze Positive

- Minore complessita.
- Nessuna gestione credenziali server.
- Maggiore controllo dei dati locali.
- Setup piu rapido.

## Conseguenze Negative

- Nessuna sincronizzazione tra dispositivi.
- Backup inizialmente manuale o locale.

## Condizioni Di Revisione

Rivedere se serviranno collaborazione multiutente, sincronizzazione, backup
cloud o cataloghi condivisi.
