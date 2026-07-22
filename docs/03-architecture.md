# Architecture

Il progetto segue un'architettura a livelli con dipendenze verso l'interno.
L'obiettivo e' mantenere il codice semplice, testabile e separato per
responsabilita.

## Livelli

### Presentation

Contiene schermate, widget, controller di presentazione e provider UI. Non
contiene logica di business, query SQL o costruzione diretta degli URL dei
fornitori.

### Application

Contiene casi d'uso, stato applicativo e DTO. Coordina le operazioni richieste
dalla UI usando contratti del dominio e servizi astratti.

### Domain

Contiene entita, value object, servizi di dominio e interfacce repository. Non
dipende da Flutter, Riverpod, Drift, SQLite o url_launcher.

### Data

Contiene database Drift, tabelle, DAO, migrazioni, datasource, mapper e
implementazioni repository. E' l'unico livello che puo conoscere Drift e SQLite.

### Core

Contiene errori condivisi, costanti, utility, validazioni e servizi trasversali
astratti.

## Convenzione Cartelle

Il repository mantiene sia i livelli principali sia `features/`.

- I livelli definiscono le responsabilita tecniche.
- `features/` raggruppa la futura organizzazione funzionale.
- Quando una feature cresce, il codice puo essere collocato nella feature
  mantenendo sottocartelle coerenti con i livelli.
- Non duplicare lo stesso concetto in due punti. Se una feature contiene codice
  strutturato per livelli, documentare la scelta nel README della feature.

## Regole Di Dipendenza

- `presentation` puo dipendere da `application`, `domain` e `core`.
- `application` puo dipendere da `domain` e `core`.
- `domain` non dipende da altri livelli applicativi.
- `data` implementa contratti del dominio e puo usare librerie infrastrutturali.
- `core` deve restare piccolo e non diventare un contenitore generico.

## Regole Obbligatorie

- La UI non accede direttamente al database.
- I widget non costruiscono URL di fornitori.
- I widget non contengono logica di business.
- La logica applicativa usa casi d'uso o servizi applicativi.
- Le interfacce repository appartengono al dominio.
- Le implementazioni repository appartengono al data layer.
- Drift e SQLite restano confinati nel data layer.
- url_launcher deve essere usato attraverso un servizio astratto.
- Riverpod collega UI, casi d'uso e servizi.
- GoRouter gestisce solo navigazione.
- Gli errori tecnici devono essere convertiti in errori applicativi.
- Non devono esistere dipendenze circolari.

## Struttura Prevista

```text
lib/
  main.dart
  app/
    routing/
    theme/
    configuration/
  core/
    errors/
    constants/
    utilities/
    validation/
    services/
  domain/
    entities/
    value_objects/
    repositories/
    services/
  application/
    use_cases/
    state/
    dto/
  data/
    database/
      tables/
      daos/
      migrations/
    repositories/
    mappers/
    datasources/
  presentation/
    screens/
    widgets/
    controllers/
    providers/
  features/
    search/
    catalog/
    suppliers/
    favorites/
    history/
    settings/
```

Le cartelle vuote sono mantenute da `.gitkeep` per indicare l'architettura
prevista senza creare classi vuote.
