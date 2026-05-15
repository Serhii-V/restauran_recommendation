import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/menu_item.dart';
import '../cubit/menu_cubit.dart';
import '../cubit/menu_state.dart';
import '../widgets/menu_item_details_header.dart';
import '../widgets/menu_item_attribute_chip.dart';
import '../widgets/menu_item_info_section.dart';

class MenuItemDetailsScreen extends StatelessWidget {
  final String itemId;

  const MenuItemDetailsScreen({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        final item = state.allItems.cast<MenuItem?>().firstWhere(
          (i) => i?.id == itemId,
          orElse: () => null,
        );

        if (item == null) {
          return _buildNotFound(context);
        }

        return Scaffold(
          backgroundColor: AppColors.card,
          appBar: AppBar(
            toolbarHeight: 80,
            leading: InkWell(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: const Icon(Icons.arrow_back_sharp, size: 40),
                ),
              ),
              onTap: () => context.pop(),
            ),
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 900) {
                  return _buildTabletLandscapeLayout(context, item);
                } else {
                  return _buildMobileLayout(
                    context,
                    item,
                    constraints.maxWidth,
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileLayout(BuildContext context, MenuItem item, double width) {
    final padding = width >= 600 ? 32.0 : 20.0;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MenuItemDetailsHeader(item: item),
          Padding(
            padding: EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildMainInfo(context, item),
                const Divider(height: 48),
                _buildAttributesSection(context, item),
                const Divider(height: 48),
                _buildDietarySection(context, item),
                const Divider(height: 48),
                _buildAllergenSection(context, item),
                const Divider(height: 48),
                _buildHealthSection(context, item),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabletLandscapeLayout(BuildContext context, MenuItem item) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: MenuItemDetailsHeader(item: item, isTabletLandscape: true),
            ),
          ),
          const SizedBox(width: 48),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMainInfo(context, item),
                  const Divider(height: 24),
                  _buildAttributesSection(context, item),
                  const Divider(height: 24),
                  _buildDietarySection(context, item),
                  const Divider(height: 24),
                  _buildAllergenSection(context, item),
                  const Divider(height: 24),
                  _buildHealthSection(context, item),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainInfo(BuildContext context, MenuItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '\$${item.price.toStringAsFixed(0)}',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: AppColors.accent),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          item.description,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
        ),
      ],
    );
  }

  Widget _buildAttributesSection(BuildContext context, MenuItem item) {
    return MenuItemInfoSection(
      title: 'Details',
      content: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          MenuItemAttributeChip(
            label: item.category.label,
            icon: Icons.category_outlined,
          ),
          MenuItemAttributeChip(
            label: item.portionSize.label,
            icon: Icons.restaurant_menu,
          ),
          MenuItemAttributeChip(
            label: item.spiceLevel.label,
            icon: Icons.whatshot,
            color: item.spiceLevel.index > 0
                ? AppColors.spiceIndicatorColor
                : null,
          ),
          MenuItemAttributeChip(
            label: item.mealStyle.label,
            icon: Icons.style_outlined,
          ),
          MenuItemAttributeChip(
            label: item.prepTime.label,
            icon: Icons.timer_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildDietarySection(BuildContext context, MenuItem item) {
    if (item.dietaryPreferences.isEmpty) return const SizedBox.shrink();

    return MenuItemInfoSection(
      title: 'Dietary Preferences',
      content: Wrap(
        spacing: 12,
        runSpacing: 12,
        children: item.dietaryPreferences.map((pref) {
          return MenuItemAttributeChip(
            label: pref.label,
            icon: Icons.check_circle_outline,
            color: AppColors.eatHealthierFlowColor,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAllergenSection(BuildContext context, MenuItem item) {
    final hasAllergens = item.allergens.isNotEmpty;

    return MenuItemInfoSection(
      title: 'Allergens',
      subtitle: hasAllergens
          ? 'Please confirm ingredients with restaurant staff.'
          : null,
      content: hasAllergens
          ? Wrap(
              spacing: 12,
              runSpacing: 12,
              children: item.allergens.map((allergen) {
                return MenuItemAttributeChip(
                  label: allergen.label,
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange.shade700,
                );
              }).toList(),
            )
          : Text(
              'No major allergens listed',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
    );
  }

  Widget _buildHealthSection(BuildContext context, MenuItem item) {
    return MenuItemInfoSection(
      title: 'Suitability',
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.healthGoals.isNotEmpty) ...[
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: item.healthGoals.map((goal) {
                return MenuItemAttributeChip(
                  label: goal.label,
                  icon: Icons.health_and_safety_outlined,
                  color: AppColors.accentBrown,
                );
              }).toList(),
            ),
            const SizedBox(width: 16),
          ],
          MenuItemAttributeChip(
            label: item.kidsFriendly
                ? 'Kids Friendly: Yes'
                : 'Kids Friendly: No',
            icon: item.kidsFriendly ? Icons.child_care : Icons.person_outline,
            color: item.kidsFriendly ? AppColors.kidsModeFlowColor : null,
          ),
        ],
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, size: 80, color: AppColors.border),
              const SizedBox(height: 24),
              Text(
                'Dish not found',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'This item may no longer be available.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go('/menu'),
                child: const Text('Back to menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
