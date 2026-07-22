import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

/// Risultato della preparazione di una ricerca: contiene solo entita' valide,
/// attive e compatibili tra loro.
final class PreparedSearch {
  PreparedSearch({
    required this.deviceType,
    required this.brand,
    required this.deviceModel,
    required this.component,
    required List<Supplier> suppliers,
  }) : suppliers = List.unmodifiable(suppliers);

  final DeviceType deviceType;
  final Brand brand;
  final DeviceModel deviceModel;
  final Component component;
  final List<Supplier> suppliers;
}
