import 'package:drift/drift.dart';

import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/data/database/tables/favorite_suppliers_table.dart';
import 'package:repair_parts_finder/data/database/tables/favorites_table.dart';

part 'favorite_dao.g.dart';

/// Raggruppa l'accesso ai dati del modulo Preferiti (`docs/04-modules.md`).
@DriftAccessor(tables: [Favorites, FavoriteSuppliers])
class FavoriteDao extends DatabaseAccessor<AppDatabase>
    with _$FavoriteDaoMixin {
  FavoriteDao(super.db);

  Future<List<FavoriteRow>> getAllFavorites() => select(favorites).get();

  Future<FavoriteRow?> getFavoriteById(String id) =>
      (select(favorites)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<String>> getSupplierIdsForFavorite(String favoriteId) async {
    final rows = await (select(
      favoriteSuppliers,
    )..where((t) => t.favoriteId.equals(favoriteId))).get();
    return rows.map((row) => row.supplierId).toList();
  }

  Future<void> insertFavorite(
    FavoritesCompanion entry,
    String favoriteId,
    List<String> supplierIds,
  ) => transaction(() async {
    await into(favorites).insert(entry);
    for (final supplierId in supplierIds) {
      await into(favoriteSuppliers).insert(
        FavoriteSuppliersCompanion.insert(
          favoriteId: favoriteId,
          supplierId: supplierId,
        ),
      );
    }
  });

  Future<bool> updateFavorite(
    FavoritesCompanion entry,
    String favoriteId,
    List<String> supplierIds,
  ) => transaction(() async {
    final replaced = await update(favorites).replace(entry);
    if (replaced) {
      await (delete(
        favoriteSuppliers,
      )..where((t) => t.favoriteId.equals(favoriteId))).go();
      for (final supplierId in supplierIds) {
        await into(favoriteSuppliers).insert(
          FavoriteSuppliersCompanion.insert(
            favoriteId: favoriteId,
            supplierId: supplierId,
          ),
        );
      }
    }
    return replaced;
  });

  Future<int> deleteFavorite(String id) =>
      (delete(favorites)..where((t) => t.id.equals(id))).go();
}
