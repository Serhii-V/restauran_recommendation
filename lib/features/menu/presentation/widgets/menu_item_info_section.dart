import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class MenuItemInfoSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget content;
  final EdgeInsetsGeometry padding;

  const MenuItemInfoSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.content,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.secondaryText),
            ),
          ],
          const SizedBox(height: 16),
          content,
        ],
      ),
    );
  }
}
