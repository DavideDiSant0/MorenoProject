import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

void main() {
  Supplier buildSupplier({int displayOrder = 0}) => Supplier(
    id: '1',
    name: 'Fornitore Uno',
    baseUrl: 'https://example.com',
    urlTemplate: 'https://example.com/search?q={query}',
    displayOrder: displayOrder,
  );

  test('applica i valori di default', () {
    final supplier = buildSupplier();
    expect(supplier.isActive, isTrue);
    expect(supplier.notes, isNull);
    expect(supplier.displayOrder, 0);
  });

  test('rifiuta un baseUrl vuoto', () {
    expect(
      () => Supplier(
        id: '1',
        name: 'Fornitore',
        baseUrl: '   ',
        urlTemplate: 'https://example.com/{query}',
      ),
      throwsArgumentError,
    );
  });

  test('rifiuta un urlTemplate vuoto', () {
    expect(
      () => Supplier(
        id: '1',
        name: 'Fornitore',
        baseUrl: 'https://example.com',
        urlTemplate: '',
      ),
      throwsArgumentError,
    );
  });

  test('copyWith aggiorna displayOrder mantenendo il resto', () {
    final original = buildSupplier(displayOrder: 1);
    final updated = original.copyWith(displayOrder: 5);

    expect(updated.displayOrder, 5);
    expect(updated.name, original.name);
    expect(updated.urlTemplate, original.urlTemplate);
  });

  test('due fornitori con gli stessi valori sono uguali', () {
    expect(buildSupplier(), equals(buildSupplier()));
  });
}
