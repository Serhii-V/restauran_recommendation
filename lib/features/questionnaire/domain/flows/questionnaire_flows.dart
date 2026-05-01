import '../models/questionnaire_models.dart';

class QuestionnaireFlows {
  static const String pickForMe = 'pickForMe';
  static const String health = 'health';
  static const String kids = 'kids';

  static final Map<String, QuestionnaireFlow> allFlows = {
    pickForMe: const QuestionnaireFlow(
      type: pickForMe,
      title: 'Pick For Me',
      questions: [
        Question(
          id: 'p1',
          title: 'Do you want something...',
          options: ['Classic', 'Adventurous'],
        ),
        Question(
          id: 'p2',
          title: 'Do you like spicy food?',
          options: ['Yes', 'A little', 'No'],
        ),
        Question(
          id: 'p3',
          title: 'Surprise me?',
          options: ['Yes', 'Pick something safe'],
        ),
      ],
    ),
    health: const QuestionnaireFlow(
      type: health,
      title: 'Health Mode',
      questions: [
        Question(
          id: 'h1',
          title: 'What are you prioritizing today?',
          options: [
            'High protein',
            'Low sugar',
            'Balanced',
            'Just something tasty',
          ],
        ),
        Question(
          id: 'h2',
          title: 'What kind of meal do you want?',
          options: ['Light', 'Filling', 'I don’t care'],
        ),
        Question(
          id: 'h3',
          title: 'Are you in a rush?',
          options: ['Yes, quick pick', 'I\'ve got time'],
        ),
      ],
    ),
    kids: const QuestionnaireFlow(
      type: kids,
      title: 'Kids Mode',
      questions: [
        Question(
          id: 'k1',
          title: 'What kind of food sounds good?',
          options: [
            'Simple & Mild',
            'Fun & Tasty',
            'Light & Fresh',
            'Surprise me',
          ],
        ),
        Question(
          id: 'k2',
          title: 'How hungry are they?',
          options: ['Just a little', 'Regular meal', 'Very hungry'],
        ),
        Question(
          id: 'k3',
          title: 'Any spice?',
          options: ['No spice', 'A little', 'Doesn’t matter'],
        ),
      ],
    ),
  };
}
