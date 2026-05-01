import 'package:equatable/equatable.dart';
import '../../domain/models/preference_enums.dart';

class UserPreferencesState extends Equatable {
  final Set<DietaryPreference> dietaryPreferences;
  final Set<MajorAllergen> majorAllergens;

  const UserPreferencesState({
    this.dietaryPreferences = const {},
    this.majorAllergens = const {},
  });

  UserPreferencesState copyWith({
    Set<DietaryPreference>? dietaryPreferences,
    Set<MajorAllergen>? majorAllergens,
  }) {
    return UserPreferencesState(
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      majorAllergens: majorAllergens ?? this.majorAllergens,
    );
  }

  @override
  List<Object?> get props => [dietaryPreferences, majorAllergens];
}
