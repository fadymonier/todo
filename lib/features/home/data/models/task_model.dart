class TaskModel {
  String id;
  String title;
  String description;
  bool isDone;
  int date;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
          title: json['title'],
          description: json['description'],
          date: json['date'],
          isDone: json['isDone'],
          id: json['id'],
        );

  // TaskModel fromJson(Map<String, dynamic> json) {
  //   return TaskModel(
  //     title: json['title'],
  //     description: json['description'],
  //     date: json['date'],
  //     isDone: json['isDone'],
  //     id: json['id'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "description": description,
      "date": date,
      "isDone": isDone,
      "id": id
    };
  }
}
