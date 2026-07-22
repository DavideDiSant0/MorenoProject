# Security And Privacy

L'applicazione e' progettata come strumento desktop locale senza backend nella
prima versione.

## Decisioni

- Nessuna password salvata.
- Nessun dato di pagamento salvato.
- Nessuna automazione del checkout.
- Nessun login automatico.
- Acquisto sempre completato sul sito ufficiale del fornitore.
- Apertura browser solo dopo conferma o azione esplicita dell'utente.
- URL consentiti solo con schema `http` o `https`.
- Nessuna esecuzione di comandi di sistema derivati da input utente.
- Database locale non destinato a contenere dati sensibili.
- Gestione controllata degli errori.
- Nessun tracciamento o telemetria nella prima versione.

## Input Non Affidabili

I template URL e i dati configurati dall'utente devono essere considerati input
non affidabili. Devono essere validati prima dell'uso e non devono mai produrre
esecuzione di codice o comandi locali.

## Browser Esterno

Il browser esterno riduce la responsabilita dell'app: login, carrello,
pagamento e conferma ordine restano sul sito del fornitore.

## Dati Locali

Il database locale dovra contenere catalogo, impostazioni, cronologia e
preferiti. Non dovra contenere password, token, carte, dati bancari o sessioni
utente.
