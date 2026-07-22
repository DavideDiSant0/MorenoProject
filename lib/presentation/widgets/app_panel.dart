import 'package:flutter/material.dart';

/// Riquadro bordato usato per raggruppare contenuti correlati in una
/// schermata (query generata, template fornitore, snapshot, impostazioni).
class AppPanel extends StatelessWidget {
  const AppPanel({
    required this.child,
    this.maxWidth,
    this.padding = const EdgeInsets.all(16),
    super.key,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: maxWidth == null
          ? null
          : BoxConstraints(maxWidth: maxWidth!),
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
