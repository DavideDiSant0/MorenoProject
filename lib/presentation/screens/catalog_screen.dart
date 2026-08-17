import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/application/state/catalog_state.dart';
import 'package:repair_parts_finder/domain/entities/brand.dart';
import 'package:repair_parts_finder/domain/entities/component.dart';
import 'package:repair_parts_finder/domain/entities/device_model.dart';
import 'package:repair_parts_finder/domain/entities/device_type.dart';
import 'package:repair_parts_finder/presentation/providers/catalog_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/confirm_and_run.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';
import 'package:repair_parts_finder/presentation/widgets/header_metric_chip.dart';

class CatalogScreen extends ConsumerWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catalogState = ref.watch(catalogControllerProvider);

    return catalogState.when(
      data: (state) => _CatalogContent(state: state),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(catalogControllerProvider),
      ),
    );
  }
}

class _CatalogContent extends ConsumerWidget {
  const _CatalogContent({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _CatalogHeader(state: state),
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(icon: Icon(Icons.devices_other), text: 'Tipi di dispositivo'),
              Tab(icon: Icon(Icons.sell_outlined), text: 'Marche'),
              Tab(icon: Icon(Icons.phone_iphone), text: 'Modelli'),
              Tab(icon: Icon(Icons.construction), text: 'Componenti'),
              Tab(icon: Icon(Icons.hub_outlined), text: 'Compatibilità'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _DeviceTypesTab(state: state),
                _BrandsTab(state: state),
                _ModelsTab(state: state),
                _ComponentsTab(state: state),
                _CompatibilityTab(state: state),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CatalogHeader extends StatelessWidget {
  const _CatalogHeader({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 12),
      child: Wrap(
        spacing: 18,
        runSpacing: 10,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text('Catalogo', style: textTheme.headlineSmall),
          HeaderMetricChip(
            icon: Icons.devices_other,
            label: '${state.deviceTypes.length} tipi',
          ),
          HeaderMetricChip(
            icon: Icons.sell_outlined,
            label: '${state.brands.length} marche',
          ),
          HeaderMetricChip(
            icon: Icons.phone_iphone,
            label: '${state.deviceModels.length} modelli',
          ),
          HeaderMetricChip(
            icon: Icons.construction,
            label: '${state.components.length} componenti',
          ),
        ],
      ),
    );
  }
}

class _DeviceTypesTab extends ConsumerWidget {
  const _DeviceTypesTab({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(catalogControllerProvider.notifier);

    return _CatalogListScaffold(
      title: 'Tipi di dispositivo',
      addLabel: 'Aggiungi tipo',
      onAdd: () => _showDeviceTypeDialog(context, ref),
      child: _EntityList<DeviceType>(
        items: state.deviceTypes,
        emptyText: 'Nessun tipo di dispositivo ancora.',
        titleBuilder: (item) => item.name,
        subtitleBuilder: (item) => item.description ?? 'Nessuna descrizione',
        isActive: (item) => item.isActive,
        onEdit: (item) => _showDeviceTypeDialog(context, ref, existing: item),
        onDelete: (item) => confirmAndRun(
          context,
          title: 'Elimina tipo di dispositivo',
          message: 'Eliminare ${item.name}?',
          action: () => _runCatalogAction(
            context,
            () => controller.deleteDeviceType(item.id),
          ),
        ),
      ),
    );
  }
}

class _BrandsTab extends ConsumerWidget {
  const _BrandsTab({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(catalogControllerProvider.notifier);

    return _CatalogListScaffold(
      title: 'Marche',
      addLabel: 'Aggiungi marca',
      onAdd: () => _showBrandDialog(context, ref),
      child: _EntityList<Brand>(
        items: state.brands,
        emptyText: 'Nessuna marca ancora.',
        titleBuilder: (item) => item.name,
        subtitleBuilder: (item) => item.id,
        isActive: (item) => item.isActive,
        onEdit: (item) => _showBrandDialog(context, ref, existing: item),
        onDelete: (item) => confirmAndRun(
          context,
          title: 'Elimina marca',
          message: 'Eliminare ${item.name}?',
          action: () =>
              _runCatalogAction(context, () => controller.deleteBrand(item.id)),
        ),
      ),
    );
  }
}

class _ModelsTab extends ConsumerWidget {
  const _ModelsTab({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceTypeNames = {
      for (final item in state.deviceTypes) item.id: item.name,
    };
    final brandNames = {for (final item in state.brands) item.id: item.name};
    final controller = ref.read(catalogControllerProvider.notifier);

    return _CatalogListScaffold(
      title: 'Modelli di dispositivo',
      addLabel: 'Aggiungi modello',
      onAdd: state.deviceTypes.isEmpty || state.brands.isEmpty
          ? null
          : () => _showDeviceModelDialog(context, ref, state: state),
      child: _EntityList<DeviceModel>(
        items: state.deviceModels,
        emptyText: state.deviceTypes.isEmpty || state.brands.isEmpty
            ? 'Aggiungi almeno un tipo di dispositivo e una marca prima dei modelli.'
            : 'Nessun modello di dispositivo ancora.',
        titleBuilder: (item) => item.name,
        subtitleBuilder: (item) {
          final type = deviceTypeNames[item.deviceTypeId] ?? item.deviceTypeId;
          final brand = brandNames[item.brandId] ?? item.brandId;
          final code = item.modelCode == null ? '' : ' - ${item.modelCode}';
          return '$brand / $type$code';
        },
        isActive: (item) => item.isActive,
        onEdit: (item) =>
            _showDeviceModelDialog(context, ref, state: state, existing: item),
        onDelete: (item) => confirmAndRun(
          context,
          title: 'Elimina modello',
          message: 'Eliminare ${item.name}?',
          action: () => _runCatalogAction(
            context,
            () => controller.deleteDeviceModel(item.id),
          ),
        ),
      ),
    );
  }
}

class _ComponentsTab extends ConsumerWidget {
  const _ComponentsTab({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(catalogControllerProvider.notifier);

    return _CatalogListScaffold(
      title: 'Componenti',
      addLabel: 'Aggiungi componente',
      onAdd: () => _showComponentDialog(context, ref),
      child: _EntityList<Component>(
        items: state.components,
        emptyText: 'Nessun componente ancora.',
        titleBuilder: (item) => item.name,
        subtitleBuilder: (item) => item.description ?? 'Nessuna descrizione',
        isActive: (item) => item.isActive,
        onEdit: (item) => _showComponentDialog(context, ref, existing: item),
        onDelete: (item) => confirmAndRun(
          context,
          title: 'Elimina componente',
          message: 'Eliminare ${item.name}?',
          action: () => _runCatalogAction(
            context,
            () => controller.deleteComponent(item.id),
          ),
        ),
      ),
    );
  }
}

class _CompatibilityTab extends ConsumerWidget {
  const _CompatibilityTab({required this.state});

  final CatalogState state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(catalogControllerProvider.notifier);
    final selectedId = state.selectedCompatibilityDeviceTypeId;
    final compatibleIds = state.compatibleComponents
        .map((component) => component.id)
        .toSet();

    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Compatibilità dispositivo/componente',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: DropdownButtonFormField<String>(
              initialValue: selectedId,
              decoration: const InputDecoration(
                labelText: 'Tipo di dispositivo',
              ),
              items: [
                for (final item in state.deviceTypes)
                  DropdownMenuItem(value: item.id, child: Text(item.name)),
              ],
              onChanged: state.deviceTypes.isEmpty
                  ? null
                  : (value) => ref
                        .read(catalogControllerProvider.notifier)
                        .selectCompatibilityDeviceType(value),
            ),
          ),
          const SizedBox(height: 20),
          if (selectedId == null)
            const Text(
              'Aggiungi un tipo di dispositivo prima di configurare la compatibilità.',
            )
          else if (state.components.isEmpty)
            const Text(
              'Aggiungi componenti prima di configurare la compatibilità.',
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: state.components.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final component = state.components[index];
                  final isCompatible = compatibleIds.contains(component.id);
                  return CheckboxListTile(
                    value: isCompatible,
                    title: Text(component.name),
                    subtitle: Text(component.description ?? component.id),
                    onChanged: (value) => _runCatalogAction(
                      context,
                      () => controller.setComponentCompatibility(
                        deviceTypeId: selectedId,
                        componentId: component.id,
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

class _CatalogListScaffold extends StatelessWidget {
  const _CatalogListScaffold({
    required this.title,
    required this.addLabel,
    required this.child,
    this.onAdd,
  });

  final String title;
  final String addLabel;
  final Widget child;
  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              FilledButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add),
                label: Text(addLabel),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _EntityList<T> extends StatelessWidget {
  const _EntityList({
    required this.items,
    required this.emptyText,
    required this.titleBuilder,
    required this.subtitleBuilder,
    required this.isActive,
    required this.onEdit,
    required this.onDelete,
  });

  final List<T> items;
  final String emptyText;
  final String Function(T item) titleBuilder;
  final String Function(T item) subtitleBuilder;
  final bool Function(T item) isActive;
  final void Function(T item) onEdit;
  final void Function(T item) onDelete;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(child: Text(emptyText));
    }

    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(titleBuilder(item)),
          subtitle: Text(subtitleBuilder(item)),
          leading: Icon(
            isActive(item) ? Icons.check_circle : Icons.pause_circle_outline,
            color: isActive(item)
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline,
          ),
          trailing: Wrap(
            spacing: 4,
            children: [
              IconButton(
                tooltip: 'Modifica',
                onPressed: () => onEdit(item),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Elimina',
                onPressed: () => onDelete(item),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        );
      },
    );
  }
}

Future<void> _showDeviceTypeDialog(
  BuildContext context,
  WidgetRef ref, {
  DeviceType? existing,
}) async {
  final controller = ref.read(catalogControllerProvider.notifier);
  final nameController = TextEditingController(text: existing?.name);
  final descriptionController = TextEditingController(
    text: existing?.description,
  );
  var isActive = existing?.isActive ?? true;

  await _showEntityDialog(
    context,
    title: existing == null
        ? 'Aggiungi tipo di dispositivo'
        : 'Modifica tipo di dispositivo',
    fields: [
      TextField(
        controller: nameController,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      TextField(
        controller: descriptionController,
        decoration: const InputDecoration(labelText: 'Descrizione'),
      ),
      StatefulBuilder(
        builder: (context, setState) => SwitchListTile(
          value: isActive,
          title: const Text('Attivo'),
          onChanged: (value) => setState(() => isActive = value),
        ),
      ),
    ],
    onSave: () => _tryRunCatalogAction(
      context,
      () => controller.saveDeviceType(
        id: existing?.id,
        name: nameController.text,
        description: descriptionController.text,
        isActive: isActive,
      ),
    ),
  );
}

Future<void> _showBrandDialog(
  BuildContext context,
  WidgetRef ref, {
  Brand? existing,
}) async {
  final controller = ref.read(catalogControllerProvider.notifier);
  final nameController = TextEditingController(text: existing?.name);
  var isActive = existing?.isActive ?? true;

  await _showEntityDialog(
    context,
    title: existing == null ? 'Aggiungi marca' : 'Modifica marca',
    fields: [
      TextField(
        controller: nameController,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      StatefulBuilder(
        builder: (context, setState) => SwitchListTile(
          value: isActive,
          title: const Text('Attivo'),
          onChanged: (value) => setState(() => isActive = value),
        ),
      ),
    ],
    onSave: () => _tryRunCatalogAction(
      context,
      () => controller.saveBrand(
        id: existing?.id,
        name: nameController.text,
        isActive: isActive,
      ),
    ),
  );
}

Future<void> _showComponentDialog(
  BuildContext context,
  WidgetRef ref, {
  Component? existing,
}) async {
  final controller = ref.read(catalogControllerProvider.notifier);
  final nameController = TextEditingController(text: existing?.name);
  final descriptionController = TextEditingController(
    text: existing?.description,
  );
  var isActive = existing?.isActive ?? true;

  await _showEntityDialog(
    context,
    title: existing == null ? 'Aggiungi componente' : 'Modifica componente',
    fields: [
      TextField(
        controller: nameController,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      TextField(
        controller: descriptionController,
        decoration: const InputDecoration(labelText: 'Descrizione'),
      ),
      StatefulBuilder(
        builder: (context, setState) => SwitchListTile(
          value: isActive,
          title: const Text('Attivo'),
          onChanged: (value) => setState(() => isActive = value),
        ),
      ),
    ],
    onSave: () => _tryRunCatalogAction(
      context,
      () => controller.saveComponent(
        id: existing?.id,
        name: nameController.text,
        description: descriptionController.text,
        isActive: isActive,
      ),
    ),
  );
}

Future<void> _showDeviceModelDialog(
  BuildContext context,
  WidgetRef ref, {
  required CatalogState state,
  DeviceModel? existing,
}) async {
  final controller = ref.read(catalogControllerProvider.notifier);
  final nameController = TextEditingController(text: existing?.name);
  final modelCodeController = TextEditingController(text: existing?.modelCode);
  final alternativeTermsController = TextEditingController(
    text: existing?.alternativeSearchTerms.join(', '),
  );
  var deviceTypeId = existing?.deviceTypeId ?? state.deviceTypes.first.id;
  var brandId = existing?.brandId ?? state.brands.first.id;
  var isActive = existing?.isActive ?? true;

  await _showEntityDialog(
    context,
    title: existing == null ? 'Aggiungi modello' : 'Modifica modello',
    fields: [
      TextField(
        controller: nameController,
        autofocus: true,
        decoration: const InputDecoration(labelText: 'Nome'),
      ),
      TextField(
        controller: modelCodeController,
        decoration: const InputDecoration(labelText: 'Codice modello'),
      ),
      StatefulBuilder(
        builder: (context, setState) => DropdownButtonFormField<String>(
          initialValue: deviceTypeId,
          decoration: const InputDecoration(labelText: 'Tipo di dispositivo'),
          items: [
            for (final item in state.deviceTypes)
              DropdownMenuItem(value: item.id, child: Text(item.name)),
          ],
          onChanged: (value) => setState(() => deviceTypeId = value!),
        ),
      ),
      StatefulBuilder(
        builder: (context, setState) => DropdownButtonFormField<String>(
          initialValue: brandId,
          decoration: const InputDecoration(labelText: 'Marca'),
          items: [
            for (final item in state.brands)
              DropdownMenuItem(value: item.id, child: Text(item.name)),
          ],
          onChanged: (value) => setState(() => brandId = value!),
        ),
      ),
      TextField(
        controller: alternativeTermsController,
        decoration: const InputDecoration(
          labelText: 'Termini alternativi',
          helperText: 'Separa i termini con virgole.',
        ),
      ),
      StatefulBuilder(
        builder: (context, setState) => SwitchListTile(
          value: isActive,
          title: const Text('Attivo'),
          onChanged: (value) => setState(() => isActive = value),
        ),
      ),
    ],
    onSave: () => _tryRunCatalogAction(
      context,
      () => controller.saveDeviceModel(
        id: existing?.id,
        name: nameController.text,
        modelCode: modelCodeController.text,
        alternativeSearchTerms: _splitTerms(alternativeTermsController.text),
        deviceTypeId: deviceTypeId,
        brandId: brandId,
        isActive: isActive,
      ),
    ),
  );
}

Future<void> _showEntityDialog(
  BuildContext context, {
  required String title,
  required List<Widget> fields,
  required Future<bool> Function() onSave,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 460,
        child: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: fields),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annulla'),
        ),
        FilledButton.icon(
          onPressed: () async {
            final saved = await onSave();
            if (saved && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Salva'),
        ),
      ],
    ),
  );
}

Future<bool> _tryRunCatalogAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  try {
    await action();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Catalogo aggiornato')));
    }
    return true;
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(describeError(error))));
    }
    return false;
  }
}

Future<void> _runCatalogAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  await _tryRunCatalogAction(context, action);
}

List<String> _splitTerms(String value) {
  return value
      .split(',')
      .map((term) => term.trim())
      .where((term) => term.isNotEmpty)
      .toList();
}
