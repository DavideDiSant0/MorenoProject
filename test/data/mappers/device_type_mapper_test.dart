import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/device_type_mapper.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  test('converte una riga in entita\' di dominio', () {
    const row = DeviceTypeRow(
      id: '1',
      name: 'Smartphone',
      description: 'Dispositivi mobili',
      isActive: true,
    );

    final entity = deviceTypeFromRow(row);

    expect(entity.id, '1');
    expect(entity.name, 'Smartphone');
    expect(entity.description, 'Dispositivi mobili');
    expect(entity.isActive, isTrue);
  });

  test('converte un\'entita\' in companion preservando i valori nulli', () {
    final entity = DeviceType(id: '1', name: 'Smartphone', isActive: false);

    final companion = deviceTypeToCompanion(entity);

    expect(companion.id.value, '1');
    expect(companion.name.value, 'Smartphone');
    expect(companion.description.value, isNull);
    expect(companion.isActive.value, isFalse);
  });
}
