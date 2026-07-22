import 'package:flutter/material.dart';

class TechnicalSectionView extends StatelessWidget {
  const TechnicalSectionView({
    required this.title,
    required this.icon,
    required this.sections,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<String> sections;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 28),
                const SizedBox(width: 12),
                Text(title, style: textTheme.headlineSmall),
                const SizedBox(width: 16),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Text(
                      'Technical shell',
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: sections.length,
                  separatorBuilder: (context, index) =>
                      Divider(height: 1, color: colorScheme.outlineVariant),
                  itemBuilder: (context, index) => ListTile(
                    leading: Icon(
                      Icons.radio_button_unchecked,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    title: Text(sections[index]),
                    dense: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
