import 'package:equatable/equatable.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/enums/menu_enums.dart';

class MenuState extends Equatable {
  final List<MenuItem> allItems;
  final List<MenuItem> visibleItems;
  final MenuCategory selectedCategory;
  final bool isLoading;
  final String? error;
  final FlowPreferencesModel currentConfig;

  const MenuState({
    this.allItems = const [],
    this.visibleItems = const [],
    this.selectedCategory = MenuCategory.all,
    this.isLoading = false,
    this.error,
    this.currentConfig = const FlowPreferencesModel(),
  });

  MenuState copyWith({
    List<MenuItem>? allItems,
    List<MenuItem>? visibleItems,
    MenuCategory? selectedCategory,
    bool? isLoading,
    String? error,
    FlowPreferencesModel? currentConfig,
    FlowType? currentFlowType,
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
  }) {
    return MenuState(
      allItems: allItems ?? this.allItems,
      visibleItems: visibleItems ?? this.visibleItems,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentConfig: currentConfig ?? this.currentConfig,
    );
  }

  @override
  List<Object?> get props => [
    allItems,
    visibleItems,
    selectedCategory,
    isLoading,
    error,
    currentConfig,
  ];
}
