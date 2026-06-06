import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/questionnaire_models.dart';
import '../models/questionnaire_flow_dto.dart';

abstract class QuestionnaireLocalDataSource {
  Future<List<QuestionnaireFlow>> getQuestionnaireFlows();
}

class QuestionnaireLocalDataSourceImpl implements QuestionnaireLocalDataSource {
  @override
  Future<List<QuestionnaireFlow>> getQuestionnaireFlows() async {
    final String response = await rootBundle.loadString(
      'assets/questionnaire/questionnaire_flows.json',
    );

    final decoded = json.decode(response) as Map<String, dynamic>;

    final flows = (decoded['flows'] as List)
        .map(
          (item) => QuestionnaireFlowDto.fromJson(item as Map<String, dynamic>),
        )
        .toList();

    return flows;
  }
}
