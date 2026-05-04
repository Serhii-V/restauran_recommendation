import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_buttons.dart';

class MenuEmptyState extends StatelessWidget {
  final VoidCallback onClearFilters;

  const MenuEmptyState({super.key, required this.onClearFilters});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.no_meals, size: 80, color: AppColors.border),
            const SizedBox(height: 24),
            Text(
              'No matching dishes',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Try adjusting your preferences or choose another category.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppSecondaryButton(
              text: 'Show all categories',
              onPressed: onClearFilters,
              fullWidth: false,
              infiniteWidth: false,
            ),
          ],
        ),
      ),
    );
  }
}
