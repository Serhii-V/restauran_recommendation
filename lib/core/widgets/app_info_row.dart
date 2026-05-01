import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const AppInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.secondaryText, size: 20),
        const SizedBox(width: 12),
        Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
