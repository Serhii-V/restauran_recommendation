import 'package:equatable/equatable.dart';
import '../../../../core/data/models/flow_preferences_model.dart';

class FlowSelectionState extends Equatable {
  final Set<DietaryPreference> dietaryPreferences;
  final Set<MajorAllergen> majorAllergens;
  final FlowType flowType;

  const FlowSelectionState({
    this.dietaryPreferences = const {},
    this.majorAllergens = const {},
    this.flowType = FlowType.fullMenu,
  });

  FlowSelectionState copyWith({
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
    FlowType? flowType,
  }) {
    return FlowSelectionState(
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      majorAllergens: majorAllergens ?? this.majorAllergens,
      flowType: flowType ?? this.flowType,
    );
  }

  @override
  List<Object?> get props => [dietaryPreferences, majorAllergens, flowType];
}
