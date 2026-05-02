import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/extensions/app_layout.dart';
import '../../../core/widgets/responsive_page_container.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../preferences/domain/models/preference_enums.dart';
import '../../preferences/presentation/cubit/user_preferences_cubit.dart';
import '../../preferences/presentation/cubit/user_preferences_state.dart';
import '../../preferences/presentation/widgets/preference_modal.dart';

class FlowSelectionScreen extends StatelessWidget {
  const FlowSelectionScreen({super.key});

  void _showComingSoon(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Full menu is coming soon',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'We’re working on bringing the full browsing experience. \nFor now, try “Pick for Me” to get quick suggestions.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppPrimaryButton(
              text: 'Got it',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDietaryPreferences(BuildContext context) {
    final cubit = context.read<UserPreferencesCubit>();
    final heightFactor = AppLayout.bottomSheetHeightFactor(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: heightFactor,
        child: PreferenceModal<DietaryPreference>(
          title: 'Dietary Preferences',
          options: DietaryPreference.values,
          initialSelection: cubit.state.dietaryPreferences,
          labelBuilder: (p) => p.label,
          exclusivityResolver: UserPreferencesCubit.resolveExclusivity,
          onConfirm: (selected) {
            cubit.updatePreferences(dietaryPreferences: selected);
          },
        ),
      ),
    );
  }

  void _showMajorAllergens(BuildContext context) {
    final cubit = context.read<UserPreferencesCubit>();
    final heightFactor = AppLayout.bottomSheetHeightFactor(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FractionallySizedBox(
        heightFactor: heightFactor,
        child: PreferenceModal<MajorAllergen>(
          title: 'Major Allergens',
          options: MajorAllergen.values,
          initialSelection: cubit.state.majorAllergens,
          labelBuilder: (a) => a.label,
          onConfirm: (selected) {
            cubit.updatePreferences(majorAllergens: selected);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: InkWell(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Center(child: const Icon(Icons.arrow_back_sharp, size: 40)),
          ),
          onTap: () => context.pop(),
        ),
      ),
      body: ResponsivePageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How would you like to order?',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Choose the experience that fits you right now',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.secondaryText,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 56),
            _FlowOptionCard(
              icon: Image.asset(
                'assets/icons/pick_for_me_icon.png',
                width: 50,
                height: 50,
              ),
              title: 'Pick For Me',
              subtitle:
                  'Answer a few quick questions and get instant suggestions.',
              onTap: () => context.push('/questionnaire/pickForMe'),
              backgroundColor: AppColors.pickForFlowColor,
            ),
            const SizedBox(height: 16),
            _FlowOptionCard(
              icon: Image.asset(
                'assets/icons/eat_healthier_icon.png',
                width: 50,
                height: 50,
              ),
              title: 'Eat Healthier',
              subtitle: 'Find options that match your health goals',
              onTap: () => context.push('/questionnaire/health'),
              backgroundColor: AppColors.eatHealthierFlowColor,
            ),
            const SizedBox(height: 16),
            _FlowOptionCard(
              icon: Image.asset(
                'assets/icons/kids_mode_icon.png',
                width: 50,
                height: 50,
              ),
              title: 'Kids Mode',
              subtitle: 'Simple choices made for kids.',
              onTap: () => context.push('/questionnaire/kids'),
              backgroundColor: AppColors.kidsModeFlowColor,
            ),
            const SizedBox(height: 24),
            BlocBuilder<UserPreferencesCubit, UserPreferencesState>(
              builder: (context, state) {
                final dietaryCount = state.dietaryPreferences.length;
                final allergenCount = state.majorAllergens.length;
                final buttonsSpace = AppLayout.rowButtonsSpace(context);

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => _showDietaryPreferences(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(8),
                        foregroundColor: AppColors.primaryText,
                        backgroundColor: dietaryCount > 0
                            ? const Color(0xFFF9F9F7)
                            : null,
                        side: BorderSide(
                          color: allergenCount > 0
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                        minimumSize: Size(40, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        dietaryCount > 0
                            ? 'Dietary Preferences · $dietaryCount'
                            : 'Dietary Preferences',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    SizedBox(width: buttonsSpace),
                    OutlinedButton(
                      onPressed: () => _showMajorAllergens(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(8),

                        foregroundColor: AppColors.primaryText,
                        backgroundColor: allergenCount > 0
                            ? const Color(0xFFF9F9F7)
                            : null,
                        side: BorderSide(
                          color: allergenCount > 0
                              ? AppColors.accent
                              : AppColors.border,
                        ),
                        minimumSize: Size(40, 64),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        allergenCount > 0
                            ? 'Major Allergens · $allergenCount'
                            : 'Major Allergens',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 64),
            TextButton(
              onPressed: () => _showComingSoon(context),
              child: Text(
                'Skip and browse full menu',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(color: AppColors.accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FlowOptionCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const _FlowOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor?.withValues(alpha: 0.2) ?? AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: icon,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.border),
          ],
        ),
      ),
    );
  }
}
