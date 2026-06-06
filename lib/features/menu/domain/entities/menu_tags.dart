import 'package:equatable/equatable.dart';

import '../enums/menu_enums.dart';

class MenuTags extends Equatable {
  final SpiceLevel spiceLevel;
  final PortionSize portionSize;
  final Set<HealthGoal> healthGoals;
  final KidsFriendly kidsFriendly;
  final PrepTime prepTime;

  const MenuTags({
    required this.spiceLevel,
    required this.portionSize,
    required this.healthGoals,
    required this.kidsFriendly,
    required this.prepTime,
  });

  @override
  List<Object?> get props => [
    spiceLevel,
    portionSize,
    healthGoals,
    kidsFriendly,
    prepTime,
  ];
}
