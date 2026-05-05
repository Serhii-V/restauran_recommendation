import '../../../../core/data/models/flow_preferences_model.dart';
import '../entities/menu_item.dart';
import '../enums/menu_enums.dart';

class RecommendationService {
  List<MenuItem> rankItems({
    required List<MenuItem> items,
    required FlowPreferencesModel currentConfig,
  }) {
    final flowType = currentConfig.flowType;
    final answers = currentConfig.answers;

    var scoredItems = items.map((item) {
      int score = 0;

      switch (flowType) {
        case FlowType.pickForMe:
          score = _calculatePickForMe(item, answers);
          break;
        case FlowType.eatHealthier:
          score = _calculateHealthScore(item, answers);
          break;
        case FlowType.kidsMode:
          score = _calculateKidsScore(item, answers);
          break;
        default:
          score = 0;
      }

      return MapEntry(item, score);
    }).toList();
    scoredItems.sort((a, b) => b.value.compareTo(a.value));
    return scoredItems.map((e) => e.key).toList();
  }

  int _calculatePickForMe(MenuItem item, Map<String, String> answers) {
    int score = 0;

    if (answers['p1'] == 'Classic') {
      if (item.mealStyle == MealStyle.classic) score += 10;
      if (item.id == 'butter_chicken') score += 5;
    } else if (answers['p1'] == 'Adventurous') {
      if (item.mealStyle == MealStyle.adventurous) score += 10;
      if (item.spiceLevel == SpiceLevel.medium ||
          item.spiceLevel == SpiceLevel.hot) {
        score += 3;
      }
    }

    // p2: Spicy food
    if (answers['p2'] == 'Yes') {
      if (item.spiceLevel == SpiceLevel.medium) score += 5;
      if (item.spiceLevel == SpiceLevel.hot) score += 10;
    } else if (answers['p2'] == 'No') {
      if (item.spiceLevel == SpiceLevel.none) {
        score += 10;
      } else {
        score -= 20;
      }
    }

    //  p3: Surprise me?
    if (answers['p3'] == 'Pick something safe') {
      if (item.mealStyle == MealStyle.classic) {
        score += 5;
      }
    }

    return score;
  }

  int _calculateHealthScore(MenuItem item, Map<String, String> answers) {
    int score = 0;

    //  h1: Prioritizing
    if (answers['h1'] == 'High protein' &&
        item.healthGoals.contains(HealthGoal.highProtein)) {
      score += 15;
    }
    if (answers['h1'] == 'Low sugar' &&
        item.healthGoals.contains(HealthGoal.lowSugar)) {
      score += 15;
    }
    if (answers['h1'] == 'Balanced' &&
        item.healthGoals.contains(HealthGoal.balanced)) {
      score += 10;
    }

    //  h2: Meal type
    if (answers['h2'] == 'Light') {
      if (item.portionSize == PortionSize.small ||
          item.portionSize == PortionSize.regular) {
        score += 5;
      }
      if (item.category == MenuCategory.drinks) score += 2;
    } else if (answers['h2'] == 'Filling') {
      if (item.portionSize == PortionSize.large) score += 10;
    }

    //  h3: Rush
    if (answers['h3'] == 'Yes, quick pick' && item.prepTime == PrepTime.quick) {
      score += 10;
    }

    return score;
  }

  int _calculateKidsScore(MenuItem item, Map<String, String> answers) {
    int score = 0;

    if (item.kidsFriendly) {
      score += 20;
    } else {
      score -= 50;
    }

    // k1: Sound good?
    if (answers['k1'] == 'Simple & Mild') {
      if (item.spiceLevel == SpiceLevel.none ||
          item.spiceLevel == SpiceLevel.medium) {
        score += 10;
      }
      if (item.mealStyle == MealStyle.classic) {
        score += 5;
      }
    }

    //  k2: Hungry?
    if (answers['k2'] == 'Very hungry') {
      if (item.portionSize == PortionSize.large ||
          item.portionSize == PortionSize.regular) {
        score += 10;
      }
    } else if (answers['k2'] == 'Just a little') {
      if (item.portionSize == PortionSize.small) score += 10;
    }

    //  k3: Spice
    if (answers['k3'] == 'No spice' && item.spiceLevel != SpiceLevel.none) {
      score -= 50;
    }

    return score;
  }
}
