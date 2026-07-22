import 'package:repair_parts_finder/application/dto/create_favorite_command.dart';
import 'package:repair_parts_finder/core/services/date_time_provider.dart';
import 'package:repair_parts_finder/core/services/id_generator.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/repositories/favorite_repository.dart';

/// Casi d'uso del modulo Preferiti.
final class FavoriteUseCases {
  const FavoriteUseCases({
    required FavoriteRepository repository,
    required IdGenerator idGenerator,
    required DateTimeProvider dateTimeProvider,
  }) : _repository = repository,
       _idGenerator = idGenerator,
       _dateTimeProvider = dateTimeProvider;

  final FavoriteRepository _repository;
  final IdGenerator _idGenerator;
  final DateTimeProvider _dateTimeProvider;

  Future<List<Favorite>> getFavorites() => _repository.getAll();

  Future<Favorite?> getFavorite(String id) => _repository.getById(id);

  Future<Favorite> createFavorite(CreateFavoriteCommand command) async {
    final favorite = Favorite(
      id: _idGenerator.nextId(),
      name: command.name,
      deviceTypeId: command.deviceTypeId,
      brandId: command.brandId,
      deviceModelId: command.deviceModelId,
      componentId: command.componentId,
      createdAt: command.createdAt ?? _dateTimeProvider.now(),
      supplierIds: command.supplierIds,
    );
    await _repository.create(favorite);
    return favorite;
  }

  Future<void> updateFavorite(Favorite favorite) =>
      _repository.update(favorite);

  Future<void> deleteFavorite(String id) => _repository.delete(id);
}
