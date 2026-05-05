import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../../core/domain/repositories/app_config_repository.dart';
import '../../domain/usecases/recommendation_service.dart';
import 'menu_state.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/enums/menu_enums.dart';
import '../../domain/repositories/menu_repository.dart';

class MenuCubit extends Cubit<MenuState> {
  final MenuRepository repository;
  final AppConfigRepository configRepository;
  final RecommendationService recommendationService;

  MenuCubit({
    required this.repository,
    required this.configRepository,
    required this.recommendationService,
  }) : super(const MenuState());

  Future<void> init() async {
    emit(state.copyWith(isLoading: true));
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

      applyFilters();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void selectCategory(MenuCategory category) {
    final latestConfig = configRepository.currentConfig;

    emit(
      state.copyWith(selectedCategory: category, currentConfig: latestConfig),
    );
    applyFilters();
  }

  void clearFilters() {
    configRepository.resetConfig();
    emit(
      state.copyWith(
        selectedCategory: MenuCategory.all,
        currentConfig: configRepository.currentConfig,
      ),
    );
    applyFilters();
  }

  void applyFilters() {
    final currentConfig = configRepository.currentConfig;
    List<MenuItem> filtered = List.from(state.allItems);

    // Step 1: Exclusion (Allergens)
    if (currentConfig.majorAllergens.isNotEmpty) {
      filtered = filtered.where((item) {
        return !item.allergens.any(
          (a) => currentConfig.majorAllergens.contains(a),
        );
      }).toList();
    }

    // Step 2: Inclusion (Dietary Preferences)
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

    // Step 3: recommendation service ranking (if not full menu flow)
    if (currentConfig.flowType != FlowType.fullMenu) {
      filtered = recommendationService.rankItems(
        items: filtered,
        currentConfig: currentConfig,
      );
    }

    // Step 4: Category Calculation (Identify available categories)
    final categoriesWithItems = filtered
        .map((item) => item.category)
        .toSet()
        .toList();
    categoriesWithItems.sort((a, b) => a.index.compareTo(b.index));

    final List<MenuCategory> availableCats = [
      MenuCategory.all,
      ...categoriesWithItems,
    ];

    // Step 5: Category Selection (Apply category filter and reset if needed)
    MenuCategory categoryToApply = state.selectedCategory;
    if (categoryToApply != MenuCategory.all &&
        !categoriesWithItems.contains(categoryToApply)) {
      categoryToApply = MenuCategory.all;
    }

    if (categoryToApply != MenuCategory.all) {
      filtered = filtered
          .where((item) => item.category == categoryToApply)
          .toList();
    }

    emit(
      state.copyWith(
        visibleItems: filtered,
        availableCategories: availableCats,
        selectedCategory: categoryToApply,
        currentConfig: currentConfig,
      ),
    );
  }
}
