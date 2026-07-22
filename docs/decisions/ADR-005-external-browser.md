# ADR-005 - Apertura Nel Browser Esterno

## Stato

Accettata.

## Contesto

L'app generera URL di ricerca per fornitori, ma non deve gestire login,
checkout, pagamento o sessioni.

## Decisione

Aprire le pagine nel browser esterno tramite un servizio astratto basato su
url_launcher.

## Motivazioni

Il browser esterno mantiene acquisti e autenticazione sul sito ufficiale del
fornitore. L'app resta uno strumento di preparazione e apertura della ricerca.

## Alternative Considerate

- Browser embedded: aumenterebbe responsabilita su sessioni e sicurezza.
- Automazione browser: fuori scope e rischiosa.
- Acquisto in app: vietato dall'MVP.

## Conseguenze Positive

- Meno rischio su credenziali e pagamenti.
- Separazione chiara delle responsabilita.
- Esperienza coerente con siti fornitori reali.

## Conseguenze Negative

- Meno controllo sull'esperienza dopo l'apertura.
- L'utente cambia contesto verso il browser.

## Condizioni Di Revisione

Rivedere solo se emergono requisiti approvati per integrazioni ufficiali e
sicure con fornitori.
