import 'package:cloud_firestore/cloud_firestore.dart';

import '../../features/home/data/models/task_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> addTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Stream<QuerySnapshot<TaskModel>> getTasks(DateTime date) {
    // Start and end timestamps for the selected date
    var startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0)
        .millisecondsSinceEpoch;
    var endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59)
        .millisecondsSinceEpoch;

    return getTasksCollection()
        .where("date", isGreaterThanOrEqualTo: startOfDay)
        .where("date", isLessThanOrEqualTo: endOfDay)
        .snapshots();
  }

  static Future<void> deleteTask(String taskId) {
    var collection = getTasksCollection();
    return collection.doc(taskId).delete();
  }

  static Future<void> editTask(TaskModel task) {
    var collection = getTasksCollection();
    return collection.doc(task.id).set(task);
  }

  static Future<void> markTaskAsDone(String taskId, bool isDone) {
    var collection = getTasksCollection();
    return collection.doc(taskId).update({'isDone': isDone});
  }
}
