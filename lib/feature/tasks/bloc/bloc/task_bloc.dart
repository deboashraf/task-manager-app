import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../model/task_model.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState([])) {

    on<AddTaskEvent>((event, emit) {
      final updated = List<TaskModel>.from(state.tasks)
        ..add(event.task);

      emit(TaskState(updated));
    });

    on<ToggleTaskEvent>((event, emit) {
      final updated = List<TaskModel>.from(state.tasks);

      updated[event.index].isDone =
          !updated[event.index].isDone;

      emit(TaskState(updated));
    });
  }
}