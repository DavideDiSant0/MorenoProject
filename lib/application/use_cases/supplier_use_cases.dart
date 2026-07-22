import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/domain/repositories/supplier_repository.dart';
import 'package:repair_parts_finder/domain/services/url_template_generator.dart';
import 'package:repair_parts_finder/domain/services/url_template_values.dart';

/// Casi d'uso del modulo Fornitori.
final class SupplierUseCases {
  const SupplierUseCases(
    this._repository, {
    UrlTemplateGenerator urlTemplateGenerator = const UrlTemplateGenerator(),
  }) : _urlTemplateGenerator = urlTemplateGenerator;

  final SupplierRepository _repository;
  final UrlTemplateGenerator _urlTemplateGenerator;

  Future<List<Supplier>> getSuppliers({bool activeOnly = false}) async {
    final suppliers = await _repository.getAll();
    return activeOnly
        ? suppliers.where((supplier) => supplier.isActive).toList()
        : suppliers;
  }

  Future<List<Supplier>> getCompatibleSuppliers(
    String deviceTypeId, {
    bool activeOnly = false,
  }) async {
    final suppliers = await _repository.getCompatibleWithDeviceType(
      deviceTypeId,
    );
    return activeOnly
        ? suppliers.where((supplier) => supplier.isActive).toList()
        : suppliers;
  }

  Future<List<DeviceType>> getCompatibleDeviceTypes(String supplierId) =>
      _repository.getCompatibleDeviceTypes(supplierId);

  Future<void> createSupplier(Supplier supplier) {
    _urlTemplateGenerator.validateTemplate(supplier.urlTemplate);
    return _repository.create(supplier);
  }

  Future<void> updateSupplier(Supplier supplier) {
    _urlTemplateGenerator.validateTemplate(supplier.urlTemplate);
    return _repository.update(supplier);
  }

  Future<void> deleteSupplier(String id) => _repository.delete(id);

  Future<void> addCompatibleDeviceType(String supplierId, String deviceTypeId) {
    return _repository.addCompatibleDeviceType(supplierId, deviceTypeId);
  }

  Future<void> removeCompatibleDeviceType(
    String supplierId,
    String deviceTypeId,
  ) {
    return _repository.removeCompatibleDeviceType(supplierId, deviceTypeId);
  }

  Uri testTemplate(String template, UrlTemplateValues values) {
    return _urlTemplateGenerator.generate(template, values);
  }
}
