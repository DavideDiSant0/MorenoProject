# Domain Model

Questo documento descrive il modello concettuale previsto. In questa fase non
sono state create entita Dart, tabelle Drift o repository.

## DeviceType

- `id`;
- `name`;
- `description`;
- `isActive`.

Rappresenta una categoria di dispositivo, per esempio smartphone, tablet o
console.

## Brand

- `id`;
- `name`;
- `isActive`.

Rappresenta il produttore o marchio commerciale.

## DeviceModel

- `id`;
- `name`;
- `modelCode`;
- `alternativeSearchTerms`;
- `deviceTypeId`;
- `brandId`;
- `isActive`.

Rappresenta uno specifico modello ricercabile. I termini alternativi aiutano a
costruire query efficaci senza perdere le denominazioni usate dai fornitori.

## Component

- `id`;
- `name`;
- `description`;
- `isActive`.

Rappresenta il ricambio cercato.

## DeviceTypeComponent

Relazione molti-a-molti tra tipo di dispositivo e componente. Serve a proporre
solo componenti coerenti con il tipo selezionato.

## Supplier

- `id`;
- `name`;
- `baseUrl`;
- `urlTemplate`;
- `displayOrder`;
- `notes`;
- `isActive`.

Rappresenta un fornitore configurabile dall'utente.

## SupplierDeviceType

Relazione molti-a-molti tra fornitore e tipo di dispositivo. Serve a filtrare i
fornitori compatibili.

## SearchHistory

- `id`;
- `searchedAt`;
- `deviceType`;
- `brand`;
- `deviceModel`;
- `component`;
- `generatedQuery`.

Per la cronologia e' preferibile salvare snapshot testuali dei valori visibili.
Questo mantiene lo storico comprensibile anche se catalogo, modelli o fornitori
vengono modificati in seguito.

## SearchHistorySupplier

- `searchHistoryId`;
- `supplierId` oppure `supplierName` come snapshot;
- `generatedUrl`;
- `openResult` opzionale.

Il riferimento al fornitore e' utile per ripetere una ricerca. Lo snapshot del
nome evita perdita di contesto se il fornitore viene rinominato o disattivato.

## Favorite

- `id`;
- `name`;
- `deviceTypeId`;
- `brandId`;
- `deviceModelId`;
- `componentId`;
- `createdAt`.

Rappresenta una combinazione ricorrente che l'utente vuole ripetere rapidamente.

## FavoriteSupplier

Relazione molti-a-molti tra preferito e fornitore.

## AppSettings

- `maxPagesToOpen`;
- `requireConfirmation`;
- `historyEnabled`;
- eventuali altre preferenze locali.

Le impostazioni devono restare locali e non contenere dati sensibili.
