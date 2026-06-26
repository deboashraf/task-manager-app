import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://dummyjson.com/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  );

  DioService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }
}