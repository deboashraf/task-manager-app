import 'package:flutter/material.dart';
import 'package:task_manger/core/network/dio_server.dart';
import 'package:task_manger/core/utils/app_router.dart';

void main() {
  final dioService =DioService();
  runApp( MyApp(dioService: dioService,));
}

class MyApp extends StatelessWidget {
  final DioService dioService;
  
  const MyApp({super.key, required this.dioService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router(dioService),
      title: "Task Manager",
      theme:ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
    );
  }
}