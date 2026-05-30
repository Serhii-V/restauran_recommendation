import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../questionnaire/domain/models/questionnaire_models.dart';
import '../entities/menu_item.dart';

class RecommendationService {
  List<MenuItem> rankItems({
    required List<MenuItem> items,
    required FlowPreferencesModel currentConfig,
  }) {
    final scoredItems = items.map((item) {
      final score = _calculateScore(item: item, answers: currentConfig.answers);

      return MapEntry(item, score);
    }).toList();

    scoredItems.sort((a, b) => b.value.compareTo(a.value));

    return scoredItems.map((e) => e.key).toList();
  }

  int _calculateScore({
    required MenuItem item,
    required Map<String, QuestionOption> answers,
  }) {
    var score = 0;

    for (final option in answers.values) {
      for (final impactEntry in option.impact.entries) {
        final field = impactEntry.key;
        final values = impactEntry.value;

        for (final valueEntry in values.entries) {
          final expectedValue = valueEntry.key;
          final impactScore = valueEntry.value;

          if (_matchesItem(
            item: item,
            field: field,
            expectedValue: expectedValue,
          )) {
            score += impactScore;
          }
        }
      }
    }

    return score;
  }

  bool _matchesItem({
    required MenuItem item,
    required String field,
    required String expectedValue,
  }) {
    switch (field) {
      case 'mealStyle':
        return item.mealStyle.contains(expectedValue);

      case 'spiceLevel':
        return item.tags.spiceLevel.name == expectedValue;

      case 'healthGoals':
        return item.tags.healthGoals.any((goal) => goal.name == expectedValue);

      case 'portionSize':
        return item.tags.portionSize.name == expectedValue;

      case 'kidsFriendly':
        return item.tags.kidsFriendly.name == expectedValue;

      case 'prepTime':
        return item.tags.prepTime.name == expectedValue;

      case 'category':
        return item.category.name == expectedValue;

      default:
        return false;
    }
  }
}
