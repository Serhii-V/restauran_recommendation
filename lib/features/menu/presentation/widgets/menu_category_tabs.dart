import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/enums/menu_enums.dart';

class MenuCategoryTabs extends StatelessWidget {
  final MenuCategory selectedCategory;
  final Function(MenuCategory) onCategorySelected;

  const MenuCategoryTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: MenuCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: ChoiceChip(
              label: Text(category.label),
              selected: isSelected,
              onSelected: (_) => onCategorySelected(category),
              backgroundColor: Colors.white,
              selectedColor: AppColors.primaryText,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.primaryText,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(
                  color: isSelected ? AppColors.primaryText : AppColors.border,
                ),
              ),
              showCheckmark: false,
            ),
          );
        }).toList(),
      ),
    );
  }
}
