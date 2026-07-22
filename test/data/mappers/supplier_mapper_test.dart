import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/supplier_mapper.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

void main() {
  test('converte una riga in entita\' di dominio', () {
    const row = SupplierRow(
      id: '1',
      name: 'Fornitore Uno',
      baseUrl: 'https://example.com',
      urlTemplate: 'https://example.com/search?q={query}',
      displayOrder: 2,
      isActive: true,
    );

    final entity = supplierFromRow(row);

    expect(entity.displayOrder, 2);
    expect(entity.notes, isNull);
  });

  test('converte un\'entita\' in companion preservando le note', () {
    final entity = Supplier(
      id: '1',
      name: 'Fornitore Uno',
      baseUrl: 'https://example.com',
      urlTemplate: 'https://example.com/search?q={query}',
      notes: 'Spedizione rapida',
    );

    final companion = supplierToCompanion(entity);

    expect(companion.notes.value, 'Spedizione rapida');
    expect(companion.displayOrder.value, 0);
  });
}
