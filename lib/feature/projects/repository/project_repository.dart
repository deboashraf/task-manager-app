import 'package:task_manger/feature/projects/data_source/project_remote_data_source.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';

class ProjectRepository {
  final ProjectRemoteDataSource remoteDataSource;

  ProjectRepository( this.remoteDataSource);

  Future<List<ProjectModel>>getProjects()async{
    return await remoteDataSource.getProjects();
  }

}
