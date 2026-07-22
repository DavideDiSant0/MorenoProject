import 'package:repair_parts_finder/domain/entities/brand.dart';

/// Contratto di persistenza per [Brand].
abstract interface class BrandRepository {
  Future<List<Brand>> getAll();

  Future<Brand?> getById(String id);

  Future<void> create(Brand brand);

  Future<void> update(Brand brand);

  Future<void> delete(String id);
}
