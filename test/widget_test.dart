// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:risk_assessment/main.dart';
import 'package:risk_assessment/riskCalculator.dart';

void main() {
  testWidgets('Assess button not visible during assessment',
      (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
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
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
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
    //Code from https://stackoverflow.com/questions/65885970/flutter-how-to-get-properly-richtext-data-when-testing
    final richText0Finder = find.byKey(
      ValueKey('RiskColour'),
    );
    final richText0Widget = tester.element(richText0Finder).widget as RichText;
    expect(((richText0Widget.text as TextSpan).children?[0] as TextSpan).text,
        'Green');
    //tap no risk -
    await tester.tap(find.byKey(const Key('NoDec')));
    await tester.pump();
    //confirm we are back to red
    final richText1Finder = find.byKey(
      ValueKey('RiskColour'),
    );
    final richText1Widget = tester.element(richText1Finder).widget as RichText;
    expect(((richText1Widget.text as TextSpan).children?[0] as TextSpan).text,
        'Red');
    //repeat for yellow state
    await tester.tap(find.byKey(const Key('LowInc')));
    await tester.pump();
    final richText2Finder = find.byKey(
      ValueKey('RiskColour'),
    );
    final richText2Widget = tester.element(richText2Finder).widget as RichText;
    expect(((richText2Widget.text as TextSpan).children?[0] as TextSpan).text,
        'Yellow');
    await tester.tap(find.byKey(const Key('LowDec')));
    await tester.pump();
  });
  //Test page navigation
  testWidgets('Test Page Navigation', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
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
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
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
    final richText2Finder = find.byKey(
      ValueKey('TotalRisk'),
    );
    final richText2Widget = tester.element(richText2Finder).widget as RichText;
    expect(((richText2Widget.text as TextSpan).children?[0] as TextSpan).text,
        'Yellow');
  });
  //Test for phase 2
  testWidgets('Can Enter Edit for First Metric', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    await tester.pumpWidget(MyApp());

    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();

    await tester.tap(find.byKey(const Key('EditButton')));
    await tester.pump();

    expect(
        ((tester.element(find.byKey(const Key('EditButton'))).widget
                    as TextButton)
                .child as Text)
            .data,
        'Save'); //if button is now save, we must have entered the edit state
  });
  testWidgets('Edits Save for First Metric After leaving Edit State',
      (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byKey(const Key('AssessButton')));
    await tester.pump();
    await tester.tap(find.byKey(const Key('EditButton')));
    await tester.pump();

    //Edit the metricName, then make sure it changes
    await tester.enterText(find.byKey(Key('MetricNameEditable')), 'Test Name');
    await tester.pump();
    // save the state
    await tester.tap(find.byKey(const Key('EditButton')));
    await tester.pump();
    expect(find.text('Test Name').hitTestable(), findsOneWidget);
  });
  testWidgets('Add a new metric', (WidgetTester tester) async {
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue = Size(1920, 1080);
    await tester.pumpWidget(MyApp());
    await tester.tap(find.byKey(const Key('AddMetricButton')));
    await tester.pump();

    expect(find.text('Metric Name').hitTestable(),findsOneWidget);

  });
  //Not previously covered state tests
}
//  testWidgets('', (WidgetTester tester) async {});
