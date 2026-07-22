import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'Settings',
      icon: Icons.settings,
      sections: [
        'Open confirmation',
        'Maximum pages',
        'History',
        'Local backup',
      ],
    );
  }
}
