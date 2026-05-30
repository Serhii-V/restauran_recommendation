import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/models/questionnaire_models.dart';
import '../../domain/repository/questionnaire_repository.dart';

class GetQuestionnaireFlowUseCase {
  final QuestionnaireRepository repository;

  GetQuestionnaireFlowUseCase({required this.repository});

  Future<QuestionnaireFlow> call(FlowType flowType) {
    return repository.getQuestionnaireFlowByType(flowType);
  }
}
