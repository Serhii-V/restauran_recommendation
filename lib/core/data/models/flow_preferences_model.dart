import 'package:equatable/equatable.dart';

import '../../../features/questionnaire/domain/models/questionnaire_models.dart';

class FlowPreferencesModel extends Equatable {
  final Set<DietaryPreference> dietaryPreferences;
  final Set<MajorAllergen> majorAllergens;
  final FlowType flowType;
  final Map<String, QuestionOption> answers;

  const FlowPreferencesModel({
    this.dietaryPreferences = const {},
    this.majorAllergens = const {},
    this.flowType = FlowType.fullMenu,
    this.answers = const {},
  });

  FlowPreferencesModel copyWith({
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
    FlowType? flowType,
    Map<String, QuestionOption>? answers,
  }) {
    return FlowPreferencesModel(
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      majorAllergens: majorAllergens ?? this.majorAllergens,
      flowType: flowType ?? this.flowType,
      answers: answers ?? this.answers,
    );
  }

  @override
  List<Object?> get props => [
    dietaryPreferences,
    majorAllergens,
    flowType,
    answers,
  ];
}

enum DietaryPreference {
  vegan('Vegan'),
  vegetarian('Vegetarian'),
  pescatarian('Pescatarian'),
  keto('Keto'),
  paleo('Paleo'),
  lowCarb('Low Carb'),
  dairyFree('Dairy-Free'),
  glutenFree('Gluten-Free'),
  halal('Halal'),
  kosher('Kosher');

  final String label;
  const DietaryPreference(this.label);
}

enum MajorAllergen {
  dairy('Dairy'),
  eggs('Eggs'),
  wheat('Wheat'),
  gluten('Gluten'),
  soy('Soy'),
  peanuts('Peanuts'),
  treeNuts('Tree Nuts'),
  fish('Fish'),
  shellfish('Shellfish'),
  sesame('Sesame'),
  corn('Corn');

  final String label;
  const MajorAllergen(this.label);
}

enum FlowType {
  pickForMe('Pick For Me'),
  eatHealthier('Eat Healthier'),
  kidsMode('Kids Mode'),
  fullMenu('Full Menu');

  final String label;
  const FlowType(this.label);
}

extension FlowTypeExtension on String {
  FlowType get stringToFlowType {
    switch (this) {
      case 'pickForMe':
        return FlowType.pickForMe;
      case 'health':
        return FlowType.eatHealthier;
      case 'kids':
        return FlowType.kidsMode;
      default:
        return FlowType.fullMenu;
    }
  }
}
