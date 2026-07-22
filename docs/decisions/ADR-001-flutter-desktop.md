# ADR-001 - Flutter Desktop

## Stato

Accettata.

## Contesto

Il prodotto deve essere un'applicazione desktop locale per macOS e Windows. Deve
avere UI reattiva, sviluppo rapido e possibilita di packaging futuro.

## Decisione

Usare Flutter Desktop con Dart.

## Motivazioni

Flutter permette di condividere gran parte del codice tra macOS e Windows,
offre tooling maturo, hot reload e integrazione con test e analisi statica.

## Alternative Considerate

- App nativa Swift e C#: maggiore integrazione nativa, ma duplicazione elevata.
- Electron: stack web e runtime piu pesante.
- Backend con web app: non coerente con il requisito locale dell'MVP.

## Conseguenze Positive

- Una base codice condivisa.
- Toolchain unica.
- UI desktop multipiattaforma.
- Test e linting integrati.

## Conseguenze Negative

- Alcune integrazioni desktop richiedono configurazioni specifiche per
  piattaforma.
- Packaging e firma richiederanno lavoro dedicato.

## Condizioni Di Revisione

Rivedere la decisione se Flutter Desktop non supporta requisiti critici di
distribuzione, prestazioni o integrazione nativa.
