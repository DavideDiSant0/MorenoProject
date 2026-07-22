import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/brand_mapper.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';

void main() {
  test('converte una riga in entita\' di dominio', () {
    const row = BrandRow(id: '1', name: 'Apple', isActive: true);

    final entity = brandFromRow(row);

    expect(entity.id, '1');
    expect(entity.name, 'Apple');
    expect(entity.isActive, isTrue);
  });

  test('converte un\'entita\' in companion', () {
    final entity = Brand(id: '1', name: 'Apple', isActive: false);

    final companion = brandToCompanion(entity);

    expect(companion.id.value, '1');
    expect(companion.name.value, 'Apple');
    expect(companion.isActive.value, isFalse);
  });
}
