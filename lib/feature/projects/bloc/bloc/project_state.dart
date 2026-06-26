import 'package:task_manger/feature/projects/model/project_model.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectSuccess extends ProjectState {
  final List<ProjectModel> projects;

  ProjectSuccess(this.projects);
}

class ProjectError extends ProjectState{
  final String message;

  ProjectError( this.message);
  
}