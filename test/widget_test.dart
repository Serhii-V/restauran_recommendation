import 'package:flutter_test/flutter_test.dart';
import 'package:restauran_recommendation/main.dart';

void main() {
  testWidgets('Welcome screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const RestaurantApp());

    // Verify that our welcome message is present.
    expect(find.text('Welcome'), findsOneWidget);
    expect(find.text('Start Order'), findsOneWidget);
  });
}
