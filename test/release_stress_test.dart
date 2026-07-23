import 'dart:math';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

void main() {
  test(
    'stress: 300 ricerche con fornitori restano ordinate e cancellabili',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final baseTime = DateTime.utc(2026);

      for (var index = 0; index < 300; index++) {
        final historyId = 'history-$index';
        await database.searchHistoryDao.insertEntry(
          SearchHistoryEntriesCompanion.insert(
            id: historyId,
            searchedAt: baseTime.add(Duration(minutes: index)),
            deviceType: 'Smartphone',
            brand: 'Brand $index',
            deviceModel: 'Model $index',
            component: 'Component $index',
            generatedQuery: 'Brand $index Model $index Component $index',
          ),
          [
            SearchHistorySuppliersCompanion.insert(
              id: 'history-supplier-$index',
              searchHistoryId: historyId,
              supplierName: 'Supplier $index',
              generatedUrl: 'https://supplier.example/search?q=$index',
            ),
          ],
        );
      }

      final entries = await database.searchHistoryDao.getAllEntries();
      expect(entries, hasLength(300));
      expect(entries.first.id, 'history-299');
      expect(entries.last.id, 'history-0');

      await database.searchHistoryDao.deleteAllEntries();
      expect(await database.searchHistoryDao.getAllEntries(), isEmpty);
      expect(
        await database.select(database.searchHistorySuppliers).get(),
        isEmpty,
      );
    },
  );

  test('stress: URL encoding resta valido su 1000 input variabili', () {
    const generator = UrlTemplateGenerator();
    const template =
        'https://supplier.example/search?q={query}&model={model}'
        '&component={component}';
    final random = Random(20260723);
    const alphabet = 'abcXYZ 0123àèìòù+-_/?#&=%{}[]()\'"\\\n\t';

    for (var iteration = 0; iteration < 1000; iteration++) {
      final value = String.fromCharCodes([
        for (var index = 0; index < 40; index++)
          alphabet.codeUnitAt(random.nextInt(alphabet.length)),
      ]);
      final uri = generator.generate(
        template,
        UrlTemplateValues(
          query: value,
          model: 'Model $iteration',
          component: 'Part &$iteration',
        ),
      );

      expect(uri.scheme, 'https');
      expect(uri.host, 'supplier.example');
      expect(uri.toString(), isNot(contains('\n')));
      expect(uri.toString(), isNot(contains('\t')));
      expect(uri.toString(), isNot(contains('{')));
      expect(uri.toString(), isNot(contains('}')));
    }
  });
}
