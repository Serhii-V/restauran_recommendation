import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_buttons.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePageContainer(
        scrollable: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const CircularProgressIndicator(
              color: AppColors.accent,
              strokeWidth: 3,
            ),
            const SizedBox(height: 48),
            Text(
              'Just a moment',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'We’re picking the best dishes for you...',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            AppSecondaryButton(
              text: 'Back to Home',
              onPressed: () => context.go('/'),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
