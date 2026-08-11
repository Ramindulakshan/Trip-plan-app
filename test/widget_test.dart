import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';

void main() {
  testWidgets('shows splash then login screen', (tester) async {
    await tester.pumpWidget(const TripPlanApp());
    expect(find.text('Trip Plan'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
  });

  testWidgets('hardcoded login opens main navigation', (tester) async {
    await tester.pumpWidget(const TripPlanApp());
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('loginEmail')),
      'demo@tripplan.com',
    );
    await tester.enterText(find.byKey(const Key('loginPassword')), 'trip123');
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Where to next?'), findsOneWidget);
    expect(find.text('Trips'), findsWidgets);
    expect(find.text('Groups'), findsWidgets);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('invalid login displays an error', (tester) async {
    await tester.pumpWidget(const LoginScreen());
    await tester.enterText(
      find.byKey(const Key('loginEmail')),
      'wrong@example.com',
    );
    await tester.enterText(
      find.byKey(const Key('loginPassword')),
      'wrong-password',
    );
    await tester.tap(find.text('Log in'));
    await tester.pump();

    expect(find.textContaining('Incorrect email or password'), findsOneWidget);
  });
}
