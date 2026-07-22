import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'History',
      icon: Icons.history,
      sections: [
        'Recent searches',
        'Generated queries',
        'Opened suppliers',
        'Repeat search',
      ],
    );
  }
}
