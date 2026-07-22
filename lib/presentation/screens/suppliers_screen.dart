import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class SuppliersScreen extends StatelessWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'Suppliers',
      icon: Icons.storefront,
      sections: [
        'Supplier list',
        'URL templates',
        'Device type compatibility',
        'Display order',
      ],
    );
  }
}
