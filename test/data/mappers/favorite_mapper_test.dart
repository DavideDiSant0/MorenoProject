import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/favorite_mapper.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';

void main() {
  test('combina la riga con gli id fornitore forniti separatamente', () {
    final row = FavoriteRow(
      id: '1',
      name: 'iPhone 12 schermo',
      deviceTypeId: 'dt1',
      brandId: 'b1',
      deviceModelId: 'm1',
      componentId: 'c1',
      createdAt: DateTime(2026, 1, 1),
    );

    final entity = favoriteFromRow(row, ['s1', 's2']);

    expect(entity.supplierIds, ['s1', 's2']);
  });

  test('la companion non include i fornitori (gestiti a parte)', () {
    final entity = Favorite(
      id: '1',
      name: 'iPhone 12 schermo',
      deviceTypeId: 'dt1',
      brandId: 'b1',
      deviceModelId: 'm1',
      componentId: 'c1',
      createdAt: DateTime(2026, 1, 1),
      supplierIds: const ['s1'],
    );

    final companion = favoriteToCompanion(entity);

    expect(companion.id.value, '1');
    expect(companion.componentId.value, 'c1');
  });
}
