import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/auth/model/user_model.dart';

class AuthRemoteDataSource {
  final DioService dioService;

  AuthRemoteDataSource(this.dioService);
  Future<UserModel> login(String username, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (username == "emilys" && password == "emilyspass") {
      return UserModel(
        id: 1,
        username: "emilys",
        email: "emily@test.com",
        accessToken: "dummy_token",
      );
    }

    throw Exception("Invalid credentials");
  }

  Future<UserModel> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return UserModel(
      id: DateTime.now().millisecondsSinceEpoch,
      username: name,
      email: email,
      accessToken: "dummy_token",
    );
  }
}
