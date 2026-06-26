import 'package:task_manger/feature/tasks/model/task_model.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  AddTaskEvent(this.task);
}

class ToggleTaskEvent extends TaskEvent {
  final int index;

  ToggleTaskEvent(this.index);
}