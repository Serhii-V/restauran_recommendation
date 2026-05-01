import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  QuestionnaireCubit(String flowType)
    : super(QuestionnaireState(flow: QuestionnaireFlows.allFlows[flowType]!));

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
