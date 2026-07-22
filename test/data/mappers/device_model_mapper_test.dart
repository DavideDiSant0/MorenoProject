import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/mappers/device_model_mapper.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';

void main() {
  test('decodifica i termini alternativi separati da pipe', () {
    const row = DeviceModelRow(
      id: '1',
      name: 'iPhone 12',
      alternativeSearchTerms: 'iPhone12 | A2172',
      deviceTypeId: 'dt1',
      brandId: 'b1',
      isActive: true,
    );

    final entity = deviceModelFromRow(row);

    expect(entity.alternativeSearchTerms, ['iPhone12', 'A2172']);
  });

  test('un valore nullo diventa una lista vuota', () {
    const row = DeviceModelRow(
      id: '1',
      name: 'iPhone 12',
      deviceTypeId: 'dt1',
      brandId: 'b1',
      isActive: true,
    );

    expect(deviceModelFromRow(row).alternativeSearchTerms, isEmpty);
  });

  test('una lista vuota viene codificata come nullo, non stringa vuota', () {
    final entity = DeviceModel(
      id: '1',
      name: 'iPhone 12',
      deviceTypeId: 'dt1',
      brandId: 'b1',
    );

    final companion = deviceModelToCompanion(entity);

    expect(companion.alternativeSearchTerms.value, isNull);
  });

  test('round-trip preserva i termini alternativi', () {
    final entity = DeviceModel(
      id: '1',
      name: 'iPhone 12',
      deviceTypeId: 'dt1',
      brandId: 'b1',
      alternativeSearchTerms: const ['iPhone12', 'A2172'],
    );

    final companion = deviceModelToCompanion(entity);
    final rowBack = DeviceModelRow(
      id: companion.id.value,
      name: companion.name.value,
      alternativeSearchTerms: companion.alternativeSearchTerms.value,
      deviceTypeId: companion.deviceTypeId.value,
      brandId: companion.brandId.value,
      isActive: companion.isActive.value,
    );

    expect(
      deviceModelFromRow(rowBack).alternativeSearchTerms,
      entity.alternativeSearchTerms,
    );
  });
}
