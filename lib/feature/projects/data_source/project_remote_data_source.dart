import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/projects/model/project_model.dart';

class ProjectRemoteDataSource {
  final DioService dioService;

  ProjectRemoteDataSource(this.dioService);
  Future<List<ProjectModel>>getProjects()async{
    final response =await dioService.dio.get('products');
    final List data =response.data['products'];
    return data.map((e)=>ProjectModel.fromjson(e)).toList();
  }
}