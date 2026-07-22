import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  const seedColor = Color(0xFF216869);

  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.light,
    ),
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    scaffoldBackgroundColor: const Color(0xFFF6F7F8),
    navigationRailTheme: const NavigationRailThemeData(
      minWidth: 84,
      minExtendedWidth: 220,
      groupAlignment: -0.92,
    ),
  );
}
