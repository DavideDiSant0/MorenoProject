import 'package:flutter/material.dart';

/// Mostra un dialogo di conferma con azione distruttiva ed esegue [action]
/// solo se l'utente conferma. Non gestisce successo/errore: quello resta
/// responsabilita' del wrapper `_run*Action` gia' esistente in ogni
/// schermata, passato come [action].
Future<void> confirmAndRun(
  BuildContext context, {
  required String title,
  required String message,
  required Future<void> Function() action,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          icon: const Icon(Icons.delete_outline),
          label: const Text('Delete'),
        ),
      ],
    ),
  );
  if (!(confirmed ?? false) || !context.mounted) {
    return;
  }
  await action();
}
