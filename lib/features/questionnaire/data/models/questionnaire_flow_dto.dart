import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/models/questionnaire_models.dart';

class QuestionnaireFlowDto {
  static QuestionnaireFlow fromJson(Map<String, dynamic> json) {
    return QuestionnaireFlow(
      type: FlowType.values.firstWhere((e) => e.name == json['flow_id']),
      title: json['title'] as String,
      icon: json['icon'] as String,
      questions: (json['questions'] as List)
          .map(
            (questionJson) =>
                QuestionDto.fromJson(questionJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class QuestionDto {
  static Question fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['question_id'] as String,
      title: json['title'] as String,
      options: (json['options'] as List)
          .map(
            (optionJson) =>
                QuestionOptionDto.fromJson(optionJson as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

class QuestionOptionDto {
  static QuestionOption fromJson(Map<String, dynamic> json) {
    return QuestionOption(
      label: json['label'] as String,
      impact: _parseImpact(json['impact'] as Map<String, dynamic>),
    );
  }

  static Map<String, Map<String, int>> _parseImpact(Map<String, dynamic> json) {
    return json.map((categoryKey, categoryValue) {
      final values = categoryValue as Map<String, dynamic>;

      return MapEntry(
        categoryKey,
        values.map((key, value) => MapEntry(key, value as int)),
      );
    });
  }
}
