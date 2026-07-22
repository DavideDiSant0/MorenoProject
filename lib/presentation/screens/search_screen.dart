import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'Search',
      icon: Icons.search,
      sections: [
        'Device type',
        'Brand',
        'Device model',
        'Component',
        'Suppliers',
        'Preview',
      ],
    );
  }
}
