import 'package:flutter_test/flutter_test.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';

void main() {
  Favorite buildFavorite({List<String>? supplierIds}) => Favorite(
    id: '1',
    name: 'iPhone 12 schermo',
    deviceTypeId: 'dt1',
    brandId: 'b1',
    deviceModelId: 'm1',
    componentId: 'c1',
    createdAt: DateTime(2026, 1, 1),
    supplierIds: supplierIds ?? const ['s1', 's2'],
  );

  test('puo\' esistere senza fornitori associati', () {
    final favorite = buildFavorite(supplierIds: const []);
    expect(favorite.supplierIds, isEmpty);
  });

  test('rifiuta un componentId vuoto', () {
    expect(
      () => Favorite(
        id: '1',
        name: 'x',
        deviceTypeId: 'dt1',
        brandId: 'b1',
        deviceModelId: 'm1',
        componentId: '',
        createdAt: DateTime(2026, 1, 1),
      ),
      throwsArgumentError,
    );
  });

  test('copyWith sostituisce i fornitori mantenendo il resto', () {
    final original = buildFavorite();
    final updated = original.copyWith(supplierIds: const ['s3']);

    expect(updated.supplierIds, ['s3']);
    expect(updated.deviceModelId, original.deviceModelId);
  });

  test('due preferiti con gli stessi fornitori sono uguali', () {
    expect(buildFavorite(), equals(buildFavorite()));
  });
}
