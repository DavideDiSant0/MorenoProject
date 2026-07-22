import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

DeviceType deviceTypeFromRow(DeviceTypeRow row) {
  return DeviceType(
    id: row.id,
    name: row.name,
    description: row.description,
    isActive: row.isActive,
  );
}

DeviceTypesCompanion deviceTypeToCompanion(DeviceType deviceType) {
  return DeviceTypesCompanion.insert(
    id: deviceType.id,
    name: deviceType.name,
    description: Value(deviceType.description),
    isActive: Value(deviceType.isActive),
  );
}
