import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../../core/domain/repositories/app_config_repository.dart';
import 'flow_selection_state.dart';

class FlowSelectionCubit extends Cubit<FlowSelectionState> {
  FlowSelectionCubit({required this.configRepository})
    : super(const FlowSelectionState()) {
    _loadInitialPreferences();
  }

  final AppConfigRepository configRepository;

  void _loadInitialPreferences() {
    configRepository.resetConfig();
    final currentConfig = configRepository.currentConfig;
    emit(
      state.copyWith(
        dietaryPreferences: currentConfig.dietaryPreferences,
        majorAllergens: currentConfig.majorAllergens,
        flowType: currentConfig.flowType,
      ),
    );
  }

  void updatePreferences({
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
  }) {
    final currentConfig = configRepository.currentConfig;

    configRepository.setConfig(
      currentConfig.copyWith(
        dietaryPreferences: dietaryPreferences ?? state.dietaryPreferences,
        majorAllergens: majorAllergens ?? state.majorAllergens,
      ),
    );
    emit(
      state.copyWith(
        dietaryPreferences: dietaryPreferences,
        majorAllergens: majorAllergens,
      ),
    );
  }

  void updateFlow(FlowType flowType) {
    final currentConfig = configRepository.currentConfig;
    configRepository.setConfig(currentConfig.copyWith(flowType: flowType));
    emit(state.copyWith(flowType: flowType));
  }

  /// Helper to enforce exclusivity rules for dietary preferences
  static Set<DietaryPreference> resolveExclusivity(
    Set<DietaryPreference> current,
    DietaryPreference newlySelected,
  ) {
    final result = Set<DietaryPreference>.from(current);

    if (result.contains(newlySelected)) {
      result.remove(newlySelected);
      return result;
    }

    // Exclusivity rules: Vegan, Vegetarian, Pescatarian
    const exclusive = {
      DietaryPreference.vegan,
      DietaryPreference.vegetarian,
      DietaryPreference.pescatarian,
    };

    if (exclusive.contains(newlySelected)) {
      result.removeAll(exclusive);
    }

    result.add(newlySelected);
    return result;
  }
}
