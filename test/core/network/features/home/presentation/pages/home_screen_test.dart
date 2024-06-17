import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/features/home/presentation/pages/home.dart';
import 'package:todo/features/home/presentation/widgets/bottom_sheet.dart';

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

void main() {
  testWidgets('HomeScreen loads and displays tasks',
      (WidgetTester tester) async {
    final mockFirebaseFunctions = MockFirebaseFunctions();

    await tester.pumpWidget(
      ChangeNotifierProvider<FirebaseFunctions>.value(
        value: mockFirebaseFunctions,
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Taskaty'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that the bottom sheet is opened
    expect(find.byType(MyBottomSheet), findsOneWidget);
  });

  // Add more tests for different functionalities of HomeScreen as needed
}
