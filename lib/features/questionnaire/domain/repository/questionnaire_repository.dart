import '../../../../core/data/models/flow_preferences_model.dart';
import '../models/questionnaire_models.dart';

abstract class QuestionnaireRepository {
  Future<List<QuestionnaireFlow>> getQuestionnaireFlows();

  Future<QuestionnaireFlow> getQuestionnaireFlowByType(FlowType flowType);
}
