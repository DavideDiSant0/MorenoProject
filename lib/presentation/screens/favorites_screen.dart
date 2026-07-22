import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/state/favorite_state.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/domain/entities/favorite.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/presentation/providers/favorite_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/app_panel.dart';
import 'package:repair_parts_finder/presentation/widgets/confirm_and_run.dart';
import 'package:repair_parts_finder/presentation/widgets/date_formatting.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';
import 'package:repair_parts_finder/presentation/widgets/header_metric_chip.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteState = ref.watch(favoriteControllerProvider);

    return favoriteState.when(
      data: (state) => _FavoritesContent(state: state),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(favoriteControllerProvider),
      ),
    );
  }
}

class _FavoritesContent extends ConsumerWidget {
  const _FavoritesContent({required this.state});

  final FavoriteState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFavorite = state.selectedFavorite;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _FavoritesHeader(state: state),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 390,
                child: _FavoriteListPane(
                  state: state,
                  selectedFavoriteId: state.selectedFavoriteId,
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: ListView(
                    children: [
                      _FavoriteBuilderPane(state: state),
                      const SizedBox(height: 22),
                      selectedFavorite == null
                          ? const _EmptyFavoriteDetails()
                          : _FavoriteDetailsPane(
                              favorite: selectedFavorite,
                              state: state,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FavoritesHeader extends ConsumerWidget {
  const _FavoritesHeader({required this.state});

  final FavoriteState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 12),
      child: Row(
        children: [
          Expanded(
            child: Wrap(
              spacing: 18,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  'Favorites',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                HeaderMetricChip(
                  icon: Icons.star,
                  label: '${state.favorites.length} saved',
                ),
                HeaderMetricChip(
                  icon: Icons.storefront,
                  label: '${state.suppliers.length} compatible suppliers',
                ),
                HeaderMetricChip(
                  icon: Icons.open_in_browser,
                  label: 'max ${state.settings.maxPagesToOpen} pages',
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: () =>
                ref.read(favoriteControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _FavoriteListPane extends ConsumerWidget {
  const _FavoriteListPane({
    required this.state,
    required this.selectedFavoriteId,
  });

  final FavoriteState state;
  final String? selectedFavoriteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Saved combinations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: state.favorites.isEmpty
                ? const Center(child: Text('No favorites yet.'))
                : ListView.separated(
                    itemCount: state.favorites.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final favorite = state.favorites[index];
                      return ListTile(
                        selected: favorite.id == selectedFavoriteId,
                        onTap: () => ref
                            .read(favoriteControllerProvider.notifier)
                            .selectFavorite(favorite.id),
                        leading: const Icon(Icons.star_outline),
                        title: Text(
                          favorite.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${_nameForId(state.allBrands, favorite.brandId)}  ·  '
                          '${_nameForId(state.allDeviceModels, favorite.deviceModelId)}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _FavoriteBuilderPane extends ConsumerWidget {
  const _FavoriteBuilderPane({required this.state});

  final FavoriteState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'New favorite',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              FilledButton.icon(
                onPressed: state.canSaveFavorite
                    ? () => _showSaveFavoriteDialog(context, ref)
                    : null,
                icon: const Icon(Icons.star_border),
                label: const Text('Save'),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _SizedDropdownField(
                label: 'Device type',
                value: state.selectedDeviceTypeId,
                items: [
                  for (final item in state.deviceTypes)
                    DropdownMenuItem(value: item.id, child: Text(item.name)),
                ],
                onChanged: state.deviceTypes.isEmpty
                    ? null
                    : (value) => ref
                          .read(favoriteControllerProvider.notifier)
                          .selectDeviceType(value),
              ),
              _SizedDropdownField(
                label: 'Brand',
                value: state.selectedBrandId,
                items: [
                  for (final item in state.brands)
                    DropdownMenuItem(value: item.id, child: Text(item.name)),
                ],
                onChanged: state.brands.isEmpty
                    ? null
                    : (value) => ref
                          .read(favoriteControllerProvider.notifier)
                          .selectBrand(value),
              ),
              _SizedDropdownField(
                label: 'Model',
                value: state.selectedDeviceModelId,
                items: [
                  for (final item in state.deviceModels)
                    DropdownMenuItem(value: item.id, child: Text(item.name)),
                ],
                onChanged:
                    state.selectedDeviceTypeId == null ||
                        state.selectedBrandId == null ||
                        state.deviceModels.isEmpty
                    ? null
                    : (value) => ref
                          .read(favoriteControllerProvider.notifier)
                          .selectDeviceModel(value),
              ),
              _SizedDropdownField(
                label: 'Component',
                value: state.selectedComponentId,
                items: [
                  for (final item in state.components)
                    DropdownMenuItem(value: item.id, child: Text(item.name)),
                ],
                onChanged:
                    state.selectedDeviceTypeId == null ||
                        state.components.isEmpty
                    ? null
                    : (value) => ref
                          .read(favoriteControllerProvider.notifier)
                          .selectComponent(value),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'Preferred suppliers',
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 6),
          if (state.selectedDeviceTypeId == null)
            const Text('Select a device type first.')
          else if (state.suppliers.isEmpty)
            const Text('No active compatible suppliers.')
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final supplier in state.suppliers)
                  FilterChip(
                    selected: state.selectedSupplierIds.contains(supplier.id),
                    label: Text(supplier.name),
                    onSelected: (selected) => ref
                        .read(favoriteControllerProvider.notifier)
                        .setSupplierSelected(supplier.id, selected),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _SizedDropdownField extends StatelessWidget {
  const _SizedDropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(labelText: label),
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}

class _FavoriteDetailsPane extends ConsumerWidget {
  const _FavoriteDetailsPane({required this.favorite, required this.state});

  final Favorite favorite;
  final FavoriteState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 360,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favorite.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 6),
                  Text('Saved ${formatDateTime(favorite.createdAt)}'),
                ],
              ),
            ),
            FilledButton.icon(
              onPressed: () => _confirmLaunch(context, ref, favorite, state),
              icon: const Icon(Icons.play_arrow_outlined),
              label: const Text('Launch'),
            ),
            IconButton(
              tooltip: 'Delete',
              onPressed: () => confirmAndRun(
                context,
                title: 'Delete favorite',
                message: 'Delete ${favorite.name}?',
                action: () => _runFavoriteAction(
                  context,
                  ref,
                  () => ref
                      .read(favoriteControllerProvider.notifier)
                      .deleteFavorite(favorite.id),
                ),
              ),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _FavoriteSnapshotPanel(favorite: favorite, state: state),
        const SizedBox(height: 16),
        Text(
          'Preferred suppliers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        if (favorite.supplierIds.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Text('No suppliers saved in this favorite.'),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: favorite.supplierIds.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final supplierId = favorite.supplierIds[index];
              return ListTile(
                leading: const Icon(Icons.storefront_outlined),
                title: Text(_nameForId(state.allSuppliers, supplierId)),
                subtitle: Text(supplierId),
              );
            },
          ),
        if (state.lastResultMessage != null) ...[
          const SizedBox(height: 12),
          Text(state.lastResultMessage!),
        ],
      ],
    );
  }
}

class _FavoriteSnapshotPanel extends StatelessWidget {
  const _FavoriteSnapshotPanel({required this.favorite, required this.state});

  final Favorite favorite;
  final FavoriteState state;

  @override
  Widget build(BuildContext context) {
    final parts = [
      _nameForId(state.allDeviceTypes, favorite.deviceTypeId),
      _nameForId(state.allBrands, favorite.brandId),
      _nameForId(state.allDeviceModels, favorite.deviceModelId),
      _nameForId(state.allComponents, favorite.componentId),
    ];

    return AppPanel(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [for (final part in parts) Chip(label: Text(part))],
      ),
    );
  }
}

class _EmptyFavoriteDetails extends StatelessWidget {
  const _EmptyFavoriteDetails();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Save or select a favorite to see details.'),
    );
  }
}

Future<void> _showSaveFavoriteDialog(
  BuildContext context,
  WidgetRef ref,
) async {
  final controller = TextEditingController();
  final name = await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Save favorite'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(context).pop(controller.text),
          icon: const Icon(Icons.star_border),
          label: const Text('Save'),
        ),
      ],
    ),
  );
  if (name == null || !context.mounted) {
    return;
  }
  await _runFavoriteAction(
    context,
    ref,
    () => ref.read(favoriteControllerProvider.notifier).saveFavorite(name),
  );
}

Future<void> _confirmLaunch(
  BuildContext context,
  WidgetRef ref,
  Favorite favorite,
  FavoriteState state,
) async {
  if (state.settings.requireConfirmation) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Launch favorite'),
        content: Text('Open ${favorite.supplierIds.length} supplier pages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.play_arrow_outlined),
            label: const Text('Launch'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) {
      return;
    }
  }
  await _runFavoriteAction(
    context,
    ref,
    () => ref
        .read(favoriteControllerProvider.notifier)
        .launchFavorite(favorite.id),
  );
}

Future<void> _runFavoriteAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function() action,
) async {
  try {
    await action();
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeError(error))));
    }
  }
}

String _nameForId<T extends Object>(List<T> items, String id) {
  for (final item in items) {
    final itemId = switch (item) {
      DeviceType(:final id) => id,
      Brand(:final id) => id,
      DeviceModel(:final id) => id,
      Component(:final id) => id,
      Supplier(:final id) => id,
      _ => null,
    };
    if (itemId == id) {
      return switch (item) {
        DeviceType(:final name) => name,
        Brand(:final name) => name,
        DeviceModel(:final name) => name,
        Component(:final name) => name,
        Supplier(:final name) => name,
        _ => id,
      };
    }
  }
  return id;
}
