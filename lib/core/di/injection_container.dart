import 'package:get_it/get_it.dart';
import '../../features/flow_selection/qubit/flow_selection_cubit.dart';
import '../../features/menu/data/datasources/menu_local_datasource.dart';
import '../../features/menu/data/repositories/menu_repository_impl.dart';
import '../../features/menu/domain/repositories/menu_repository.dart';
import '../../features/menu/domain/usecases/recommendation_service.dart';
import '../../features/menu/presentation/cubit/menu_cubit.dart';
import '../../features/preferences/presentation/cubit/recommendation_context_cubit.dart';
import '../../features/questionnaire/presentation/cubit/questionnaire_cubit.dart';
import '../data/repositories/app_config_repository_impl.dart';
import '../domain/repositories/app_config_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MenuLocalDataSource>(
    () => MenuLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<MenuRepository>(
    () => MenuRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<AppConfigRepository>(
    () => AppConfigRepositoryImpl(),
  );

  sl.registerLazySingleton(() => RecommendationService());

  sl.registerFactory(() => RecommendationContextCubit());

  sl.registerFactory(() => FlowSelectionCubit(configRepository: sl()));
  sl.registerFactory(
    () => MenuCubit(
      repository: sl(),
      configRepository: sl(),
      recommendationService: sl(),
    ),
  );
  sl.registerFactory(() => QuestionnaireCubit(configRepository: sl()));
}
