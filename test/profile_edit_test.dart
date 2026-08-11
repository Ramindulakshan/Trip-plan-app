import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/screens/main/main_navigation_screen.dart';

void main() {
  Future<void> openEditor(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigationScreen()));
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit profile'));
    await tester.pumpAndSettle();
  }

  testWidgets('opens editor with the current profile values', (tester) async {
    await openEditor(tester);

    expect(find.text('Edit profile'), findsOneWidget);
    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('editProfileName')))
          .controller
          ?.text,
      'Alex Traveller',
    );
    expect(
      tester
          .widget<TextFormField>(find.byKey(const Key('editProfileEmail')))
          .controller
          ?.text,
      'demo@tripplan.com',
    );
  });

  testWidgets('validates the name and email fields', (tester) async {
    await openEditor(tester);

    await tester.enterText(find.byKey(const Key('editProfileName')), '');
    await tester.enterText(
      find.byKey(const Key('editProfileEmail')),
      'invalid',
    );
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Enter your name'), findsOneWidget);
    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Edit profile'), findsOneWidget);
  });

  testWidgets('cancel discards profile changes', (tester) async {
    await openEditor(tester);

    await tester.enterText(
      find.byKey(const Key('editProfileName')),
      'Changed Name',
    );
    await tester.enterText(
      find.byKey(const Key('editProfileEmail')),
      'changed@example.com',
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(find.text('Alex Traveller'), findsOneWidget);
    expect(find.text('demo@tripplan.com'), findsOneWidget);
    expect(find.text('Changed Name'), findsNothing);
  });

  testWidgets('save refreshes the profile and avatar initial', (tester) async {
    await openEditor(tester);

    await tester.enterText(
      find.byKey(const Key('editProfileName')),
      'Jamie Explorer',
    );
    await tester.enterText(
      find.byKey(const Key('editProfileEmail')),
      'jamie@example.com',
    );
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Jamie Explorer'), findsOneWidget);
    expect(find.text('jamie@example.com'), findsOneWidget);
    expect(find.text('J'), findsOneWidget);
    expect(find.text('Profile updated successfully'), findsOneWidget);
  });
}
