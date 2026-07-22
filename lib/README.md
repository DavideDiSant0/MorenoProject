# Struttura `lib`

`domain` e `data` contengono codice reale (Fase 1: dominio e database). Le
altre sottocartelle restano lo scheletro iniziale, predisposte per le fasi
successive e mantenute con file `.gitkeep` finche non esiste codice reale da
inserire.

## Convenzione

- `app`: composizione dell'app, routing, tema e configurazione. *(scheletro)*
- `core`: elementi condivisi indipendenti dalle feature. Contiene
  `errors` (gerarchia eccezioni applicative) e `validation` (invarianti
  condivise dalle entita'); `constants/services/utilities` restano scheletro.
- `domain`: modello di dominio e contratti astratti. Implementato:
  `entities` e `repositories`; `services` e `value_objects` restano
  scheletro (nessun value object e' risultato motivato in Fase 1).
- `application`: casi d'uso, DTO e stato applicativo. *(scheletro)*
- `data`: persistenza locale, Drift, mapper e implementazioni repository.
  Implementato: `database` (tabelle, DAO, `app_database.dart`,
  `database_connection.dart`), `mappers`, `repositories`.
- `presentation`: schermate, widget, controller e provider UI. *(scheletro)*
- `features`: raggruppamento funzionale futuro. *(scheletro)*

Non creare classi vuote solo per occupare cartelle. Inserire codice solo quando
serve a una funzionalita approvata.
