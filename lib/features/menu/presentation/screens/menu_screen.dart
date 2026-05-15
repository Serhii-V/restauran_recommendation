import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../flow_selection/qubit/flow_selection_cubit.dart';
import '../../domain/entities/menu_item.dart';
import '../cubit/menu_cubit.dart';
import '../cubit/menu_state.dart';
import '../widgets/menu_item_card.dart';
import '../widgets/menu_category_tabs.dart';
import '../widgets/menu_empty_state.dart';
import '../../domain/enums/menu_enums.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MenuScreenContent();
  }
}

class _MenuScreenContent extends StatelessWidget {
  const _MenuScreenContent();

  @override
  Widget build(BuildContext context) {
    final menuCubit = context.read<MenuCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: menuCubit
            .configRepository
            .currentConfig
            .flowType
            .toFlowColor
            .withValues(alpha: 0.1),
        toolbarHeight: 80,
        centerTitle: true,
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Center(child: const Icon(Icons.home_outlined, size: 40)),
          ),
          onTap: () {
            menuCubit.clearFilters();
            context.go('/');
          },
        ),
        title: Text(
          'KioskMate',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<MenuCubit, MenuState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('Error: ${state.error}'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              final double horizontalPadding = constraints.maxWidth < 600
                  ? 20
                  : 32;
              final int crossAxisCount = constraints.maxWidth < 600
                  ? 1
                  : constraints.maxWidth < 1000
                  ? 2
                  : 3;

              final bool isRecommendationFlow =
                  state.currentConfig.flowType != FlowType.fullMenu;
              final List<MenuItem> displayItems =
                  (isRecommendationFlow && !state.isExpanded)
                  ? state.visibleItems.take(3).toList()
                  : state.visibleItems;

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context, state),
                    const SizedBox(height: 32),
                    MenuCategoryTabs(
                      categories: state.availableCategories,
                      selectedCategory: state.selectedCategory,
                      onCategorySelected: (category) {
                        menuCubit.selectCategory(category);
                      },
                    ),
                    const SizedBox(height: 32),
                    if (displayItems.isEmpty)
                      MenuEmptyState(
                        onClearFilters: () {
                          menuCubit.selectCategory(MenuCategory.all);
                        },
                      )
                    else ...[
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 24,
                          mainAxisSpacing: 24,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: displayItems.length,
                        itemBuilder: (context, index) {
                          return MenuItemCard(item: displayItems[index]);
                        },
                      ),
                      if (isRecommendationFlow &&
                          !state.isExpanded &&
                          state.visibleItems.length > 3)
                        _buildShowMoreButton(context, state),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildShowMoreButton(BuildContext context, MenuState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: GestureDetector(
          onTap: () => context.read<MenuCubit>().toggleExpand(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Show more matches',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, color: AppColors.accent),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, MenuState state) {
    final userPrefs = context.read<FlowSelectionCubit>().state;
    final hasDietary = userPrefs.dietaryPreferences.isNotEmpty;
    final hasAllergens = userPrefs.majorAllergens.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        state.currentConfig.flowType != FlowType.fullMenu
            ? Text(
                'Recommended for you',
                style: Theme.of(context).textTheme.headlineLarge,
              )
            : SizedBox.shrink(),
        const SizedBox(height: 4),
        state.currentConfig.flowType != FlowType.fullMenu
            ? Text(
                'Based on your answers and preferences.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              )
            : SizedBox.shrink(),
        if (hasDietary || hasAllergens) ...[
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (hasDietary)
                _FilterChip(
                  label: '${userPrefs.dietaryPreferences.length} Dietary',
                  icon: Icons.check_circle_outline,
                ),
              if (hasAllergens)
                _FilterChip(
                  label: '${userPrefs.majorAllergens.length} Allergens',
                  icon: Icons.warning_amber_rounded,
                  color: Colors.orange.shade700,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? color;

  const _FilterChip({required this.label, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: (color ?? AppColors.accent).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: (color ?? AppColors.accent).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color ?? AppColors.accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color ?? AppColors.accent,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
