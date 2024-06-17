import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/widgets/task_item.dart';

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

void main() {
  testWidgets('TaskItem shows task details and handles done action',
      (WidgetTester tester) async {
    final task = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isDone: false,
        date: 5451);
    final mockFirebaseFunctions = MockFirebaseFunctions();

    await tester.pumpWidget(
      ChangeNotifierProvider<FirebaseFunctions>.value(
        value: mockFirebaseFunctions,
        child: MaterialApp(
          home: Scaffold(
            body: TaskItem(model: task),
          ),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('Test Description'), findsOneWidget);

    final doneIcon = find.byIcon(Icons.done);
    expect(doneIcon, findsOneWidget);

    await tester.tap(doneIcon);
    await tester.pump();

    // Verify that the task is marked as done
    verify(mockFirebaseFunctions.markTaskAsDone(task.id)).called(1);
  });
}
