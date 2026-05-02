import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_preferences_state.dart';
import '../../domain/models/preference_enums.dart';

class UserPreferencesCubit extends Cubit<UserPreferencesState> {
  UserPreferencesCubit() : super(const UserPreferencesState());

  void updatePreferences({
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
  }) {
    emit(
      state.copyWith(
        dietaryPreferences: dietaryPreferences,
        majorAllergens: majorAllergens,
      ),
    );
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
