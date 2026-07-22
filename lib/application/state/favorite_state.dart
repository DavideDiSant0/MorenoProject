import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

final class FavoriteState {
  const FavoriteState({
    required this.favorites,
    required this.deviceTypes,
    required this.brands,
    required this.deviceModels,
    required this.components,
    required this.suppliers,
    required this.allDeviceTypes,
    required this.allBrands,
    required this.allDeviceModels,
    required this.allComponents,
    required this.allSuppliers,
    required this.selectedSupplierIds,
    required this.settings,
    this.selectedFavoriteId,
    this.selectedDeviceTypeId,
    this.selectedBrandId,
    this.selectedDeviceModelId,
    this.selectedComponentId,
    this.lastResultMessage,
  });

  final List<Favorite> favorites;
  final List<DeviceType> deviceTypes;
  final List<Brand> brands;
  final List<DeviceModel> deviceModels;
  final List<Component> components;
  final List<Supplier> suppliers;
  final List<DeviceType> allDeviceTypes;
  final List<Brand> allBrands;
  final List<DeviceModel> allDeviceModels;
  final List<Component> allComponents;
  final List<Supplier> allSuppliers;
  final Set<String> selectedSupplierIds;
  final AppSettings settings;
  final String? selectedFavoriteId;
  final String? selectedDeviceTypeId;
  final String? selectedBrandId;
  final String? selectedDeviceModelId;
  final String? selectedComponentId;
  final String? lastResultMessage;

  Favorite? get selectedFavorite {
    for (final favorite in favorites) {
      if (favorite.id == selectedFavoriteId) {
        return favorite;
      }
    }
    return null;
  }

  bool get canSaveFavorite =>
      selectedDeviceTypeId != null &&
      selectedBrandId != null &&
      selectedDeviceModelId != null &&
      selectedComponentId != null &&
      selectedSupplierIds.isNotEmpty;
}
