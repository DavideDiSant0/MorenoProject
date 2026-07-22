import 'package:flutter/material.dart';

/// Indicatore icona+testo usato nelle intestazioni delle schermate per
/// mostrare un conteggio o uno stato sintetico (es. "4 device types").
class HeaderMetricChip extends StatelessWidget {
  const HeaderMetricChip({required this.icon, required this.label, super.key});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}
