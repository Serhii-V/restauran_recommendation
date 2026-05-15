import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/menu_item.dart';
import 'menu_badge.dart';

class MenuItemDetailsHeader extends StatelessWidget {
  final MenuItem item;
  final bool isTabletLandscape;

  const MenuItemDetailsHeader({
    super.key,
    required this.item,
    this.isTabletLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    final double borderRadius = isTabletLandscape ? 24 : 0;

    return Stack(
      children: [
        Hero(
          tag: 'item_image_${item.id}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: AspectRatio(
              aspectRatio: isTabletLandscape ? 1 : 16 / 10,
              child: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.border,
                  child: const Icon(
                    Icons.restaurant,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (item.badges.isNotEmpty)
          Positioned(
            top: 20,
            left: 20,
            child: Wrap(
              spacing: 8,
              children: item.badges.map((b) => MenuBadge(label: b)).toList(),
            ),
          ),
      ],
    );
  }
}
