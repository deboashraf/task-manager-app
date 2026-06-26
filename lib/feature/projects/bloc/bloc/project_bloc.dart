import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manger/feature/projects/bloc/bloc/project_event.dart';
import 'package:task_manger/feature/projects/bloc/bloc/project_state.dart';
import 'package:task_manger/feature/projects/repository/project_repository.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepository repository;

  ProjectBloc(this.repository) : super(ProjectInitial()) {
    on<ProjectEvent>((event, emit) async {
      emit(ProjectLoading());
      try {
        final projects = await repository.getProjects();
        emit(ProjectSuccess(projects));
      } catch (e) {
        print("PROJECT ERROR:");
        print(e);

        emit(ProjectError(e.toString()));
      }
    });
  }
}
