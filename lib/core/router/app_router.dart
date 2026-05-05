import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:restauran_recommendation/core/data/models/flow_preferences_model.dart';
import '../../features/flow_selection/qubit/flow_selection_cubit.dart';
import '../../features/menu/presentation/cubit/menu_cubit.dart';
import '../../features/questionnaire/presentation/cubit/questionnaire_cubit.dart';
import '../../features/welcome/presentation/welcome_screen.dart';
import '../../features/flow_selection/presentation/flow_selection_screen.dart';
import '../../features/questionnaire/presentation/screens/questionnaire_screen.dart';

import '../../features/menu/presentation/screens/menu_screen.dart';
import '../di/injection_container.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/flow-selection',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<FlowSelectionCubit>(),
        child: const FlowSelectionScreen(),
      ),
    ),
    GoRoute(
      path: '/questionnaire/:flowType',
      builder: (context, state) {
        final flowType = state.pathParameters['flowType']!;
        return BlocProvider(
          create: (_) => sl<QuestionnaireCubit>(),
          child: QuestionnaireScreen(flowType: flowType.stringToFlowType),
        );
      },
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) {
        return MultiBlocProvider(
          providers: [
            // BlocProvider(create: (_) => sl<FlowSelectionCubit>()),
            BlocProvider(create: (_) => sl<MenuCubit>()),
          ],

          child: MenuScreen(),
        );
      },
    ),
  ],
);
