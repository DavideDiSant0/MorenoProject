import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/state/search_state.dart';
import 'package:repair_parts_finder/presentation/providers/search_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/app_panel.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';
import 'package:repair_parts_finder/presentation/widgets/header_metric_chip.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchControllerProvider);

    return searchState.when(
      data: (state) => _SearchContent(state: state),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(searchControllerProvider),
      ),
    );
  }
}

class _SearchContent extends ConsumerWidget {
  const _SearchContent({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final body = _SearchBody(state: state);

        if (constraints.maxHeight < 420) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              _SearchHeader(state: state),
              SizedBox(height: 1080, child: body),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _SearchHeader(state: state),
            Expanded(child: body),
          ],
        );
      },
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              SizedBox(height: 520, child: _SelectionPane(state: state)),
              const Divider(height: 1),
              SizedBox(height: 540, child: _PreviewPane(state: state)),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(width: 430, child: _SelectionPane(state: state)),
            const VerticalDivider(width: 1),
            Expanded(child: _PreviewPane(state: state)),
          ],
        );
      },
    );
  }
}

class _SearchHeader extends ConsumerWidget {
  const _SearchHeader({required this.state});

  final SearchState state;

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
                  'Search',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                HeaderMetricChip(
                  icon: Icons.devices_other,
                  label: '${state.deviceTypes.length} device types',
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
                ref.read(searchControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _SelectionPane extends ConsumerWidget {
  const _SelectionPane({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 12, 24, 28),
      child: ListView(
        children: [
          Text('Selection', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          _DropdownField(
            label: 'Device type',
            value: state.selectedDeviceTypeId,
            items: [
              for (final item in state.deviceTypes)
                DropdownMenuItem(value: item.id, child: Text(item.name)),
            ],
            onChanged: state.deviceTypes.isEmpty
                ? null
                : (value) => ref
                      .read(searchControllerProvider.notifier)
                      .selectDeviceType(value),
          ),
          const SizedBox(height: 14),
          _DropdownField(
            label: 'Brand',
            value: state.selectedBrandId,
            items: [
              for (final item in state.brands)
                DropdownMenuItem(value: item.id, child: Text(item.name)),
            ],
            onChanged: state.brands.isEmpty
                ? null
                : (value) => ref
                      .read(searchControllerProvider.notifier)
                      .selectBrand(value),
          ),
          const SizedBox(height: 14),
          _DropdownField(
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
                      .read(searchControllerProvider.notifier)
                      .selectDeviceModel(value),
          ),
          const SizedBox(height: 14),
          _DropdownField(
            label: 'Component',
            value: state.selectedComponentId,
            items: [
              for (final item in state.components)
                DropdownMenuItem(value: item.id, child: Text(item.name)),
            ],
            onChanged:
                state.selectedDeviceTypeId == null || state.components.isEmpty
                ? null
                : (value) => ref
                      .read(searchControllerProvider.notifier)
                      .selectComponent(value),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Suppliers',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Text('${state.selectedSupplierIds.length} selected'),
            ],
          ),
          const SizedBox(height: 8),
          if (state.selectedDeviceTypeId == null)
            const _InlineEmptyText('Select a device type first.')
          else if (state.suppliers.isEmpty)
            const _InlineEmptyText('No active compatible suppliers.')
          else
            for (final supplier in state.suppliers)
              CheckboxListTile(
                value: state.selectedSupplierIds.contains(supplier.id),
                contentPadding: EdgeInsets.zero,
                title: Text(supplier.name),
                subtitle: Text(
                  supplier.baseUrl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                onChanged: (value) => ref
                    .read(searchControllerProvider.notifier)
                    .setSupplierSelected(supplier.id, value ?? false),
              ),
        ],
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  const _DropdownField({
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
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: items,
      onChanged: onChanged,
    );
  }
}

class _PreviewPane extends ConsumerWidget {
  const _PreviewPane({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              SizedBox(
                width: 180,
                child: Text(
                  'Preview',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FilledButton.icon(
                onPressed: state.hasCompleteSelection
                    ? () => _runSearchAction(
                        context,
                        () => ref
                            .read(searchControllerProvider.notifier)
                            .generatePreview(),
                      )
                    : null,
                icon: const Icon(Icons.visibility_outlined),
                label: const Text('Preview'),
              ),
              FilledButton.icon(
                onPressed: state.hasPreview
                    ? () => _confirmAndOpen(context, ref, state)
                    : null,
                icon: const Icon(Icons.open_in_browser),
                label: const Text('Open'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _QueryPanel(state: state),
          const SizedBox(height: 18),
          Expanded(
            child: state.previewItems.isEmpty
                ? const Center(child: Text('No URL preview generated.'))
                : ListView.separated(
                    itemCount: state.previewItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = state.previewItems[index];
                      return ListTile(
                        leading: Icon(_iconForOpenResult(item.openResult)),
                        title: Text(item.supplierName),
                        subtitle: SelectableText(item.url.toString()),
                        trailing: item.openResult == null
                            ? null
                            : Text(item.openResult!),
                      );
                    },
                  ),
          ),
          if (state.lastResultMessage != null) ...[
            const SizedBox(height: 12),
            Text(state.lastResultMessage!),
          ],
        ],
      ),
    );
  }
}

class _QueryPanel extends StatelessWidget {
  const _QueryPanel({required this.state});

  final SearchState state;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Generated query',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          SelectableText(state.generatedQuery ?? 'Preview not generated yet.'),
        ],
      ),
    );
  }
}

class _InlineEmptyText extends StatelessWidget {
  const _InlineEmptyText(this.value);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(value),
    );
  }
}

Future<void> _confirmAndOpen(
  BuildContext context,
  WidgetRef ref,
  SearchState state,
) async {
  final controller = ref.read(searchControllerProvider.notifier);

  if (state.settings.requireConfirmation) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Open URLs'),
        content: Text('Open ${state.previewItems.length} supplier pages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.open_in_browser),
            label: const Text('Open'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) {
      return;
    }
  }

  await _runSearchAction(context, () => controller.openPreviewedUrls());
}

Future<void> _runSearchAction(
  BuildContext context,
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

IconData _iconForOpenResult(String? openResult) {
  if (openResult == null) {
    return Icons.link;
  }
  return openResult == 'opened'
      ? Icons.check_circle_outline
      : Icons.error_outline;
}
