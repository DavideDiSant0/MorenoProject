# Struttura `lib`

`domain`, `data`, `application`, `app`, `presentation` e parte di `core`
contengono codice reale. Le sottocartelle non ancora usate restano lo
scheletro iniziale, predisposte per le fasi successive e mantenute con file
`.gitkeep` finche non esiste codice reale da inserire.

## Convenzione

- `app`: composizione dell'app, routing, tema e configurazione. Implementato:
  routing GoRouter, tema base e provider applicativi condivisi.
- `core`: elementi condivisi indipendenti dalle feature. Contiene
  `errors` (gerarchia eccezioni applicative) e `validation` (invarianti
  condivise dalle entita'), `utilities` (helper puri) e `services` (contratti
  condivisi per id, tempo e browser esterno); `constants` resta scheletro.
- `domain`: modello di dominio e contratti astratti. Implementato:
  `entities`, `repositories` e `services` (generatore URL da template);
  `value_objects` resta scheletro.
- `application`: casi d'uso, DTO e stato applicativo. Implementato:
  `use_cases`, `dto` e stato catalogo/fornitori usato dalla UI Riverpod.
- `data`: persistenza locale, Drift, mapper e implementazioni repository.
  Implementato: `database` (tabelle, DAO, `app_database.dart`,
  `database_connection.dart`), `mappers`, `repositories` e `services`
  infrastrutturali come l'adapter `url_launcher`.
- `presentation`: schermate, widget, controller e provider UI. Implementato:
  shell desktop con `NavigationRail`, schermate tecniche e provider/controller
  operativi per catalogo e fornitori.
- `features`: raggruppamento funzionale futuro. *(scheletro)*

Non creare classi vuote solo per occupare cartelle. Inserire codice solo quando
serve a una funzionalita approvata.
