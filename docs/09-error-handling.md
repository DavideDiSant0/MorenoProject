# Error Handling

Gli errori tecnici devono essere convertiti in errori applicativi comprensibili
prima di arrivare alla UI.

## Categorie Future

- errori di validazione input;
- errori di template URL;
- errori di persistenza locale;
- errori di migrazione database;
- errori di apertura browser;
- errori di stato incoerente;
- errori inattesi.

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
- generazione URL senza apertura browser.
