import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:repair_parts_finder/app/routing/app_router.dart';
import 'package:repair_parts_finder/app/theme/app_theme.dart';

void main() {
  runApp(const ProviderScope(child: RepairPartsFinderApp()));
}

class RepairPartsFinderApp extends StatelessWidget {
  const RepairPartsFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Repair Parts Finder',
      theme: buildAppTheme(),
      routerConfig: buildAppRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
