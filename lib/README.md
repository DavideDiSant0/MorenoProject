# Struttura `lib`

Questa cartella contiene solo lo scheletro iniziale del progetto Flutter.
Le sottocartelle sono predisposte per le fasi successive e sono mantenute con
file `.gitkeep` finche non esiste codice reale da inserire.

## Convenzione

- `app`: composizione dell'app, routing, tema e configurazione.
- `core`: elementi condivisi indipendenti dalle feature.
- `domain`: modello di dominio e contratti astratti.
- `application`: casi d'uso, DTO e stato applicativo.
- `data`: persistenza locale, Drift, mapper e implementazioni repository.
- `presentation`: schermate, widget, controller e provider UI.
- `features`: raggruppamento funzionale futuro.

Non creare classi vuote solo per occupare cartelle. Inserire codice solo quando
serve a una funzionalita approvata.
