import 'package:drift/drift.dart' hide Component;

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';

Component componentFromRow(ComponentRow row) {
  return Component(
    id: row.id,
    name: row.name,
    description: row.description,
    isActive: row.isActive,
  );
}

ComponentsCompanion componentToCompanion(Component component) {
  return ComponentsCompanion.insert(
    id: component.id,
    name: component.name,
    description: Value(component.description),
    isActive: Value(component.isActive),
  );
}
