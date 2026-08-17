import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/domain/entities/app_settings.dart';
import 'package:repair_parts_finder/presentation/providers/settings_controller.dart';
import 'package:repair_parts_finder/presentation/widgets/app_error_view.dart';
import 'package:repair_parts_finder/presentation/widgets/app_panel.dart';
import 'package:repair_parts_finder/presentation/widgets/error_message.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);

    return settingsState.when(
      data: (settings) => _SettingsContent(settings: settings),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => AppErrorView(
        message: describeError(error),
        onRetry: () => ref.invalidate(settingsControllerProvider),
      ),
    );
  }
}

class _SettingsContent extends ConsumerWidget {
  const _SettingsContent({required this.settings});

  final AppSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Impostazioni',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            IconButton(
              tooltip: 'Aggiorna',
              onPressed: () =>
                  ref.read(settingsControllerProvider.notifier).refresh(),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _SettingsPanel(
          title: 'Apertura',
          children: [
            _MaxPagesControl(settings: settings),
            const Divider(height: 28),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.fact_check_outlined),
              title: const Text('Richiedi conferma'),
              subtitle: const Text(
                'Chiedi conferma prima di aprire le pagine dei fornitori.',
              ),
              value: settings.requireConfirmation,
              onChanged: (value) => _runSettingsAction(
                context,
                ref,
                () => ref
                    .read(settingsControllerProvider.notifier)
                    .updateRequireConfirmation(value),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _SettingsPanel(
          title: 'Cronologia',
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.history),
              title: const Text('Salva la cronologia delle ricerche'),
              subtitle: const Text(
                'Registra le ricerche dopo l’apertura degli URL.',
              ),
              value: settings.historyEnabled,
              onChanged: (value) => _runSettingsAction(
                context,
                ref,
                () => ref
                    .read(settingsControllerProvider.notifier)
                    .updateHistoryEnabled(value),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  const _SettingsPanel({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppPanel(
      maxWidth: 760,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

class _MaxPagesControl extends ConsumerWidget {
  const _MaxPagesControl({required this.settings});

  final AppSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        const Icon(Icons.open_in_browser),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Numero massimo di pagine da aprire',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text('${settings.maxPagesToOpen} pagine dei fornitori'),
              Slider(
                value: settings.maxPagesToOpen.toDouble(),
                min: 1,
                max: 20,
                divisions: 19,
                label: '${settings.maxPagesToOpen}',
                onChanged: (value) => _runSettingsAction(
                  context,
                  ref,
                  () => ref
                      .read(settingsControllerProvider.notifier)
                      .updateMaxPagesToOpen(value.round()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _runSettingsAction(
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
