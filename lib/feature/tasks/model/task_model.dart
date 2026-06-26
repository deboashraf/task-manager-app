class TaskModel {
  final String title;
  bool isDone;
  final String priority; 

  TaskModel({
    required this.title,
    this.isDone = false,
    required this.priority,
  });
}