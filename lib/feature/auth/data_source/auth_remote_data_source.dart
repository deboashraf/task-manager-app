import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/feature/auth/model/user_model.dart';

class AuthRemoteDataSource {
  static final Logger logger =Logger();
  final DioService dioService;


  AuthRemoteDataSource(this.dioService);
  Future<UserModel> login(String username, String password) async {
  logger.e("calling API...");

  final response = await dioService.dio.post(
    'auth/login',
    data: {
      "username": username.trim(),
      "password": password.trim(),
      "expiresInMins": 30,
    },
    options: Options(
      contentType: Headers.jsonContentType,
    ),
  );

  logger.e("Response:");
  logger.e(response.data);

  return UserModel.fromJson(response.data);
}

Future<UserModel> register(
  String name,
  String email,
  String password,
) async {
  final response = await dioService.dio.post(
    'users/add',
    data: {
      "firstName": name,
      "email": email,
      "password": password,
    },
  );

  return UserModel(
    id: response.data['id'],
    username: name,
    email: email,
    accessToken: "dummy_token",
  );
}

}