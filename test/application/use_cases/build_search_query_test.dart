import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/application/dto/prepared_search.dart';
import 'package:repair_parts_finder/application/use_cases/build_search_query.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  test('include termini alternativi distinti nella query', () {
    final prepared = buildPreparedSearch(
      alternativeSearchTerms: const ['SM-G991B', 'Galaxy S21 5G'],
    );

    expect(
      buildSearchQuery(prepared),
      'Samsung Galaxy S21 G991B SM-G991B Galaxy S21 5G Display',
    );
  });

  test('rimuove duplicati ignorando maiuscole e spazi esterni', () {
    final prepared = buildPreparedSearch(
      alternativeSearchTerms: const [' galaxy s21 ', 'g991b', 'Galaxy S21'],
    );

    expect(buildSearchQuery(prepared), 'Samsung Galaxy S21 G991B Display');
  });

  test('ignora codice e termini vuoti', () {
    final prepared = buildPreparedSearch(
      modelCode: null,
      alternativeSearchTerms: const ['', '   '],
    );

    expect(buildSearchQuery(prepared), 'Samsung Galaxy S21 Display');
  });
}

PreparedSearch buildPreparedSearch({
  String? modelCode = 'G991B',
  List<String> alternativeSearchTerms = const [],
}) {
  return PreparedSearch(
    deviceType: DeviceType(id: 'phone', name: 'Smartphone'),
    brand: Brand(id: 'samsung', name: 'Samsung'),
    deviceModel: DeviceModel(
      id: 's21',
      name: 'Galaxy S21',
      modelCode: modelCode,
      alternativeSearchTerms: alternativeSearchTerms,
      deviceTypeId: 'phone',
      brandId: 'samsung',
    ),
    component: Component(id: 'display', name: 'Display'),
    suppliers: const [],
  );
}
