# Struttura `lib`

`domain`, `data`, `application` e parte di `core` contengono codice reale.
Le altre sottocartelle restano lo scheletro iniziale, predisposte per le fasi
successive e mantenute con file `.gitkeep` finche non esiste codice reale da
inserire.

## Convenzione

- `app`: composizione dell'app, routing, tema e configurazione. *(scheletro)*
- `core`: elementi condivisi indipendenti dalle feature. Contiene
  `errors` (gerarchia eccezioni applicative) e `validation` (invarianti
  condivise dalle entita'), `utilities` (helper puri) e `services` (contratti
  condivisi per id e tempo); `constants` resta scheletro.
- `domain`: modello di dominio e contratti astratti. Implementato:
  `entities`, `repositories` e `services` (generatore URL da template);
  `value_objects` resta scheletro.
- `application`: casi d'uso, DTO e stato applicativo. Implementato:
  `use_cases` e `dto`; `state` resta scheletro finche non esiste integrazione
  Riverpod/UI.
- `data`: persistenza locale, Drift, mapper e implementazioni repository.
  Implementato: `database` (tabelle, DAO, `app_database.dart`,
  `database_connection.dart`), `mappers`, `repositories`.
- `presentation`: schermate, widget, controller e provider UI. *(scheletro)*
- `features`: raggruppamento funzionale futuro. *(scheletro)*

Non creare classi vuote solo per occupare cartelle. Inserire codice solo quando
serve a una funzionalita approvata.
