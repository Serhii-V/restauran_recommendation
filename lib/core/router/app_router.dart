import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/welcome/presentation/welcome_screen.dart';
import '../../features/flow_selection/presentation/flow_selection_screen.dart';
import '../../features/questionnaire/presentation/screens/questionnaire_screen.dart';
import '../../features/loading/presentation/loading_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/flow-selection',
      builder: (context, state) => const FlowSelectionScreen(),
    ),
    GoRoute(
      path: '/questionnaire/:flowType',
      builder: (context, state) {
        final flowType = state.pathParameters['flowType']!;
        return QuestionnaireScreen(flowType: flowType);
      },
    ),
    GoRoute(
      path: '/loading',
      builder: (context, state) => const LoadingScreen(),
    ),
  ],
);
