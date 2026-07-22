import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/catalog_dao.dart';
import 'package:repair_parts_finder/data/mappers/brand_mapper.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/repositories/brand_repository.dart';

class DriftBrandRepository implements BrandRepository {
  DriftBrandRepository(this._dao);

  final CatalogDao _dao;

  @override
  Future<List<Brand>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllBrands();
    return rows.map(brandFromRow).toList();
  });

  @override
  Future<Brand?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getBrandById(id);
    return row == null ? null : brandFromRow(row);
  });

  @override
  Future<void> create(Brand brand) =>
      guardPersistence(() => _dao.insertBrand(brandToCompanion(brand)));

  @override
  Future<void> update(Brand brand) => guardPersistence(() async {
    final replaced = await _dao.updateBrand(brandToCompanion(brand));
    if (!replaced) {
      throw NotFoundException('Marca non trovata: ${brand.id}.');
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteBrand(id);
    if (deletedCount == 0) {
      throw NotFoundException('Marca non trovata: $id.');
    }
  });
}
