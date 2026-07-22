import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';

final class CatalogState {
  const CatalogState({
    required this.deviceTypes,
    required this.brands,
    required this.deviceModels,
    required this.components,
    required this.compatibleComponents,
    this.selectedCompatibilityDeviceTypeId,
  });

  final List<DeviceType> deviceTypes;
  final List<Brand> brands;
  final List<DeviceModel> deviceModels;
  final List<Component> components;
  final List<Component> compatibleComponents;
  final String? selectedCompatibilityDeviceTypeId;

  CatalogState copyWith({
    List<DeviceType>? deviceTypes,
    List<Brand>? brands,
    List<DeviceModel>? deviceModels,
    List<Component>? components,
    List<Component>? compatibleComponents,
    String? selectedCompatibilityDeviceTypeId,
  }) {
    return CatalogState(
      deviceTypes: deviceTypes ?? this.deviceTypes,
      brands: brands ?? this.brands,
      deviceModels: deviceModels ?? this.deviceModels,
      components: components ?? this.components,
      compatibleComponents: compatibleComponents ?? this.compatibleComponents,
      selectedCompatibilityDeviceTypeId:
          selectedCompatibilityDeviceTypeId ??
          this.selectedCompatibilityDeviceTypeId,
    );
  }
}
