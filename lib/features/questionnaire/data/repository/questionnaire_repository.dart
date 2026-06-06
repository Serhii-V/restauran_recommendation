import '../../../../core/data/models/flow_preferences_model.dart';
import '../../domain/models/questionnaire_models.dart';
import '../../domain/repository/questionnaire_repository.dart';
import '../datasource/questionnaire_local_datasource.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireLocalDataSource localDataSource;

  QuestionnaireRepositoryImpl({required this.localDataSource});

  @override
  Future<List<QuestionnaireFlow>> getQuestionnaireFlows() {
    return localDataSource.getQuestionnaireFlows();
  }

  @override
  Future<QuestionnaireFlow> getQuestionnaireFlowByType(
    FlowType flowType,
  ) async {
    final flows = await localDataSource.getQuestionnaireFlows();

    return flows.firstWhere((flow) => flow.type == flowType);
  }
}
