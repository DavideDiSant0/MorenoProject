import 'package:repair_parts_finder/core/errors/not_found_exception.dart';
import 'package:repair_parts_finder/core/errors/persistence_guard.dart';
import 'package:repair_parts_finder/data/database/daos/favorite_dao.dart';
import 'package:repair_parts_finder/data/mappers/favorite_mapper.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/repositories/favorite_repository.dart';

class DriftFavoriteRepository implements FavoriteRepository {
  DriftFavoriteRepository(this._dao);

  final FavoriteDao _dao;

  @override
  Future<List<Favorite>> getAll() => guardPersistence(() async {
    final rows = await _dao.getAllFavorites();
    final favorites = <Favorite>[];
    for (final row in rows) {
      final supplierIds = await _dao.getSupplierIdsForFavorite(row.id);
      favorites.add(favoriteFromRow(row, supplierIds));
    }
    return favorites;
  });

  @override
  Future<Favorite?> getById(String id) => guardPersistence(() async {
    final row = await _dao.getFavoriteById(id);
    if (row == null) {
      return null;
    }
    final supplierIds = await _dao.getSupplierIdsForFavorite(id);
    return favoriteFromRow(row, supplierIds);
  });

  @override
  Future<void> create(Favorite favorite) => guardPersistence(
    () => _dao.insertFavorite(
      favoriteToCompanion(favorite),
      favorite.id,
      favorite.supplierIds,
    ),
  );

  @override
  Future<void> update(Favorite favorite) => guardPersistence(() async {
    final replaced = await _dao.updateFavorite(
      favoriteToCompanion(favorite),
      favorite.id,
      favorite.supplierIds,
    );
    if (!replaced) {
      throw NotFoundException('Preferito non trovato: ${favorite.id}.');
    }
  });

  @override
  Future<void> delete(String id) => guardPersistence(() async {
    final deletedCount = await _dao.deleteFavorite(id);
    if (deletedCount == 0) {
      throw NotFoundException('Preferito non trovato: $id.');
    }
  });
}
