import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/state/history_state.dart';
import 'package:repair_parts_finder/domain/entities/search_history.dart';
import 'package:repair_parts_finder/presentation/providers/history_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/app_panel.dart';
import 'package:repair_parts_finder/presentation/widgets/confirm_and_run.dart';
import 'package:repair_parts_finder/presentation/widgets/date_formatting.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';
import 'package:repair_parts_finder/presentation/widgets/header_metric_chip.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyState = ref.watch(historyControllerProvider);

    return historyState.when(
      data: (state) => _HistoryContent(state: state),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(historyControllerProvider),
      ),
    );
  }
}

class _HistoryContent extends ConsumerWidget {
  const _HistoryContent({required this.state});

  final HistoryState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedEntry = state.selectedEntry;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HistoryHeader(state: state),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final listPane = _HistoryListPane(
                entries: state.entries,
                selectedEntryId: state.selectedEntryId,
              );
              final detailsPane = selectedEntry == null
                  ? const _EmptyHistoryDetails()
                  : _HistoryDetailsPane(entry: selectedEntry, state: state);

              if (constraints.maxWidth < 900) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 380, child: listPane),
                    const Divider(height: 1),
                    SizedBox(height: 620, child: detailsPane),
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(width: 420, child: listPane),
                  const VerticalDivider(width: 1),
                  Expanded(child: detailsPane),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _HistoryHeader extends ConsumerWidget {
  const _HistoryHeader({required this.state});

  final HistoryState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(historyControllerProvider.notifier);
    final urlCount = state.entries.fold<int>(
      0,
      (total, entry) => total + entry.suppliers.length,
    );

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
                  'History',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                HeaderMetricChip(
                  icon: Icons.history,
                  label: '${state.entries.length} searches',
                ),
                HeaderMetricChip(icon: Icons.link, label: '$urlCount URLs'),
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
                ref.read(historyControllerProvider.notifier).refresh(),
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            tooltip: 'Clear history',
            onPressed: state.entries.isEmpty
                ? null
                : () => confirmAndRun(
                    context,
                    title: 'Clear history',
                    message: 'Delete all saved searches?',
                    action: () => _runHistoryAction(
                      context,
                      () => controller.clearHistory(),
                    ),
                  ),
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
    );
  }
}

class _HistoryListPane extends ConsumerWidget {
  const _HistoryListPane({
    required this.entries,
    required this.selectedEntryId,
  });

  final List<SearchHistory> entries;
  final String? selectedEntryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(historyControllerProvider.notifier);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Saved searches', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Expanded(
            child: entries.isEmpty
                ? const Center(child: Text('No saved searches yet.'))
                : ListView.separated(
                    itemCount: entries.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final entry = entries[index];
                      return ListTile(
                        selected: entry.id == selectedEntryId,
                        onTap: () => controller.selectEntry(entry.id),
                        title: Text(
                          entry.generatedQuery,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${formatDateTime(entry.searchedAt)}  ·  '
                          '${entry.suppliers.length} suppliers',
                        ),
                        leading: const Icon(Icons.manage_search),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _HistoryDetailsPane extends ConsumerWidget {
  const _HistoryDetailsPane({required this.entry, required this.state});

  final SearchHistory entry;
  final HistoryState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(historyControllerProvider.notifier);

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
                width: 360,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.generatedQuery,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(formatDateTime(entry.searchedAt)),
                  ],
                ),
              ),
              FilledButton.icon(
                onPressed: () => _confirmRepeat(context, ref, entry, state),
                icon: const Icon(Icons.replay),
                label: const Text('Repeat'),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => confirmAndRun(
                  context,
                  title: 'Delete search',
                  message: 'Delete this saved search?',
                  action: () => _runHistoryAction(
                    context,
                    () => controller.deleteEntry(entry.id),
                  ),
                ),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _SnapshotPanel(entry: entry),
          const SizedBox(height: 18),
          Text(
            'Opened suppliers',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: entry.suppliers.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final supplier = entry.suppliers[index];
                return ListTile(
                  leading: const Icon(Icons.open_in_new),
                  title: Text(supplier.supplierName),
                  subtitle: SelectableText(supplier.generatedUrl),
                  trailing: supplier.openResult == null
                      ? null
                      : Text(supplier.openResult!),
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

class _SnapshotPanel extends StatelessWidget {
  const _SnapshotPanel({required this.entry});

  final SearchHistory entry;

  @override
  Widget build(BuildContext context) {
    final modelCode = entry.deviceModelCode;
    final parts = [
      entry.deviceType,
      entry.brand,
      entry.deviceModel,
      if (modelCode != null && modelCode.trim().isNotEmpty) modelCode,
      entry.component,
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

class _EmptyHistoryDetails extends StatelessWidget {
  const _EmptyHistoryDetails();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Open a saved search to see details.'));
  }
}

Future<void> _confirmRepeat(
  BuildContext context,
  WidgetRef ref,
  SearchHistory entry,
  HistoryState state,
) async {
  final controller = ref.read(historyControllerProvider.notifier);

  if (state.settings.requireConfirmation) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Repeat search'),
        content: Text('Open ${entry.suppliers.length} saved supplier URLs?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.replay),
            label: const Text('Repeat'),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) {
      return;
    }
  }

  await _runHistoryAction(context, () => controller.repeatSelectedEntry());
}

Future<void> _runHistoryAction(
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
