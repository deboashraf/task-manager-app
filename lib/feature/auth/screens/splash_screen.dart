import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manger/core/network/dio_server.dart';

class SplashScreen extends StatefulWidget {
  final DioService dioService;
  const SplashScreen({super.key, required this.dioService});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    checkLogin();
  }

  Future<void>checkLogin()async{
    final pref =await SharedPreferences.getInstance();
    final token =pref.getString('token');

    await Future.delayed(Duration(seconds: 1));
    if (token!=null){
      context.go('/root');
    }else{
      context.go('/login');
    }
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}