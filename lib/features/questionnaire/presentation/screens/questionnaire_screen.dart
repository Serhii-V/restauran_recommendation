import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restauran_recommendation/core/theme/app_theme.dart';
import '../cubit/questionnaire_cubit.dart';
import '../widgets/questionnaire_widgets.dart';
import '../../../../core/widgets/responsive_page_container.dart';

class QuestionnaireScreen extends StatelessWidget {
  final String flowType;

  const QuestionnaireScreen({super.key, required this.flowType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionnaireCubit(flowType),
      child: BlocConsumer<QuestionnaireCubit, QuestionnaireState>(
        listener: (context, state) {
          if (state.isCompleted) {
            context.go('/loading');
          }
        },
        builder: (context, state) {
          final currentQuestion = state.flow.questions[state.currentStepIndex];

          return Scaffold(
            appBar: AppBar(
              backgroundColor: colorByType(flowType).withValues(alpha: 0.1),
              title: Text(state.flow.title),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
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
                    totalSteps: state.flow.questions.length,
                    currentStep: state.currentStepIndex,
                    activeColor: colorByType(flowType),
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
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 48),
                              ...currentQuestion.options.map((option) {
                                return AppOptionCard(
                                  title: option,
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
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

Color colorByType(String flowType) {
  switch (flowType) {
    case 'pickForMe':
      return AppColors.pickForFlowColor;
    case 'health':
      return AppColors.eatHealthierFlowColor;
    case 'kids':
      return AppColors.kidsModeFlowColor;
    default:
      return AppColors.accent;
  }
}
