import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:repair_parts_finder/app/routing/app_destination.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.selectedDestination,
    required this.child,
    super.key,
  });

  final AppDestination selectedDestination;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final selectedIndex = AppDestination.values.indexOf(selectedDestination);
    final size = MediaQuery.sizeOf(context);
    final useCompactNavigation = size.height < 560;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (useCompactNavigation)
              _CompactShellNavigation(
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  context.go(AppDestination.values[index].path);
                },
              )
            else
              NavigationRail(
                extended: size.width >= 1040,
                selectedIndex: selectedIndex,
                onDestinationSelected: (index) {
                  context.go(AppDestination.values[index].path);
                },
                leading: const _ShellBrand(),
                destinations: [
                  for (final destination in AppDestination.values)
                    NavigationRailDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: Text(destination.label),
                    ),
                ],
              ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class _CompactShellNavigation extends StatelessWidget {
  const _CompactShellNavigation({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 72,
      child: Material(
        color: colorScheme.surface,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Center(child: _ShellBrandMark()),
            ),
            for (var index = 0; index < AppDestination.values.length; index++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: IconButton(
                  tooltip: AppDestination.values[index].label,
                  isSelected: index == selectedIndex,
                  style: IconButton.styleFrom(
                    backgroundColor: index == selectedIndex
                        ? colorScheme.secondaryContainer
                        : null,
                    foregroundColor: index == selectedIndex
                        ? colorScheme.onSecondaryContainer
                        : colorScheme.onSurfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => onDestinationSelected(index),
                  icon: Icon(AppDestination.values[index].icon),
                  selectedIcon: Icon(AppDestination.values[index].selectedIcon),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ShellBrand extends StatelessWidget {
  const _ShellBrand();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Tooltip(
        message: 'Repair Parts Finder',
        child: const _ShellBrandMark(),
      ),
    );
  }
}

class _ShellBrandMark extends StatelessWidget {
  const _ShellBrandMark();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox.square(
      dimension: 44,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.build_circle_outlined,
          color: colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
