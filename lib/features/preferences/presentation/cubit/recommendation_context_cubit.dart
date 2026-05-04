import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/models/flow_preferences_model.dart';

class RecommendationContext extends Equatable {
  final FlowType? flowType;
  final Map<String, String> answers;

  const RecommendationContext({this.flowType, this.answers = const {}});

  @override
  List<Object?> get props => [flowType, answers];
}

class RecommendationContextCubit extends Cubit<RecommendationContext> {
  RecommendationContextCubit() : super(const RecommendationContext());

  void updateContext({FlowType? flowType, Map<String, String>? answers}) {
    emit(
      RecommendationContext(
        flowType: flowType ?? state.flowType,
        answers: answers ?? state.answers,
      ),
    );
  }

  void clear() {
    emit(const RecommendationContext());
  }
}
