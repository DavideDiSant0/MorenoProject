# Navigation And UI

La navigazione futura sara gestita da GoRouter. In questa fase non sono state
create schermate applicative definitive.

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

## Regole UI

- I widget mostrano stato e raccolgono input.
- I widget delegano azioni a controller, provider o casi d'uso.
- I widget non costruiscono URL dei fornitori.
- I widget non aprono direttamente il browser.
- I widget non eseguono query SQL.
- La UI deve gestire stati di caricamento, vuoto, errore e conferma quando il
  relativo flusso verra implementato.

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
