import 'package:equatable/equatable.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../enums/menu_enums.dart';
import 'menu_tags.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageAsset;
  final MenuCategory category;

  final Set<DietaryPreference> dietaryPreferences;
  final Set<MajorAllergen> allergens;
  final List<String> mealStyle;
  final MenuTags tags;
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
    required this.mealStyle,
    required this.tags,
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
    mealStyle,
    tags,
    badges,
  ];
}
