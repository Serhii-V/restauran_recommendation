import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/enums/menu_enums.dart';

class MenuItemDto {
  static MenuItem fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageAsset: json['imageAsset'] as String,
      category: MenuCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),
      dietaryPreferences: (json['dietaryPreferences'] as List)
          .map((e) => DietaryPreference.values.firstWhere((p) => p.name == e))
          .toSet(),
      allergens: (json['allergens'] as List)
          .map((e) => MajorAllergen.values.firstWhere((a) => a.name == e))
          .toSet(),
      spiceLevel: SpiceLevel.values.firstWhere(
        (e) => e.name == json['spiceLevel'],
      ),
      portionSize: PortionSize.values.firstWhere(
        (e) => e.name == json['portionSize'],
      ),
      mealStyle: MealStyle.values.firstWhere(
        (e) => e.name == json['mealStyle'],
      ),
      healthGoals: (json['healthGoals'] as List)
          .map((e) => HealthGoal.values.firstWhere((g) => g.name == e))
          .toSet(),
      kidsFriendly: json['kidsFriendly'] as bool,
      prepTime: PrepTime.values.firstWhere((e) => e.name == json['prepTime']),
      badges: List<String>.from(json['badges'] as List),
    );
  }
}
