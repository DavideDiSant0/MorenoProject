# Requirements Summary

## In Scope Per L'MVP

- Applicazione desktop locale.
- Supporto iniziale macOS e Windows.
- Catalogo locale di dispositivi, marche, modelli e componenti.
- Configurazione locale dei fornitori.
- Generazione locale di query e URL.
- Apertura del browser esterno tramite azione esplicita.
- Cronologia locale delle ricerche.
- Preferiti locali.
- Impostazioni locali.

## Out Of Scope

- Backend.
- Spring Boot.
- Node.js.
- Firebase.
- Servizi cloud.
- Autenticazione.
- API remote.
- Scraping.
- Automazione degli acquisti.
- Sistemi di pagamento.
- Salvataggio credenziali.
- Browser embedded.

## Vincoli Tecnici

- Flutter Desktop e Dart sono la base del progetto.
- Riverpod gestira lo stato.
- Drift con SQLite gestira la persistenza locale.
- GoRouter gestira solo la navigazione.
- url_launcher aprira il browser esterno tramite servizio astratto.
- Il dominio non deve dipendere da Flutter, Drift o dettagli infrastrutturali.

## Validazioni Future Necessarie

- La ricerca richiede tipo dispositivo, marca, modello, componente e almeno un
  fornitore attivo compatibile.
- I template URL devono contenere placeholder supportati.
- I template URL devono usare solo `http` o `https`.
- I valori mancanti non devono produrre URL incompleti.
- Gli errori tecnici devono diventare errori applicativi comprensibili.
