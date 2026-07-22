import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/search_history_mapper.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';

void main() {
  test('combina la riga principale con le righe fornitore', () {
    final row = SearchHistoryRow(
      id: 'h1',
      searchedAt: DateTime(2026, 1, 1),
      deviceType: 'Smartphone',
      brand: 'Apple',
      deviceModel: 'iPhone 12',
      component: 'Schermo',
      generatedQuery: 'iPhone 12 schermo',
    );
    const supplierRow = SearchHistorySupplierRow(
      id: 's1',
      searchHistoryId: 'h1',
      supplierId: 'supplier-1',
      supplierName: 'Fornitore Uno',
      generatedUrl: 'https://example.com/search?q=schermo',
    );

    final entity = searchHistoryFromRow(row, [supplierRow]);

    expect(entity.suppliers, hasLength(1));
    expect(entity.suppliers.single.supplierName, 'Fornitore Uno');
  });

  test('produce companion coerenti per la voce e i fornitori', () {
    final entry = SearchHistory(
      id: 'h1',
      searchedAt: DateTime(2026, 1, 1),
      deviceType: 'Smartphone',
      brand: 'Apple',
      deviceModel: 'iPhone 12',
      component: 'Schermo',
      generatedQuery: 'iPhone 12 schermo',
      suppliers: [
        SearchHistorySupplier(
          id: 's1',
          searchHistoryId: 'h1',
          supplierName: 'Fornitore Uno',
          generatedUrl: 'https://example.com',
        ),
      ],
    );

    final entryCompanion = searchHistoryToCompanion(entry);
    final supplierCompanions = searchHistorySuppliersToCompanions(entry);

    expect(entryCompanion.id.value, 'h1');
    expect(supplierCompanions, hasLength(1));
    expect(supplierCompanions.single.searchHistoryId.value, 'h1');
    expect(supplierCompanions.single.supplierId.value, isNull);
  });
}
