import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/state/supplier_state.dart';
import 'package:repair_parts_finder/domain/entities/supplier.dart';
import 'package:repair_parts_finder/presentation/providers/supplier_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/app_panel.dart';
import 'package:repair_parts_finder/presentation/widgets/confirm_and_run.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';
import 'package:repair_parts_finder/presentation/widgets/header_metric_chip.dart';

class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplierState = ref.watch(supplierControllerProvider);

    return supplierState.when(
      data: (state) => _SuppliersContent(state: state),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(supplierControllerProvider),
      ),
    );
  }
}

class _SuppliersContent extends ConsumerWidget {
  const _SuppliersContent({required this.state});

  final SupplierState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSupplier = state.selectedSupplier;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SuppliersHeader(state: state),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 380,
                child: _SupplierListPane(
                  state: state,
                  selectedSupplier: selectedSupplier,
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: selectedSupplier == null
                    ? const _EmptySupplierDetails()
                    : _SupplierDetailsPane(
                        state: state,
                        supplier: selectedSupplier,
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SuppliersHeader extends StatelessWidget {
  const _SuppliersHeader({required this.state});

  final SupplierState state;

  @override
  Widget build(BuildContext context) {
    final activeCount = state.suppliers
        .where((supplier) => supplier.isActive)
        .length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 12),
      child: Wrap(
        spacing: 18,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Suppliers', style: Theme.of(context).textTheme.headlineSmall),
          HeaderMetricChip(
            icon: Icons.storefront,
            label: '${state.suppliers.length} total',
          ),
          HeaderMetricChip(
            icon: Icons.check_circle_outline,
            label: '$activeCount active',
          ),
          HeaderMetricChip(
            icon: Icons.devices_other,
            label: '${state.deviceTypes.length} device types',
          ),
        ],
      ),
    );
  }
}

class _SupplierListPane extends ConsumerWidget {
  const _SupplierListPane({
    required this.state,
    required this.selectedSupplier,
  });

  final SupplierState state;
  final Supplier? selectedSupplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Supplier list',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FilledButton.icon(
                onPressed: () =>
                    _showSupplierDialog(context, ref, state: state),
                icon: const Icon(Icons.add),
                label: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: state.suppliers.isEmpty
                ? const Center(child: Text('No suppliers yet.'))
                : ListView.separated(
                    itemCount: state.suppliers.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final supplier = state.suppliers[index];
                      final isSelected = supplier.id == selectedSupplier?.id;
                      return ListTile(
                        selected: isSelected,
                        onTap: () => ref
                            .read(supplierControllerProvider.notifier)
                            .selectSupplier(supplier.id),
                        leading: CircleAvatar(
                          child: Text('${supplier.displayOrder + 1}'),
                        ),
                        title: Text(
                          supplier.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          supplier.baseUrl,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Icon(
                          supplier.isActive
                              ? Icons.check_circle
                              : Icons.pause_circle_outline,
                          color: supplier.isActive
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
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

class _SupplierDetailsPane extends ConsumerWidget {
  const _SupplierDetailsPane({required this.state, required this.supplier});

  final SupplierState state;
  final Supplier supplier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final compatibleIds = state.compatibleDeviceTypes
        .map((deviceType) => deviceType.id)
        .toSet();
    final supplierIndex = state.suppliers.indexWhere(
      (item) => item.id == supplier.id,
    );

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      supplier.baseUrl,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Move up',
                onPressed: supplierIndex <= 0
                    ? null
                    : () => _runSupplierAction(
                        context,
                        ref,
                        () => ref
                            .read(supplierControllerProvider.notifier)
                            .moveSupplier(supplier.id, -1),
                      ),
                icon: const Icon(Icons.arrow_upward),
              ),
              IconButton(
                tooltip: 'Move down',
                onPressed:
                    supplierIndex == -1 ||
                        supplierIndex >= state.suppliers.length - 1
                    ? null
                    : () => _runSupplierAction(
                        context,
                        ref,
                        () => ref
                            .read(supplierControllerProvider.notifier)
                            .moveSupplier(supplier.id, 1),
                      ),
                icon: const Icon(Icons.arrow_downward),
              ),
              IconButton(
                tooltip: 'Test template',
                onPressed: () => _testSupplierTemplate(context, ref, supplier),
                icon: const Icon(Icons.play_arrow_outlined),
              ),
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _showSupplierDialog(
                  context,
                  ref,
                  state: state,
                  existing: supplier,
                ),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => confirmAndRun(
                  context,
                  title: 'Delete supplier',
                  message: 'Delete ${supplier.name}?',
                  action: () => _runSupplierAction(
                    context,
                    ref,
                    () => ref
                        .read(supplierControllerProvider.notifier)
                        .deleteSupplier(supplier.id),
                  ),
                ),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _TemplatePanel(supplier: supplier),
          const SizedBox(height: 24),
          Text(
            'Device type compatibility',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: state.deviceTypes.isEmpty
                ? const Center(
                    child: Text(
                      'Add device types before configuring suppliers.',
                    ),
                  )
                : ListView.separated(
                    itemCount: state.deviceTypes.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final deviceType = state.deviceTypes[index];
                      final isCompatible = compatibleIds.contains(
                        deviceType.id,
                      );
                      return CheckboxListTile(
                        value: isCompatible,
                        title: Text(deviceType.name),
                        subtitle: Text(deviceType.description ?? deviceType.id),
                        onChanged: (value) => _runSupplierAction(
                          context,
                          ref,
                          () => ref
                              .read(supplierControllerProvider.notifier)
                              .setDeviceTypeCompatibility(
                                supplierId: supplier.id,
                                deviceTypeId: deviceType.id,
                                isCompatible: value ?? false,
                              ),
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

class _TemplatePanel extends StatelessWidget {
  const _TemplatePanel({required this.supplier});

  final Supplier supplier;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('URL template', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          SelectableText(supplier.urlTemplate),
          if (supplier.notes != null) ...[
            const SizedBox(height: 12),
            Text('Notes', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 4),
            Text(supplier.notes!),
          ],
        ],
      ),
    );
  }
}

class _EmptySupplierDetails extends StatelessWidget {
  const _EmptySupplierDetails();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Add a supplier to start.'));
  }
}

Future<void> _showSupplierDialog(
  BuildContext context,
  WidgetRef ref, {
  required SupplierState state,
  Supplier? existing,
}) async {
  final nameController = TextEditingController(text: existing?.name);
  final baseUrlController = TextEditingController(text: existing?.baseUrl);
  final urlTemplateController = TextEditingController(
    text: existing?.urlTemplate,
  );
  final displayOrderController = TextEditingController(
    text: '${existing?.displayOrder ?? state.suppliers.length}',
  );
  final notesController = TextEditingController(text: existing?.notes);
  var isActive = existing?.isActive ?? true;

  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(existing == null ? 'Add supplier' : 'Edit supplier'),
      content: SizedBox(
        width: 520,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: baseUrlController,
                decoration: const InputDecoration(labelText: 'Base URL'),
              ),
              TextField(
                controller: urlTemplateController,
                decoration: const InputDecoration(labelText: 'URL template'),
              ),
              TextField(
                controller: displayOrderController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Display order'),
              ),
              TextField(
                controller: notesController,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Notes'),
              ),
              StatefulBuilder(
                builder: (context, setState) => SwitchListTile(
                  value: isActive,
                  title: const Text('Active'),
                  onChanged: (value) => setState(() => isActive = value),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('Cancel'),
        ),
        TextButton.icon(
          onPressed: () =>
              _testTemplateText(context, ref, urlTemplateController.text),
          icon: const Icon(Icons.play_arrow_outlined),
          label: const Text('Test'),
        ),
        FilledButton.icon(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            unawaited(
              _runSupplierAction(
                context,
                ref,
                () => ref
                    .read(supplierControllerProvider.notifier)
                    .saveSupplier(
                      id: existing?.id,
                      name: nameController.text,
                      baseUrl: baseUrlController.text,
                      urlTemplate: urlTemplateController.text,
                      displayOrder:
                          int.tryParse(displayOrderController.text.trim()) ??
                          state.suppliers.length,
                      notes: notesController.text,
                      isActive: isActive,
                    ),
              ),
            );
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
        ),
      ],
    ),
  );
}

Future<void> _runSupplierAction(
  BuildContext context,
  WidgetRef ref,
  Future<void> Function() action,
) async {
  try {
    await action();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Suppliers updated')));
    }
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeError(error))));
    }
  }
}

void _testSupplierTemplate(
  BuildContext context,
  WidgetRef ref,
  Supplier supplier,
) {
  _testTemplateText(context, ref, supplier.urlTemplate);
}

void _testTemplateText(BuildContext context, WidgetRef ref, String template) {
  try {
    final uri = ref
        .read(supplierControllerProvider.notifier)
        .testTemplate(template);
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generated URL'),
        content: SelectableText(uri.toString()),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } catch (error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(describeError(error))));
  }
}
