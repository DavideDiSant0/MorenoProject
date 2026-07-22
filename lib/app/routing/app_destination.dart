import 'package:flutter/material.dart';

/// Destinazioni principali della shell desktop.
enum AppDestination {
  search(
    path: '/search',
    label: 'Search',
    icon: Icons.search_outlined,
    selectedIcon: Icons.search,
  ),
  catalog(
    path: '/catalog',
    label: 'Catalog',
    icon: Icons.inventory_2_outlined,
    selectedIcon: Icons.inventory_2,
  ),
  suppliers(
    path: '/suppliers',
    label: 'Suppliers',
    icon: Icons.storefront_outlined,
    selectedIcon: Icons.storefront,
  ),
  history(
    path: '/history',
    label: 'History',
    icon: Icons.history_outlined,
    selectedIcon: Icons.history,
  ),
  favorites(
    path: '/favorites',
    label: 'Favorites',
    icon: Icons.star_border,
    selectedIcon: Icons.star,
  ),
  settings(
    path: '/settings',
    label: 'Settings',
    icon: Icons.settings_outlined,
    selectedIcon: Icons.settings,
  );

  const AppDestination({
    required this.path,
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String path;
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  static AppDestination fromPath(String path) {
    return values.firstWhere(
      (destination) => path == destination.path,
      orElse: () => search,
    );
  }
}
