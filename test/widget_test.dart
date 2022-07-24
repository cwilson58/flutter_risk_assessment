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
  testWidgets('Assess first page to Green or Yellow',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    // Verify that our app has started and the button exists
    //expect(find.byKey(Key('AssessButton')), findsOneWidget);
    // Tap the 'assess' button and trigger a frame.
    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();

    //tap no risk +
    await tester.tap(find.byKey(const Key('NoInc')));
    await tester.pump();
    //confirm that we are in the green
    //expect(find.text('Metric Risk: Green', findRichText: true).hitTestable(),findsOneWidget);
    //tap no risk -
    await tester.tap(find.byKey(const Key('NoDec')));
    await tester.pump();
    //confirm we are back to red

    //repeat for yellow state
    await tester.tap(find.byKey(const Key('LowInc')));
    await tester.pump();
    //expect(find.text('Yellow', findRichText: true).hitTestable(), findsOneWidget);
    await tester.tap(find.byKey(const Key('LowDec')));
    await tester.pump();
  });
  //Test page navigation
  testWidgets('Test Page Navigation', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('NextPage')));
    await tester.pump();

    //find and confirm page number
    expect(find.text('2/5'), findsOneWidget);

    await tester.tap(find.byKey(const Key('NextPage')));
    await tester.pump();

    //find next page number
    expect(find.text('3/5'), findsOneWidget);
    await tester.tap(find.byKey(const Key('PrevPage')));
    await tester.pump();

    //find page number
    expect(find.text('2/5'), findsOneWidget);
  });
  //Test that total risk changes
  testWidgets('Total Risk Updates', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('NoInc')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('NextPage')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('NoInc')));
    await tester.pump();

    //check that the state is YELLOW
  });
}
