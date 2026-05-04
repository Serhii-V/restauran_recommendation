import '../../data/models/flow_preferences_model.dart';

abstract class AppConfigRepository {
  FlowPreferencesModel get currentConfig;

  void setConfig(FlowPreferencesModel mode);

  void resetConfig();
}
