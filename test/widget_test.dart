import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/features/home/data/models/task_model.dart';
import 'package:todo/features/home/presentation/pages/home.dart';
import 'package:todo/features/home/presentation/widgets/task_item.dart';

// Mock classes
class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Widget Tests', () {
    late MockFirebaseFunctions mockFirebaseFunctions;

    setUp(() {
      mockFirebaseFunctions = MockFirebaseFunctions();
    });

    testWidgets('HomeScreen displays tasks', (WidgetTester tester) async {
      // Arrange
      final task = TaskModel(
          id: '1',
          title: 'Test Task',
          description: 'Test Description',
          isDone: false,
          date: 4541);
      final taskStream = Stream.value([
        QueryDocumentSnapshot<TaskModel>(
          id: '1',
          data: task,
          reference: FirebaseFirestore.instance.collection('Tasks').doc('1'),
          metadata: SnapshotMetadata(false, false),
        )
      ]);

      when(mockFirebaseFunctions.getTasks(any)).thenAnswer((_) => taskStream);

      await tester.pumpWidget(
        ChangeNotifierProvider<FirebaseFunctions>.value(
          value: mockFirebaseFunctions,
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      // Assert
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Taskaty'), findsOneWidget);
      expect(find.text('No Tasks!'), findsNothing);

      // Act
      await tester.pump();

      // Assert
      expect(find.byType(TaskItem), findsOneWidget);
      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('TaskItem shows task details and handles done action',
        (WidgetTester tester) async {
      // Arrange
      final task = TaskModel(
          id: '1',
          title: 'Test Task',
          description: 'Test Description',
          isDone: false,
          date: 4554);

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

      // Assert
      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);

      final doneIcon = find.byIcon(Icons.done);
      expect(doneIcon, findsOneWidget);

      // Act
      await tester.tap(doneIcon);
      await tester.pump();

      // Assert
      verify(mockFirebaseFunctions.markTaskAsDone(task.id)).called(1);
    });

    testWidgets('HomeScreen opens bottom sheet on add button tap',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ChangeNotifierProvider<FirebaseFunctions>.value(
          value: mockFirebaseFunctions,
          child: MaterialApp(home: HomeScreen()),
        ),
      );

      // Assert
      expect(find.byType(FloatingActionButton), findsOneWidget);

      // Act
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Assert
      expect(find.byType(BottomSheet), findsOneWidget);
    });
  });
}
