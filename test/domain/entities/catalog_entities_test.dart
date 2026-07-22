import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  group('DeviceType', () {
    test('costruisce con i valori forniti e isActive di default', () {
      final deviceType = DeviceType(id: '1', name: 'Smartphone');

      expect(deviceType.isActive, isTrue);
      expect(deviceType.description, isNull);
    });

    test('rifiuta un nome vuoto', () {
      expect(() => DeviceType(id: '1', name: '   '), throwsArgumentError);
    });

    test('due istanze con gli stessi valori sono uguali', () {
      final a = DeviceType(id: '1', name: 'Smartphone', description: 'd');
      final b = DeviceType(id: '1', name: 'Smartphone', description: 'd');

      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
    });

    test('copyWith sostituisce solo i campi indicati', () {
      final original = DeviceType(id: '1', name: 'Smartphone');
      final updated = original.copyWith(name: 'Tablet', isActive: false);

      expect(updated.id, '1');
      expect(updated.name, 'Tablet');
      expect(updated.isActive, isFalse);
    });
  });

  group('Brand', () {
    test('rifiuta un id vuoto', () {
      expect(() => Brand(id: '', name: 'Apple'), throwsArgumentError);
    });

    test('copyWith preserva l\'id', () {
      final brand = Brand(id: '1', name: 'Apple');
      expect(brand.copyWith(name: 'Samsung').id, '1');
    });
  });

  group('Component', () {
    test('due istanze con valori diversi non sono uguali', () {
      final a = Component(id: '1', name: 'Schermo');
      final b = Component(id: '1', name: 'Batteria');

      expect(a, isNot(equals(b)));
    });
  });

  group('DeviceModel', () {
    test('normalizza i termini alternativi in una lista immutabile', () {
      final model = DeviceModel(
        id: '1',
        name: 'iPhone 12',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        alternativeSearchTerms: const ['iPhone12', 'A2172'],
      );

      expect(model.alternativeSearchTerms, ['iPhone12', 'A2172']);
      expect(
        () => model.alternativeSearchTerms.add('x'),
        throwsUnsupportedError,
      );
    });

    test('rifiuta un deviceTypeId vuoto', () {
      expect(
        () => DeviceModel(
          id: '1',
          name: 'iPhone 12',
          deviceTypeId: '',
          brandId: 'b1',
        ),
        throwsArgumentError,
      );
    });

    test('due istanze con le stesse liste sono uguali', () {
      final a = DeviceModel(
        id: '1',
        name: 'iPhone 12',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        alternativeSearchTerms: const ['x'],
      );
      final b = DeviceModel(
        id: '1',
        name: 'iPhone 12',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        alternativeSearchTerms: const ['x'],
      );

      expect(a, equals(b));
    });
  });
}
