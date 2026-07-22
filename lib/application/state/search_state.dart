import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';

final class SearchState {
  const SearchState({
    required this.deviceTypes,
    required this.brands,
    required this.deviceModels,
    required this.components,
    required this.suppliers,
    required this.selectedSupplierIds,
    required this.previewItems,
    required this.settings,
    this.selectedDeviceTypeId,
    this.selectedBrandId,
    this.selectedDeviceModelId,
    this.selectedComponentId,
    this.generatedQuery,
    this.lastResultMessage,
  });

  final List<DeviceType> deviceTypes;
  final List<Brand> brands;
  final List<DeviceModel> deviceModels;
  final List<Component> components;
  final List<Supplier> suppliers;
  final Set<String> selectedSupplierIds;
  final List<SearchPreviewItem> previewItems;
  final AppSettings settings;
  final String? selectedDeviceTypeId;
  final String? selectedBrandId;
  final String? selectedDeviceModelId;
  final String? selectedComponentId;
  final String? generatedQuery;
  final String? lastResultMessage;

  bool get hasCompleteSelection =>
      selectedDeviceTypeId != null &&
      selectedBrandId != null &&
      selectedDeviceModelId != null &&
      selectedComponentId != null &&
      selectedSupplierIds.isNotEmpty;

  bool get hasPreview => previewItems.isNotEmpty;

  SearchState copyWith({
    List<SearchPreviewItem>? previewItems,
    String? generatedQuery,
    String? lastResultMessage,
  }) {
    return SearchState(
      deviceTypes: deviceTypes,
      brands: brands,
      deviceModels: deviceModels,
      components: components,
      suppliers: suppliers,
      selectedSupplierIds: selectedSupplierIds,
      previewItems: previewItems ?? this.previewItems,
      settings: settings,
      selectedDeviceTypeId: selectedDeviceTypeId,
      selectedBrandId: selectedBrandId,
      selectedDeviceModelId: selectedDeviceModelId,
      selectedComponentId: selectedComponentId,
      generatedQuery: generatedQuery ?? this.generatedQuery,
      lastResultMessage: lastResultMessage ?? this.lastResultMessage,
    );
  }
}

final class SearchPreviewItem {
  const SearchPreviewItem({
    required this.supplierId,
    required this.supplierName,
    required this.url,
    this.openResult,
  });

  final String supplierId;
  final String supplierName;
  final Uri url;
  final String? openResult;

  SearchPreviewItem copyWith({String? openResult}) {
    return SearchPreviewItem(
      supplierId: supplierId,
      supplierName: supplierName,
      url: url,
      openResult: openResult ?? this.openResult,
    );
  }
}
