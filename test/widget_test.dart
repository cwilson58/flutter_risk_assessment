// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:risk_assessment/main.dart';
import 'package:risk_assessment/riskCalculator.dart';

void main() {
  testWidgets('Assess button not visible during assessment',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that our app has started and the button exists
    //expect(find.byKey(Key('AssessButton')), findsOneWidget);

    // Tap the 'assess' button and trigger a frame.
    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();

    // Verify that our assess button is now hidden.
    expect(find.byKey(const Key('AssessButton')).hitTestable(), findsNothing);
  });
}
