import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restauran_recommendation/core/data/models/flow_preferences_model.dart';
import 'package:restauran_recommendation/core/theme/app_theme.dart';
import 'package:restauran_recommendation/core/utils/ui_utils.dart';
import '../cubit/questionnaire_cubit.dart';
import '../widgets/questionnaire_widgets.dart';
import '../../../../core/widgets/responsive_page_container.dart';
import '../../../preferences/presentation/cubit/recommendation_context_cubit.dart';

class QuestionnaireScreen extends StatelessWidget {
  final FlowType flowType;

  const QuestionnaireScreen({super.key, required this.flowType});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
      listener: (context, state) {
        if (state.isCompleted) {
          context.read<RecommendationContextCubit>().updateContext(
            flowType: flowType,
            answers: state.answers,
          );
          context.go('/menu');
        }
      },
      builder: (context, state) {
        if (state.isLoading || state.flow == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final flow = state.flow!;
        final currentQuestion = flow.questions[state.currentStepIndex];

        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: flowType.toFlowColor.withValues(alpha: 0.1),
            title: Text(flow.title),
            leading: InkWell(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Center(
                  child: const Icon(Icons.arrow_back_sharp, size: 40),
                ),
              ),
              onTap: () {
                if (state.currentStepIndex > 0) {
                  context.read<QuestionnaireCubit>().goBack();
                } else {
                  context.pop();
                }
              },
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16,
                ),
                child: QuestionnaireProgress(
                  totalSteps: flow.questions.length,
                  currentStep: state.currentStepIndex,
                  activeColor: flowType.toFlowColor,
                ),
              ),
              Expanded(
                child: ResponsivePageContainer(
                  child: Column(
                    children: [
                      const SizedBox(height: 64),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.1, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                        child: Column(
                          key: ValueKey<int>(state.currentStepIndex),
                          children: [
                            Text(
                              currentQuestion.title,
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 48),
                            ...currentQuestion.options.map((option) {
                              return AppOptionCard(
                                title: option.label,
                                onTap: () => context
                                    .read<QuestionnaireCubit>()
                                    .selectAnswer(option),
                              );
                            }),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                'Food suggestions only. Not medical advice',
                style: TextStyle(color: AppColors.secondaryText, fontSize: 12),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

// Color colorByType(String flowType) {
//   switch (flowType) {
//     case 'pickForMe':
//       return AppColors.pickForFlowColor;
//     case 'health':
//       return AppColors.eatHealthierFlowColor;
//     case 'kids':
//       return AppColors.kidsModeFlowColor;
//     default:
//       return AppColors.background;
//   }
// }
