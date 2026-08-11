import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/screens/main/main_navigation_screen.dart';

void main() {
  Future<void> openSettings(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigationScreen()));
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();
  }

  bool switchValue(WidgetTester tester, Key key) =>
      tester.widget<SwitchListTile>(find.byKey(key)).value;

  testWidgets('opens notification settings with enabled defaults', (
    tester,
  ) async {
    await openSettings(tester);

    expect(find.text('Trip reminders'), findsOneWidget);
    expect(find.text('Group updates'), findsOneWidget);
    expect(find.text('General notifications'), findsOneWidget);
    expect(switchValue(tester, const Key('tripRemindersSwitch')), isTrue);
    expect(switchValue(tester, const Key('groupUpdatesSwitch')), isTrue);
    expect(
      switchValue(tester, const Key('generalNotificationsSwitch')),
      isTrue,
    );
  });

  testWidgets('saves notification settings and retains them when reopened', (
    tester,
  ) async {
    await openSettings(tester);

    await tester.tap(find.byKey(const Key('tripRemindersSwitch')));
    await tester.tap(find.byKey(const Key('generalNotificationsSwitch')));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Notification settings updated'), findsOneWidget);
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    expect(switchValue(tester, const Key('tripRemindersSwitch')), isFalse);
    expect(switchValue(tester, const Key('groupUpdatesSwitch')), isTrue);
    expect(
      switchValue(tester, const Key('generalNotificationsSwitch')),
      isFalse,
    );
  });

  testWidgets('cancel discards notification setting changes', (tester) async {
    await openSettings(tester);

    await tester.tap(find.byKey(const Key('groupUpdatesSwitch')));
    await tester.tap(find.byTooltip('Cancel'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    expect(switchValue(tester, const Key('groupUpdatesSwitch')), isTrue);
  });

  testWidgets('back navigation discards notification setting changes', (
    tester,
  ) async {
    await openSettings(tester);

    await tester.tap(find.byKey(const Key('tripRemindersSwitch')));
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Notifications'));
    await tester.pumpAndSettle();

    expect(switchValue(tester, const Key('tripRemindersSwitch')), isTrue);
  });
}
