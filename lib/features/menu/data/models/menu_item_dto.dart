import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/menu_tags.dart';
import '../../domain/enums/menu_enums.dart';

class MenuItemDto {
  static MenuItem fromJson(Map<String, dynamic> json) {
    final tagsJson = json['tags'] as Map<String, dynamic>;

    return MenuItem(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageAsset: json['imageAsset'],

      category: MenuCategory.values.firstWhere(
        (e) => e.name == json['category'],
      ),

      dietaryPreferences: (json['dietaryPreferences'] as List)
          .map((e) => DietaryPreference.values.firstWhere((p) => p.name == e))
          .toSet(),

      allergens: (json['allergens'] as List)
          .map((e) => MajorAllergen.values.firstWhere((a) => a.name == e))
          .toSet(),

      mealStyle: List<String>.from(json['mealStyle'] as List),

      tags: MenuTags(
        spiceLevel: SpiceLevel.values.firstWhere(
          (e) => e.name == tagsJson['spiceLevel'],
        ),

        portionSize: PortionSize.values.firstWhere(
          (e) => e.name == tagsJson['portionSize'],
        ),

        healthGoals: {
          HealthGoal.values.firstWhere(
            (e) => e.name == tagsJson['healthGoals'],
          ),
        },

        kidsFriendly: KidsFriendly.values.firstWhere(
          (e) => e.name == tagsJson['kidsFriendly'],
        ),

        prepTime: PrepTime.values.firstWhere(
          (e) => e.name == tagsJson['prepTime'],
        ),
      ),

      badges: const [],
    );
  }
}
