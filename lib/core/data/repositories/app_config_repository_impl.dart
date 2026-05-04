import '../../domain/repositories/app_config_repository.dart';
import '../models/flow_preferences_model.dart';

class AppConfigRepositoryImpl implements AppConfigRepository {
  FlowPreferencesModel _config = FlowPreferencesModel();

  @override
  FlowPreferencesModel get currentConfig => _config;

  @override
  void setConfig(FlowPreferencesModel config) => _config = config;

  @override
  void resetConfig() => _config = FlowPreferencesModel();
}
