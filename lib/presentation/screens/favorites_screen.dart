import 'package:flutter/material.dart';
import 'package:repair_parts_finder/presentation/widgets/technical_section_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TechnicalSectionView(
      title: 'Favorites',
      icon: Icons.star,
      sections: ['Saved combinations', 'Preferred suppliers', 'Quick repeat'],
    );
  }
}
