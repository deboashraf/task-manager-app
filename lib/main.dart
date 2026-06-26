import 'package:flutter/material.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/core/utils/app_router.dart';

void main() {
  final dioService = DioService();
  runApp(MyApp(dioService: dioService));
}

class MyApp extends StatelessWidget {
  final DioService dioService;

  const MyApp({super.key, required this.dioService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router(dioService),
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xffF5F7FA),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xff121212),
      ),
    );
  }
}
