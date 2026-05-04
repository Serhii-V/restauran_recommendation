import 'dart:ui';

import 'package:restauran_recommendation/core/data/models/flow_preferences_model.dart';

import '../theme/app_theme.dart';

abstract class UIUtils {
  static Color getColorByFlowType(FlowType flowType) {
    switch (flowType) {
      case FlowType.pickForMe:
        return AppColors.pickForFlowColor;
      case FlowType.eatHealthier:
        return AppColors.eatHealthierFlowColor;
      case FlowType.kidsMode:
        return AppColors.kidsModeFlowColor;
      case FlowType.fullMenu:
        return AppColors.background;
    }
  }
}

extension FlowTypeColor on FlowType {
  Color get toFlowColor {
    switch (this) {
      case FlowType.pickForMe:
        return AppColors.pickForFlowColor;
      case FlowType.eatHealthier:
        return AppColors.eatHealthierFlowColor;
      case FlowType.kidsMode:
        return AppColors.kidsModeFlowColor;
      case FlowType.fullMenu:
        return AppColors.background;
    }
  }
}
