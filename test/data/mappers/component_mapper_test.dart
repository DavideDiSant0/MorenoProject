import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/component_mapper.dart';
import 'package:repair_parts_finder/domain/entities/component.dart' as domain;

void main() {
  test('converte una riga in entita\' di dominio', () {
    const row = ComponentRow(id: '1', name: 'Schermo', isActive: true);

    final entity = componentFromRow(row);

    expect(entity.id, '1');
    expect(entity.name, 'Schermo');
    expect(entity.description, isNull);
  });

  test('converte un\'entita\' in companion', () {
    final entity = domain.Component(
      id: '1',
      name: 'Schermo',
      description: 'Schermo OLED',
    );

    final companion = componentToCompanion(entity);

    expect(companion.description.value, 'Schermo OLED');
  });
}
