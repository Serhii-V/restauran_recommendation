import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../../core/domain/repositories/app_config_repository.dart';
import 'menu_state.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/enums/menu_enums.dart';
import '../../domain/repositories/menu_repository.dart';
import '../../../preferences/presentation/cubit/recommendation_context_cubit.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository repository;
  final AppConfigRepository configRepository;

  MenuCubit({required this.repository, required this.configRepository})
    : super(const MenuState());

  Future<void> init(MenuMode mode, RecommendationContext recContext) async {
    emit(state.copyWith(isLoading: true, mode: mode));
    try {
      final items = await repository.getMenuItems();
      final FlowPreferencesModel currentConfig = configRepository.currentConfig;
      emit(
        state.copyWith(
          allItems: items,
          isLoading: false,
          currentConfig: currentConfig,
        ),
      );
      applyFilters(currentConfig, recContext);
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void selectCategory(MenuCategory category, RecommendationContext recContext) {
    final FlowPreferencesModel currentConfig = configRepository.currentConfig;
    emit(state.copyWith(selectedCategory: category));
    applyFilters(currentConfig, recContext);
  }

  void applyFilters(
    FlowPreferencesModel currentConfig,
    RecommendationContext recContext,
  ) {
    List<MenuItem> filtered = List.from(state.allItems);

    // 1. Hard Filters: Allergens (Exclusion)
    if (currentConfig.majorAllergens.isNotEmpty) {
      filtered = filtered.where((item) {
        return !item.allergens.any(
          (a) => currentConfig.majorAllergens.contains(a),
        );
      }).toList();
    }

    // 2. Hard Filters: Dietary Preferences (Inclusion)
    if (currentConfig.dietaryPreferences.isNotEmpty) {
      filtered = filtered.where((item) {
        return currentConfig.dietaryPreferences.every((pref) {
          if (item.dietaryPreferences.contains(pref)) return true;
          // Vegan counts as Vegetarian
          if (pref == DietaryPreference.vegetarian &&
              item.dietaryPreferences.contains(DietaryPreference.vegan)) {
            return true;
          }
          // Dairy-Free can be satisfied by Vegan
          if (pref == DietaryPreference.dairyFree &&
              item.dietaryPreferences.contains(DietaryPreference.vegan)) {
            return true;
          }
          return false;
        });
      }).toList();
    }

    // 3. Category Filter
    if (state.selectedCategory != MenuCategory.all) {
      filtered = filtered
          .where((item) => item.category == state.selectedCategory)
          .toList();
    }

    // 4. Recommendation Scoring (only in recommended mode)
    if (state.mode == MenuMode.recommended) {
      final scoredItems = filtered.map((item) {
        return MapEntry(item, _calculateScore(item, recContext));
      }).toList();

      scoredItems.sort((a, b) => b.value.compareTo(a.value));
      filtered = scoredItems.map((e) => e.key).toList();
    }

    emit(state.copyWith(visibleItems: filtered));
  }

  int _calculateScore(MenuItem item, RecommendationContext context) {
    int score = 0;
    final answers = context.answers;

    if (context.flowType == FlowType.pickForMe) {
      if (answers['p1'] == 'Classic' && item.mealStyle == MealStyle.classic) {
        score += 3;
      }
      if (answers['p1'] == 'Adventurous' &&
          item.mealStyle == MealStyle.adventurous) {
        score += 3;
      }
      if (answers['p2'] == 'Yes' &&
          (item.spiceLevel == SpiceLevel.medium ||
              item.spiceLevel == SpiceLevel.hot)) {
        score += 3;
      }
      if (answers['p2'] == 'A little' && item.spiceLevel == SpiceLevel.mild) {
        score += 3;
      }
      if (answers['p2'] == 'No' && item.spiceLevel == SpiceLevel.none) {
        score += 3;
      }

      if (answers['p3'] == 'Pick something safe' &&
          item.mealStyle == MealStyle.classic &&
          item.spiceLevel == SpiceLevel.none) {
        score += 2;
      }
    }

    if (context.flowType == FlowType.eatHealthier) {
      if (answers['h1'] == 'High protein' &&
          item.healthGoals.contains(HealthGoal.highProtein)) {
        score += 4;
      }
      if (answers['h1'] == 'Low sugar' &&
          item.healthGoals.contains(HealthGoal.lowSugar)) {
        score += 4;
      }
      if (answers['h1'] == 'Balanced' &&
          item.healthGoals.contains(HealthGoal.balanced)) {
        score += 4;
      }
      if (answers['h1'] == 'Just something tasty' &&
          item.healthGoals.contains(HealthGoal.tasty)) {
        score += 2;
      }

      if (answers['h2'] == 'Light' &&
          (item.portionSize == PortionSize.light ||
              item.portionSize == PortionSize.snack)) {
        score += 3;
      }
      if (answers['h2'] == 'Filling' &&
          (item.portionSize == PortionSize.filling ||
              item.portionSize == PortionSize.regular)) {
        score += 3;
      }

      if (answers['h3'] == 'Yes, quick pick' &&
          item.prepTime == PrepTime.quick) {
        score += 3;
      }
    }

    if (context.flowType == FlowType.kidsMode) {
      if (answers['k1'] == 'Simple & Mild' &&
          item.kidsFriendly &&
          item.spiceLevel == SpiceLevel.none) {
        score += 4;
      }
      if (answers['k1'] == 'Fun & Tasty' &&
          item.kidsFriendly &&
          item.healthGoals.contains(HealthGoal.tasty)) {
        score += 4;
      }
      if (answers['k1'] == 'Light & Fresh' &&
          (item.portionSize == PortionSize.light ||
              item.healthGoals.contains(HealthGoal.balanced))) {
        score += 3;
      }

      if (answers['k2'] == 'No spice' && item.spiceLevel == SpiceLevel.none) {
        score += 3;
      }
      if (answers['k2'] == 'A little' && item.spiceLevel == SpiceLevel.mild) {
        score += 3;
      }
    }

    return score;
  }
}
