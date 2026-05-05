import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/enums/menu_enums.dart';

class SpiceIndicator extends StatelessWidget {
  final SpiceLevel spiceLevel;

  const SpiceIndicator({super.key, required this.spiceLevel});

  @override
  Widget build(BuildContext context) {
    int activeBars = 0;
    switch (spiceLevel) {
      case SpiceLevel.none:
        activeBars = 0;
        break;
      case SpiceLevel.medium:
        activeBars = 2;
        break;
      case SpiceLevel.hot:
        activeBars = 3;
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(2, (index) {
        final isActive = index < activeBars;
        return Container(
          width: 16,
          height: 6,
          margin: const EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            color: isActive ? AppColors.spiceIndicatorColor : AppColors.border,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
