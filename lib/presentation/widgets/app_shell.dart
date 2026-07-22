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

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            NavigationRail(
              extended: MediaQuery.sizeOf(context).width >= 1040,
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

class _ShellBrand extends StatelessWidget {
  const _ShellBrand();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Tooltip(
        message: 'Repair Parts Finder',
        child: SizedBox.square(
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
        ),
      ),
    );
  }
}
