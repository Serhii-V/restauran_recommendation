import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/domain/repositories/app_config_repository.dart';
import '../../domain/models/questionnaire_models.dart';
import '../../domain/usecases/get_questionnaire_flow_use_case.dart';

class QuestionnaireState extends Equatable {
  final QuestionnaireFlow? flow;
  final int currentStepIndex;
  final Map<String, QuestionOption> answers;
  final bool isCompleted;
  final bool isLoading;
  final String? errorMessage;

  const QuestionnaireState({
    this.flow,
    this.currentStepIndex = 0,
    this.answers = const {},
    this.isCompleted = false,
    this.isLoading = false,
    this.errorMessage,
  });

  QuestionnaireState copyWith({
    QuestionnaireFlow? flow,
    int? currentStepIndex,
    Map<String, QuestionOption>? answers,
    bool? isCompleted,
    bool? isLoading,
    String? errorMessage,
  }) {
    return QuestionnaireState(
      flow: flow ?? this.flow,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    flow,
    currentStepIndex,
    answers,
    isCompleted,
    isLoading,
    errorMessage,
  ];
}

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  final AppConfigRepository configRepository;
  final GetQuestionnaireFlowUseCase getQuestionnaireFlowUseCase;

  QuestionnaireCubit({
    required this.configRepository,
    required this.getQuestionnaireFlowUseCase,
  }) : super(const QuestionnaireState()) {
    loadFlow();
  }

  Future<void> loadFlow() async {
    emit(state.copyWith(isLoading: true));

    try {
      final currentConfig = configRepository.currentConfig;
      final flow = await getQuestionnaireFlowUseCase(currentConfig.flowType);

      emit(QuestionnaireState(flow: flow, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void selectAnswer(QuestionOption option) {
    final flow = state.flow;

    if (flow == null) {
      return;
    }
    final currentQuestion = flow.questions[state.currentStepIndex];

    final newAnswers = Map<String, QuestionOption>.from(state.answers);
    newAnswers[currentQuestion.id] = option;

    if (state.currentStepIndex < flow.questions.length - 1) {
      emit(
        state.copyWith(
          answers: newAnswers,
          currentStepIndex: state.currentStepIndex + 1,
        ),
      );
    } else {
      final finalConfig = configRepository.currentConfig.copyWith(
        answers: newAnswers,
      );

      configRepository.setConfig(finalConfig);
      emit(state.copyWith(answers: newAnswers, isCompleted: true));
    }
  }

  void goBack() {
    if (state.currentStepIndex > 0) {
      emit(state.copyWith(currentStepIndex: state.currentStepIndex - 1));
    }
  }
}
