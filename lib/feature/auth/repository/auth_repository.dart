import 'package:task_manger/feature/auth/data_source/auth_remote_data_source.dart';
import 'package:task_manger/feature/auth/model/user_model.dart';

class AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepository(this.remoteDataSource);

  Future<UserModel>login(String username, String password)async{
    return await remoteDataSource.login(username, password);
  }

  Future<UserModel> register(
  String name,
  String email,
  String password,
) async {
  return await remoteDataSource.register(
    name,
    email,
    password,
  );
}

}