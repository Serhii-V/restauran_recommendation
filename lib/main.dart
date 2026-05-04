import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

import 'features/flow_selection/qubit/flow_selection_cubit.dart';
import 'features/preferences/presentation/cubit/recommendation_context_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  await di.init();

  runApp(const RestaurantApp());
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(create: (context) => RecommendationContextCubit()),
        BlocProvider(create: (_) => di.sl<RecommendationContextCubit>()),
        BlocProvider(create: (_) => di.sl<FlowSelectionCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Restaurant Recommendation',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(context),
        routerConfig: appRouter,
      ),
    );
  }
}
