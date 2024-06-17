// ignore_for_file: must_be_immutable, subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/core/network/firebase_functions.dart';
import 'package:todo/features/home/data/models/task_model.dart';

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<TaskModel> {}

class MockDocumentReference extends Mock
    implements DocumentReference<TaskModel> {}

void main() {
  late MockFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;
  late FirebaseFunctions firebaseFunctions;

  setUp(() {
    mockFirestore = MockFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();

    when(mockFirestore.collection(any)).thenReturn(
        mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockCollection.doc(any)).thenReturn(mockDocument);

    firebaseFunctions = FirebaseFunctions();
  });

  test('Add Task', () async {
    final task = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isDone: false,
        date: 545);

    await FirebaseFunctions.addTask(task);

    verify(mockDocument.set(task)).called(1);
  });

  test('Delete Task', () async {
    const taskId = '1';

    await FirebaseFunctions.deleteTask(taskId);

    verify(mockDocument.delete()).called(1);
  });

  test('Edit Task', () async {
    final task = TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        isDone: false,
        date: 222);

    await FirebaseFunctions.editTask(task);

    verify(mockDocument.set(task)).called(1);
  });

  // Add more tests for other functions as needed
}
