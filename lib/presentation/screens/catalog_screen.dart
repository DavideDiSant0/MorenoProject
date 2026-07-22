import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'Catalog',
      icon: Icons.inventory_2,
      sections: [
        'Device types',
        'Brands',
        'Device models',
        'Components',
        'Compatibility',
      ],
    );
  }
}
