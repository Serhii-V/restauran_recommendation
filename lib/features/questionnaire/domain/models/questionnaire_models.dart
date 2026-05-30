import 'package:equatable/equatable.dart';
import 'package:restauran_recommendation/core/data/models/flow_preferences_model.dart';

class QuestionOption extends Equatable {
  final String label;
  final Map<String, Map<String, int>> impact;

  const QuestionOption({required this.label, required this.impact});

  @override
  List<Object?> get props => [label, impact];
}

class Question extends Equatable {
  final String id;
  final String title;
  final List<QuestionOption> options;

  const Question({
    required this.id,
    required this.title,
    required this.options,
  });

  @override
  List<Object?> get props => [id, title, options];
}

class QuestionnaireFlow extends Equatable {
  final FlowType type;
  final String title;
  final String icon;
  final List<Question> questions;

  const QuestionnaireFlow({
    required this.type,
    required this.title,
    required this.icon,
    required this.questions,
  });

  @override
  List<Object?> get props => [type, title, icon, questions];
}
