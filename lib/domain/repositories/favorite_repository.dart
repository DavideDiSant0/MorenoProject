import 'package:repair_parts_finder/domain/entities/favorite.dart';

/// Contratto di persistenza per [Favorite].
abstract interface class FavoriteRepository {
  Future<List<Favorite>> getAll();

  Future<Favorite?> getById(String id);

  Future<void> create(Favorite favorite);

  Future<void> update(Favorite favorite);

  Future<void> delete(String id);
}
