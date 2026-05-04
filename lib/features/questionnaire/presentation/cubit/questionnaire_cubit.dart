import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/data/models/flow_preferences_model.dart';
import '../../../../core/domain/repositories/app_config_repository.dart';
import '../../domain/models/questionnaire_models.dart';
import '../../domain/flows/questionnaire_flows.dart';

class QuestionnaireState extends Equatable {
  final QuestionnaireFlow flow;
  final int currentStepIndex;
  final Map<String, String> answers;
  final bool isCompleted;

  const QuestionnaireState({
    required this.flow,
    this.currentStepIndex = 0,
    this.answers = const {},
    this.isCompleted = false,
  });

  QuestionnaireState copyWith({
    QuestionnaireFlow? flow,
    int? currentStepIndex,
    Map<String, String>? answers,
    bool? isCompleted,
  }) {
    return QuestionnaireState(
      flow: flow ?? this.flow,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      answers: answers ?? this.answers,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [flow, currentStepIndex, answers, isCompleted];
}

class QuestionnaireCubit extends Cubit<QuestionnaireState> {
  QuestionnaireCubit({required this.configRepository})
    : super(
        QuestionnaireState(
          flow: QuestionnaireFlows.allFlows[FlowType.kidsMode]!,
        ),
      ) {
    _loadInitialPreferences();
  }
  final AppConfigRepository configRepository;

  void _loadInitialPreferences() {
    // configRepository.resetConfig();
    final currentConfig = configRepository.currentConfig;
    final QuestionnaireFlow flow =
        QuestionnaireFlows.allFlows[currentConfig.flowType]!;
    emit(QuestionnaireState(flow: flow));
  }

  // void initialize(FlowType flowType) {
  //   final flow = QuestionnaireFlows.allFlows[flowType]!;
  //   emit(QuestionnaireState(flow: flow));
  // }

  void selectAnswer(String answer) {
    final currentQuestion = state.flow.questions[state.currentStepIndex];
    final newAnswers = Map<String, String>.from(state.answers);
    newAnswers[currentQuestion.id] = answer;

    if (state.currentStepIndex < state.flow.questions.length - 1) {
      emit(
        state.copyWith(
          answers: newAnswers,
          currentStepIndex: state.currentStepIndex + 1,
        ),
      );
    } else {
      emit(state.copyWith(answers: newAnswers, isCompleted: true));
    }
  }

  void goBack() {
    if (state.currentStepIndex > 0) {
      emit(state.copyWith(currentStepIndex: state.currentStepIndex - 1));
    }
  }
}
