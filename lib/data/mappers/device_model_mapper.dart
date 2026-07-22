import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';

const _alternativeSearchTermsSeparator = '|';

DeviceModel deviceModelFromRow(DeviceModelRow row) {
  return DeviceModel(
    id: row.id,
    name: row.name,
    modelCode: row.modelCode,
    alternativeSearchTerms: _decodeAlternativeSearchTerms(
      row.alternativeSearchTerms,
    ),
    deviceTypeId: row.deviceTypeId,
    brandId: row.brandId,
    isActive: row.isActive,
  );
}

DeviceModelsCompanion deviceModelToCompanion(DeviceModel deviceModel) {
  return DeviceModelsCompanion.insert(
    id: deviceModel.id,
    name: deviceModel.name,
    modelCode: Value(deviceModel.modelCode),
    alternativeSearchTerms: Value(
      _encodeAlternativeSearchTerms(deviceModel.alternativeSearchTerms),
    ),
    deviceTypeId: deviceModel.deviceTypeId,
    brandId: deviceModel.brandId,
    isActive: Value(deviceModel.isActive),
  );
}

List<String> _decodeAlternativeSearchTerms(String? raw) {
  if (raw == null || raw.isEmpty) {
    return const [];
  }
  return raw
      .split(_alternativeSearchTermsSeparator)
      .map((term) => term.trim())
      .where((term) => term.isNotEmpty)
      .toList();
}

String? _encodeAlternativeSearchTerms(List<String> terms) {
  if (terms.isEmpty) {
    return null;
  }
  return terms.join(_alternativeSearchTermsSeparator);
}
