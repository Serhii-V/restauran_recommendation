import 'package:equatable/equatable.dart';

class Question extends Equatable {
  final String id;
  final String title;
  final List<String> options;

  const Question({
    required this.id,
    required this.title,
    required this.options,
  });

  @override
  List<Object?> get props => [id, title, options];
}

class QuestionnaireFlow extends Equatable {
  final String type;
  final String title;
  final List<Question> questions;

  const QuestionnaireFlow({
    required this.type,
    required this.title,
    required this.questions,
  });

  @override
  List<Object?> get props => [type, title, questions];
}
