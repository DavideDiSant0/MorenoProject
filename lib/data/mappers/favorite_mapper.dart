import 'package:repair_parts_finder/data/database/app_database.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';

Favorite favoriteFromRow(FavoriteRow row, List<String> supplierIds) {
  return Favorite(
    id: row.id,
    name: row.name,
    deviceTypeId: row.deviceTypeId,
    brandId: row.brandId,
    deviceModelId: row.deviceModelId,
    componentId: row.componentId,
    createdAt: row.createdAt,
    supplierIds: supplierIds,
  );
}

FavoritesCompanion favoriteToCompanion(Favorite favorite) {
  return FavoritesCompanion.insert(
    id: favorite.id,
    name: favorite.name,
    deviceTypeId: favorite.deviceTypeId,
    brandId: favorite.brandId,
    deviceModelId: favorite.deviceModelId,
    componentId: favorite.componentId,
    createdAt: favorite.createdAt,
  );
}
