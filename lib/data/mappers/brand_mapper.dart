import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';

Brand brandFromRow(BrandRow row) {
  return Brand(id: row.id, name: row.name, isActive: row.isActive);
}

BrandsCompanion brandToCompanion(Brand brand) {
  return BrandsCompanion.insert(
    id: brand.id,
    name: brand.name,
    isActive: Value(brand.isActive),
  );
}
