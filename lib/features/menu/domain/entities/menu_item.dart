import 'package:equatable/equatable.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../enums/menu_enums.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageAsset;
  final MenuCategory category;

  final Set<DietaryPreference> dietaryPreferences;
  final Set<MajorAllergen> allergens;

  final SpiceLevel spiceLevel;
  final PortionSize portionSize;
  final MealStyle mealStyle;
  final Set<HealthGoal> healthGoals;

  final bool kidsFriendly;
  final PrepTime prepTime;

  final List<String> badges;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageAsset,
    required this.category,
    required this.dietaryPreferences,
    required this.allergens,
    required this.spiceLevel,
    required this.portionSize,
    required this.mealStyle,
    required this.healthGoals,
    required this.kidsFriendly,
    required this.prepTime,
    required this.badges,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    imageAsset,
    category,
    dietaryPreferences,
    allergens,
    spiceLevel,
    portionSize,
    mealStyle,
    healthGoals,
    kidsFriendly,
    prepTime,
    badges,
  ];
}
