import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/database_connection.dart';
import 'package:repair_parts_finder/data/mappers/device_type_mapper.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

void main() {
  test('apre un database su file reale e fa un round-trip', () async {
    final tempDir = await Directory.systemTemp.createTemp(
      'repair_parts_finder_test_',
    );
    addTearDown(() => tempDir.delete(recursive: true));

    final database = AppDatabase(openConnectionAt(tempDir.path));
    addTearDown(database.close);

    final deviceType = DeviceType(id: '1', name: 'Smartphone');
    await database
        .into(database.deviceTypes)
        .insert(deviceTypeToCompanion(deviceType));

    final rows = await database.select(database.deviceTypes).get();

    expect(rows, hasLength(1));
    expect(rows.single.name, 'Smartphone');
    expect(
      Directory(tempDir.path).listSync().any(
        (entry) => entry.path.endsWith('repair_parts_finder.sqlite'),
      ),
      isTrue,
    );
  });
}
