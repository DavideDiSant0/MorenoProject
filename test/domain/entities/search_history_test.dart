import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';

void main() {
  SearchHistorySupplier buildSupplierSnapshot({String id = 's1'}) =>
      SearchHistorySupplier(
        id: id,
        searchHistoryId: 'h1',
        supplierId: 'supplier-1',
        supplierName: 'Fornitore Uno',
        generatedUrl: 'https://example.com/search?q=schermo',
      );

  SearchHistory buildEntry({List<SearchHistorySupplier>? suppliers}) =>
      SearchHistory(
        id: 'h1',
        searchedAt: DateTime(2026, 1, 1),
        deviceType: 'Smartphone',
        brand: 'Apple',
        deviceModel: 'iPhone 12',
        component: 'Schermo',
        generatedQuery: 'iPhone 12 schermo',
        suppliers: suppliers ?? [buildSupplierSnapshot()],
      );

  test('rifiuta una voce senza alcun fornitore', () {
    expect(() => buildEntry(suppliers: []), throwsArgumentError);
  });

  test('rifiuta uno snapshot fornitore con supplierName vuoto', () {
    expect(
      () => SearchHistorySupplier(
        id: 's1',
        searchHistoryId: 'h1',
        supplierName: '   ',
        generatedUrl: 'https://example.com',
      ),
      throwsArgumentError,
    );
  });

  test('accetta supplierId nullo (fornitore eliminato in seguito)', () {
    final supplier = SearchHistorySupplier(
      id: 's1',
      searchHistoryId: 'h1',
      supplierName: 'Fornitore Uno',
      generatedUrl: 'https://example.com',
    );

    expect(supplier.supplierId, isNull);
  });

  test('la lista fornitori e\' immutabile dall\'esterno', () {
    final entry = buildEntry();
    expect(
      () => entry.suppliers.add(buildSupplierSnapshot()),
      throwsUnsupportedError,
    );
  });

  test('due voci con la stessa lista fornitori sono uguali', () {
    expect(buildEntry(), equals(buildEntry()));
  });
}
