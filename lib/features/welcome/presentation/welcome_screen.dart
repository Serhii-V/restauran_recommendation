import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/app_info_row.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../../core/theme/app_theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsivePageContainer(
        scrollable: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(flex: 3, child: SizedBox.expand()),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Text(
              'Order safely, easily, and your way.',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.secondaryText),
              textAlign: TextAlign.center,
            ),
            Flexible(flex: 1, child: SizedBox.expand()),

            AppPrimaryButton(
              text: 'Start Order',
              onPressed: () => context.push('/flow-selection'),
            ),
            // AppSecondaryButton(
            //   text: 'Dietary & Health',
            //   onPressed: () => context.push('/flow-selection'),
            // ),
            Flexible(flex: 1, child: SizedBox.expand()),
            const AppInfoRow(
              icon: Icons.qr_code_scanner,
              text: 'Order on Your Phone',
            ),
            Text(
              'Touch, speak, or use your phone to order',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            Flexible(flex: 3, child: SizedBox.expand()),
            Flexible(
              flex: 1,
              child: Text(
                'Food suggestions only. Not medical advice',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),
            Flexible(flex: 1, child: SizedBox.expand()),
          ],
        ),
      ),
    );
  }
}
